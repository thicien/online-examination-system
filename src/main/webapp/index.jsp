<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // If user is already logged in, redirect to dashboard
    if (session.getAttribute("user") != null) {
        response.sendRedirect("student_dashboard.jsp");
        return;
    }
    if (session.getAttribute("admin") != null) {
        response.sendRedirect("admin_dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Online Examination System - Home</title>
    <link rel="stylesheet" type="text/css" href="css/home.css">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Header / Navbar -->
    <div class="navbar">
        <div class="logo">
            <span style="color:#3498db; margin-right:5px;">📝</span> OES
        </div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">About</a>
            <a href="#">Contact</a>
            <a href="login.jsp">Login</a>
            <a href="register.jsp" class="nav-btn">Register</a>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <div class="hero-content">
            <h1>Online Examination System</h1>
            <p>A secure, efficient, and user-friendly platform for conducting online examinations and assessments anytime, anywhere.</p>
            <div class="cta-buttons">
                <a href="login.jsp" class="btn btn-primary">Get Started</a>
                <a href="register.jsp" class="btn btn-secondary">Create Account</a>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="features">
        <div class="section-title">Why Choose OES?</div>
        <div class="features-grid">
            <div class="feature-card">
                <span class="feature-icon">📝</span>
                <h3>Online Exams</h3>
                <p>Take exams from the comfort of your home with our secure and reliable platform.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">⏱️</span>
                <h3>Time Management</h3>
                <p>Automatic timers ensure exams are completed within the stipulated time, promoting fairness.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">📊</span>
                <h3>Instant Results</h3>
                <p>Get detailed results and performance analysis immediately after submitting your exam.</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">🔐</span>
                <h3>Secure Access</h3>
                <p>Role-based access control grants specific privileges to Admins and Students.</p>
            </div>
        </div>
    </div>

    <!-- How It Works Section -->
    <div class="how-it-works">
        <div class="section-title">How It Works</div>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Register</h3>
                <p>Create your student account in seconds.</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Login</h3>
                <p>Access your dashboard securely.</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Take Exam</h3>
                <p>Select an exam and attempt the questions.</p>
            </div>
            <div class="step">
                <div class="step-number">4</div>
                <h3>View Results</h3>
                <p>See your score and review your answers instantly.</p>
            </div>
        </div>
    </div>

    <!-- Call To Action -->
    <div class="cta-section">
        <h2>Ready to start your journey?</h2>
        <div class="cta-buttons">
            <a href="login.jsp" class="btn btn-primary" style="background-color: #27ae60;">Login Now</a>
            <a href="register.jsp" class="btn btn-secondary" style="border-color: #fff; color: #fff;">Join Us</a>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

</body>
</html>
