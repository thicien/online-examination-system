package com.oes.controller;

import com.oes.dao.AdminDao;
import com.oes.dao.UserDao;
import com.oes.model.Admin;
import com.oes.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    
    private UserDao userDao = new UserDao();
    private AdminDao adminDao = new AdminDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            login(request, response);
        } else if ("register".equals(action)) {
            register(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp");
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String emailOrUser = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Try Admin Login
        Admin admin = adminDao.loginAdmin(emailOrUser, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("role", "admin");
            response.sendRedirect("admin_dashboard.jsp");
            return;
        }

        // Try User Login
        User user = userDao.loginUser(emailOrUser, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", "student");
            response.sendRedirect("student_dashboard.jsp");
            return;
        }

        response.sendRedirect("index.jsp?error=Invalid Credentials");
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        if (userDao.registerUser(user)) {
            response.sendRedirect("index.jsp?msg=Registration Successful");
        } else {
            response.sendRedirect("register.jsp?error=Registration Failed");
        }
    }
}
