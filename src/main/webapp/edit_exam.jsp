<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oes.dao.ExamDao" %>
<%@ page import="com.oes.model.Exam" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("admin_exams.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);
    ExamDao dao = new ExamDao();
    Exam exam = dao.getExamById(id);
    if (exam == null) {
        response.sendRedirect("admin_exams.jsp?err=ExamNotFound");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Exam - OES Administration</title>
    <link rel="stylesheet" type="text/css" href="css/admin.css">
    <style>
        .form-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 0 auto;
            overflow: hidden;
        }
        .form-header {
            background: #007bff;
            color: white;
            padding: 20px 30px;
            border-bottom: 1px solid #e0e0e0;
        }
        .form-header h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
        }
        .form-body {
            padding: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: 4px;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-sizing: border-box; /* Fix width issues */
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
            outline: none;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 600;
            transition: background 0.2s;
            display: inline-block;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
        .help-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    
    <!-- Sidebar -->
    <jsp:include page="admin_sidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <jsp:include page="admin_header.jsp" />

        <div class="content-area">
            
            <div class="form-card">
                <div class="form-header">
                    <h2>Edit Exam Details</h2>
                </div>
                
                <form action="admin" method="post" class="form-body">
                    <input type="hidden" name="action" value="updateExam">
                    <input type="hidden" name="examId" value="<%= exam.getId() %>">
                    
                    <div class="form-group">
                        <label class="form-label">Exam Name</label>
                        <input type="text" name="examName" class="form-control" value="<%= exam.getName() %>" required placeholder="e.g. Final Semester Java Exam">
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div class="form-group">
                            <label class="form-label">Duration (minutes)</label>
                            <input type="number" name="duration" class="form-control" value="<%= exam.getDuration() %>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Total Marks</label>
                            <input type="number" name="totalMarks" class="form-control" value="<%= exam.getTotalMarks() %>" required>
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div class="form-group">
                            <label class="form-label">Start Time</label>
                            <input type="datetime-local" name="startTime" class="form-control" value="<%= exam.getStartTime() != null ? exam.getStartTime() : "" %>" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">End Time</label>
                            <input type="datetime-local" name="endTime" class="form-control" value="<%= exam.getEndTime() != null ? exam.getEndTime() : "" %>" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Exam Password <span style="font-weight: normal; color: #888;">(Optional)</span></label>
                        <input type="text" name="password" class="form-control" value="<%= exam.getPassword() != null ? exam.getPassword() : "" %>" placeholder="Leave empty for open access">
                        <div class="help-text">Adding a password restricts access to students who know it.</div>
                    </div>

                    <div class="form-actions">
                        <a href="admin_exams.jsp" class="btn-cancel">Cancel</a>
                        <button type="submit" class="btn-submit">Save Changes</button>
                    </div>
                </form>
            </div> 
            
        </div> <!-- Close content-area -->
        <%@ include file="footer.jsp" %>
    </div> <!-- Close main-content -->
</body>
</html>
