package com.oes.controller;

import com.oes.dao.ExamDao;
import com.oes.dao.QuestionDao;
import com.oes.model.Exam;
import com.oes.model.Question;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    
    private ExamDao examDao = new ExamDao();
    private QuestionDao questionDao = new QuestionDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("addExam".equals(action)) {
            addExam(request, response);
        } else if ("addQuestion".equals(action)) {
            addQuestion(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
         if ("deleteExam".equals(action)) {
            deleteExam(request, response);
        }
    }

    private void addExam(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("examName");
        int duration = Integer.parseInt(request.getParameter("duration"));
        int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));

        Exam exam = new Exam();
        exam.setName(name);
        exam.setDuration(duration);
        exam.setTotalMarks(totalMarks);

        examDao.addExam(exam);
        response.sendRedirect("admin_dashboard.jsp?msg=Exam Added");
    }

    private void deleteExam(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        examDao.deleteExam(id);
        response.sendRedirect("admin_dashboard.jsp?msg=Exam Deleted");
    }

    private void addQuestion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int examId = Integer.parseInt(request.getParameter("examId"));
        String text = request.getParameter("questionText");
        String optA = request.getParameter("optionA");
        String optB = request.getParameter("optionB");
        String optC = request.getParameter("optionC");
        String optD = request.getParameter("optionD");
        String correct = request.getParameter("correctOption");

        Question q = new Question();
        q.setExamId(examId);
        q.setText(text);
        q.setOptionA(optA);
        q.setOptionB(optB);
        q.setOptionC(optC);
        q.setOptionD(optD);
        q.setCorrectOption(correct);

        questionDao.addQuestion(q);
        response.sendRedirect("add_question.jsp?examId=" + examId + "&msg=Question Added");
    }
}
