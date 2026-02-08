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
        System.out.println("DEBUG: AdminController doPost action: " + action);
        
        if ("addExam".equals(action)) {
            addExam(request, response);
        } else if ("addQuestion".equals(action)) {
            addQuestion(request, response);
        } else if ("updateExam".equals(action)) {
            updateExam(request, response);
        } else if ("updateQuestion".equals(action)) {
            System.out.println("DEBUG: Dispatching to updateQuestion...");
            updateQuestion(request, response);
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
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String password = request.getParameter("password");

        System.out.println("AdminController: Adding Exam - Name: " + name + ", Start: " + startTime + ", End: " + endTime + ", Pass: " + password);

        if (startTime != null) startTime = startTime.replace("T", " ");
        if (endTime != null) endTime = endTime.replace("T", " ");

        Exam exam = new Exam();
        exam.setName(name);
        exam.setDuration(duration);
        exam.setTotalMarks(totalMarks);
        exam.setStartTime(startTime);
        exam.setEndTime(endTime);
        exam.setPassword(password);

        boolean success = examDao.addExam(exam);
        System.out.println("AdminController: Exam Add Result: " + success);
        response.sendRedirect("admin_dashboard.jsp?msg=Exam Added");
    }

    private void updateExam(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("examId"));
        String name = request.getParameter("examName");
        int duration = Integer.parseInt(request.getParameter("duration"));
        int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String password = request.getParameter("password");

        if (startTime != null) startTime = startTime.replace("T", " ");
        if (endTime != null) endTime = endTime.replace("T", " ");

        Exam exam = new Exam();
        exam.setId(id);
        exam.setName(name);
        exam.setDuration(duration);
        exam.setTotalMarks(totalMarks);
        exam.setStartTime(startTime);
        exam.setEndTime(endTime);
        exam.setPassword(password);

        examDao.updateExam(exam);
        response.sendRedirect("admin_exams.jsp?msg=Exam Updated");
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
        int marks = Integer.parseInt(request.getParameter("marks"));

        Question q = new Question();
        q.setExamId(examId);
        q.setText(text);
        q.setOptionA(optA);
        q.setOptionB(optB);
        q.setOptionC(optC);
        q.setOptionD(optD);
        q.setCorrectOption(correct);
        q.setMarks(marks);

        questionDao.addQuestion(q);
        response.sendRedirect("add_question.jsp?examId=" + examId + "&msg=Question Added");
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            System.out.println("DEBUG: Inside updateQuestion");
            int id = Integer.parseInt(request.getParameter("questionId"));
            int examId = Integer.parseInt(request.getParameter("examId"));
            String text = request.getParameter("questionText");
            String optA = request.getParameter("optionA");
            String optB = request.getParameter("optionB");
            String optC = request.getParameter("optionC");
            String optD = request.getParameter("optionD");
            String correct = request.getParameter("correctOption");
            int marks = Integer.parseInt(request.getParameter("marks"));

            System.out.println("DEBUG: Updating Question ID: " + id + ", ExamID: " + examId + ", Marks: " + marks);

            Question q = new Question();
            q.setId(id);
            q.setExamId(examId);
            q.setText(text);
            q.setOptionA(optA);
            q.setOptionB(optB);
            q.setOptionC(optC);
            q.setOptionD(optD);
            q.setCorrectOption(correct);
            q.setMarks(marks);

            boolean success = questionDao.updateQuestion(q);
            System.out.println("DEBUG: Update success: " + success);
            
            response.sendRedirect("add_question.jsp?examId=" + examId + "&msg=Question Updated");
        } catch (Exception e) {
            System.err.println("ERROR in updateQuestion: " + e.getMessage());
            e.printStackTrace();
            // Try to recover examId if possible
            String examId = request.getParameter("examId");
            if (examId != null) {
                 response.sendRedirect("add_question.jsp?examId=" + examId + "&err=UpdateException");
            } else {
                 response.sendRedirect("admin_dashboard.jsp?err=UpdateException");
            }
        }
    }
}
