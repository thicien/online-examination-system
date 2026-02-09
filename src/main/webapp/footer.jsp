<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- FontAwesome CDN -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    /* Inline critical footer styles - Compact Version */
    .main-footer {
        background-color: #111827 !important; 
        color: #9ca3af !important;
        padding: 30px 20px !important; /* Reduced padding */
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin-top: auto;
        width: 100%;
        box-sizing: border-box;
        font-size: 0.9rem; /* Smaller base font */
    }

    .footer-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px; /* Reduced gap */
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-col h3 {
        color: #0ea5e9 !important;
        font-size: 1rem !important; /* Smaller headers */
        margin-bottom: 15px; /* Reduced margin */
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .footer-col p {
        line-height: 1.5;
        margin-bottom: 10px;
        color: #9ca3af !important;
    }

    .footer-col ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-col ul li {
        margin-bottom: 8px; /* Tighter list items */
    }

    .footer-col ul li a {
        color: #9ca3af !important;
        text-decoration: none;
        transition: color 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .footer-col ul li a:hover {
        color: #0ea5e9 !important;
        padding-left: 5px;
    }

    /* Social Icons - Smaller */
    .social-icons {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }

    .social-icon {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 32px; /* Smaller icons */
        height: 32px;
        background-color: #1f2937;
        color: #fff !important;
        border-radius: 4px;
        text-decoration: none;
        transition: all 0.3s ease;
        font-size: 0.9rem;
    }

    .social-icon:hover {
        background-color: #0ea5e9;
        transform: translateY(-2px);
    }

    .footer-bottom {
        background-color: #030712 !important;
        color: #6b7280 !important;
        text-align: center;
        padding: 15px 20px; /* Reduced padding */
        font-size: 0.8rem; /* Smaller text */
        border-top: 1px solid #1f2937;
    }
</style>

<div class="main-footer">
    <div class="footer-container">
        <!-- Column 1: Project Identity -->
        <div class="footer-col">
            <h3>Online Examination System</h3>
            <p>A secure web-based platform designed to manage, conduct, and evaluate online examinations efficiently.</p>
        </div>

        <!-- Column 2: Info -->
        <div class="footer-col">
            <h3>Info</h3>
            <ul>
                <li><a href="#">Online Examination Platform</a></li>
                <li><a href="#">Admin & Student Modules</a></li>
                <li><a href="#">Automatic Exam Evaluation</a></li>
                <li><a href="#">Secure Result Management</a></li>
            </ul>
        </div>

        <!-- Column 3: Contact Us -->
        <div class="footer-col">
            <h3>Contact Us</h3>
            <ul>
                <li><i class="fa-solid fa-location-dot" style="color:#ef4444;"></i> Kigali, Rwanda</li>
                <li><i class="fa-solid fa-phone" style="color:#0ea5e9;"></i> +250 793 331 557</li>
                <li><i class="fa-solid fa-envelope" style="color:#eab308;"></i> mugishathicien04@gmail.com</li>
            </ul>
        </div>

        <!-- Column 4: Follow Us -->
        <div class="footer-col">
            <h3>Follow Us</h3>
            <div class="social-icons">
                <a href="#" class="social-icon" title="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" class="social-icon" title="X (Twitter)"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#" class="social-icon" title="GitHub"><i class="fa-brands fa-github"></i></a>
                <a href="#" class="social-icon" title="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                <a href="#" class="social-icon" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
            </div>
        </div>
    </div>
</div>

<div class="footer-bottom">
    <p>&copy; 2026 Online Examination System | Developed by MUGISHA Thicien</p>
</div>
