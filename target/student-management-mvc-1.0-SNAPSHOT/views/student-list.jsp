<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>

    <!-- GIỮ NGUYÊN CSS BẠN ĐÃ GỬI -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        /* === NAVBAR THÊM MỚI === */
        .navbar {
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-right { display: flex; align-items: center; gap: 20px; }
        .user-info { display: flex; gap: 10px; align-items: center; }
        .role-badge {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 12px;
            color: white;
            font-weight: bold;
        }
        .role-admin { background: #dc3545; }
        .role-user  { background: #6c757d; }

        .btn-nav { text-decoration: none; }
        .btn-logout {
            background: #dc3545; color: white;
            padding: 8px 14px; border-radius: 5px; text-decoration: none;
        }

        /* PHẦN CSS CŨ GIỮ NGUYÊN */
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-style: italic;
        }
        
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .pagination { margin: 20px 0; text-align: center; }
        .pagination a {
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            text-decoration: none;
            border-radius: 4px;
            color: #333;
        }
        .pagination strong {
            padding: 8px 12px;
            margin: 0 4px;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<!-- 🌟 NAVBAR RBAC (THÊM) -->
<div class="navbar">
    <h2>📚 Student Management System</h2>

    <div class="navbar-right">
        <div class="user-info">
            <span>Welcome, ${sessionScope.fullName}</span>
            <span class="role-badge role-${sessionScope.role}">
                ${sessionScope.role}
            </span>
        </div>

        <a href="dashboard" class="btn-nav">Dashboard</a>
        <a href="logout" class="btn-logout">Logout</a>
    </div>
</div>


<div class="container">

    <h1>📚 Student Management System</h1>
    <p class="subtitle">MVC Pattern with Jakarta EE & JSTL</p>

    <!-- SUCCESS -->
    <c:if test="${not empty param.message}">
        <div class="message success">✅ ${param.message}</div>
    </c:if>

    <!-- ERROR -->
    <c:if test="${not empty param.error}">
        <div class="message error">❌ ${param.error}</div>
    </c:if>


    <!-- ADD BUTTON (Admin only) -->
    <c:if test="${sessionScope.role eq 'admin'}">
        <div style="margin-bottom: 20px; display: flex; gap: 32px">
            <a href="${pageContext.request.contextPath}/student?action=new" class="btn btn-primary">
                ➕ Add New Student
            </a>
        </div>
    </c:if>

    <!-- SEARCH + FILTER (GIỮ NGUYÊN) -->
    <div style="margin-bottom: 20px; display: flex; gap: 32px">
        <form action="${pageContext.request.contextPath}/student" method="get">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" placeholder="Search by name, code, or email"
                   style="padding: 12px 24px; width: 250px; border-radius: 5px; border: 1px solid #ccc;">
            <button type="submit" class="btn btn-primary">🔍 Search</button>
        </form>
    </div>


    <!-- STUDENT TABLE ( giữ nguyên y chang + RBAC action column ) -->
    <c:choose>
        <c:when test="${not empty students}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Major</th>

                        <c:if test="${sessionScope.role eq 'admin'}">
                            <th>Actions</th>
                        </c:if>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td>${student.id}</td>
                            <td><strong>${student.studentCode}</strong></td>
                            <td>${student.fullName}</td>
                            <td>${student.email}</td>
                            <td>${student.major}</td>

                            <c:if test="${sessionScope.role eq 'admin'}">
                                <td>
                                    <div class="actions">
                                        <a href="student?action=edit&id=${student.id}" class="btn btn-secondary">✏️ Edit</a>
                                        <a href="student?action=delete&id=${student.id}" class="btn btn-danger"
                                           onclick="return confirm('Are you sure you want to delete this student?')">🗑️ Delete</a>
                                    </div>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>

        <c:otherwise>
            <div class="empty-state">
                <div class="empty-state-icon">📭</div>
                <h3>No students found</h3>
                <p>Start by adding a new student</p>
            </div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
