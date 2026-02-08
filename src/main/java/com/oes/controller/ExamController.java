package com.oes.controller;

import com.oes.dao.ExamDao;
import com.oes.dao.QuestionDao;
import com.oes.dao.ResultDao;
import com.oes.dao.StudentAnswerDao;
import com.oes.model.Exam;
import com.oes.model.Question;
import com.oes.model.Result;
import com.oes.model.StudentAnswer;
import com.oes.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/exam")
public class ExamController extends HttpServlet {
    
    private ExamDao examDao = new ExamDao();
    private QuestionDao questionDao = new QuestionDao();
    private ResultDao resultDao = new ResultDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("take".equals(action)) {
             // Redirect to instructions to ensure proper flow and password check
             String idStr = request.getParameter("id");
             response.sendRedirect("exam_instructions.jsp?examId=" + idStr);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("submit".equals(action)) {
            submitExam(request, response);
        } else if ("verifyPasswordAndStart".equals(action)) {
            verifyPasswordAndStart(request, response);
        }
    }

    private void verifyPasswordAndStart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int examId = Integer.parseInt(request.getParameter("id"));
        String inputPassword = request.getParameter("password");
        
        Exam exam = examDao.getExamById(examId);
        
        if (exam == null) {
            response.sendRedirect("student_exams.jsp");
            return;
        }

        // 1. Check Password
        if (exam.getPassword() != null && !exam.getPassword().trim().isEmpty()) {
            if (inputPassword == null || !inputPassword.equals(exam.getPassword())) {
                request.setAttribute("error", "Invalid Exam Password");
                // Forward back to instructions with error (need to set examId for instructions to load)
                // Actually instructions.jsp loads exam by param 'examId'.
                // So we can redirect with error or forward. Forward is better to keep error in request.
                // But instructions.jsp expects 'examId' param.
                // Let's redirect for simplicity or modify instructions to read attributes.
                // Redirection:
                response.sendRedirect("exam_instructions.jsp?examId=" + examId + "&error=Invalid Password");
                return;
            }
        }

        // 2. Load Questions and Forward to Take Exam
        List<Question> questions = questionDao.getQuestionsByExamId(examId);
        request.setAttribute("exam", exam);
        request.setAttribute("questions", questions);
        request.getRequestDispatcher("take_exam.jsp").forward(request, response);
    }

    private void submitExam(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int examId = Integer.parseInt(request.getParameter("examId"));
        
        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<Question> questions = questionDao.getQuestionsByExamId(examId);
        int score = 0;
        int totalQuestions = questions.size();
        
        StudentAnswerDao studentAnswerDao = new StudentAnswerDao();

        for (Question q : questions) {
            String selectedOption = request.getParameter("q_" + q.getId());
            boolean isCorrect = false;
            int marksObtained = 0;

            if (selectedOption != null && selectedOption.equals(q.getCorrectOption())) {
                score += q.getMarks();
                isCorrect = true;
                marksObtained = q.getMarks();
            }

            // Save Student Answer
            StudentAnswer answer = new StudentAnswer();
            answer.setUserId(user.getId());
            answer.setExamId(examId);
            answer.setQuestionId(q.getId());
            answer.setSelectedOption(selectedOption); // Can be null if not answered
            answer.setCorrect(isCorrect);
            answer.setMarksObtained(marksObtained);
            
            studentAnswerDao.saveAnswer(answer);
        }

        Result result = new Result();
        result.setUserId(user.getId());
        result.setExamId(examId);
        result.setScore(score);
        
        resultDao.saveResult(result);
        
        request.setAttribute("score", score);
        request.setAttribute("total", examDao.getExamById(examId).getTotalMarks());
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}
