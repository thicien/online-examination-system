package com.oes.controller;

import com.oes.dao.ExamDao;
import com.oes.dao.QuestionDao;
import com.oes.dao.ResultDao;
import com.oes.model.Exam;
import com.oes.model.Question;
import com.oes.model.Result;
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
            int examId = Integer.parseInt(request.getParameter("id"));
            Exam exam = examDao.getExamById(examId);
            List<Question> questions = questionDao.getQuestionsByExamId(examId);
            
            request.setAttribute("exam", exam);
            request.setAttribute("questions", questions);
            request.getRequestDispatcher("take_exam.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("submit".equals(action)) {
            submitExam(request, response);
        }
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
        int marksPerQ = totalQuestions > 0 ? (examDao.getExamById(examId).getTotalMarks() / totalQuestions) : 0; // Simple logic

        for (Question q : questions) {
            String selectedOption = request.getParameter("q_" + q.getId());
            if (selectedOption != null && selectedOption.equals(q.getCorrectOption())) {
                score += marksPerQ;
            }
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
