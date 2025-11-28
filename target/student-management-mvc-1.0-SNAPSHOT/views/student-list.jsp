<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en"> <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - MVC</title>
    <style>
        /* --- RESET & BASICS --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7f6; /* Lighter background for better contrast with content */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* --- ACCESSIBILITY UTILITIES --- */
        /* Hides text visually but keeps it available for screen readers */
        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border: 0;
        }

        /* --- NAVIGATION BAR --- */
        .main-nav {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 0 20px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px;
        }

        .nav-brand {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #555;
            font-weight: 500;
            font-size: 16px;
            padding: 8px 0;
            position: relative;
            transition: color 0.3s;
        }

        .nav-links a:hover, .nav-links a.active {
            color: #667eea;
        }

        /* Underline effect for active link */
        .nav-links a.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 2px;
        }

        /* --- MAIN LAYOUT --- */
        .main-content {
            flex: 1; /* Pushes footer down if you add one */
            padding: 40px 20px;
            background: linear-gradient(180deg, #eef2f3 0%, #ffffff 100%);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.05);
            border: 1px solid #eaeaea;
        }
        
        /* --- TYPOGRAPHY --- */
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
        
        /* --- ALERTS --- */
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
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
        
        /* --- BUTTONS & FORMS --- */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            transition: all 0.2s;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        /* Focus state for accessibility */
        .btn:focus, input:focus, select:focus, a:focus {
            outline: 3px solid rgba(102, 126, 234, 0.5);
            outline-offset: 2px;
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
            background-color: #f1f3f5;
            color: #495057;
        }
        
        .btn-secondary:hover {
            background-color: #e9ecef;
            color: #212529;
        }
        
        .btn-danger {
            background-color: #ffebee;
            color: #c62828;
            padding: 8px 16px;
            font-size: 13px;
        }
        
        .btn-danger:hover {
            background-color: #ffcdd2;
        }

        .controls-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }
        
        /* --- TABLE --- */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 20px;
        }
        
        thead {
            background: #f8f9fa;
        }
        
        th {
            color: #495057;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.5px;
            padding: 18px 15px;
            border-bottom: 2px solid #e9ecef;
            text-align: left;
        }

        /* Accessibility: Table header links */
        th a {
            color: inherit;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        td {
            padding: 18px 15px;
            border-bottom: 1px solid #eee;
            color: #444;
            vertical-align: middle;
        }
        
        tbody tr:hover {
            background-color: #fbfbfb;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        /* --- PAGINATION & EMPTY STATES --- */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
            display: block;
        }

        .pagination {
            margin-top: 30px;
            text-align: center;
            display: flex;
            justify-content: center;
            gap: 5px;
        }

        .pagination a, .pagination strong {
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }

        .pagination a {
            border: 1px solid #e9ecef;
            color: #555;
            transition: all 0.2s;
        }

        .pagination a:hover {
            background: #f8f9fa;
            border-color: #dee2e6;
        }

        .pagination strong {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: 1px solid transparent;
        }
    </style>
</head>
<body>

    <nav class="main-nav" aria-label="Main Navigation">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-brand">
                <span>🎓</span> EduManage
            </a>
            <ul class="nav-links">
                <li>
                    <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/student?action=list" class="active" aria-current="page">Students</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <div class="container">
            <header>
                <h1>Student Management</h1>
                <p class="subtitle">Manage enrollment, majors, and profiles</p>
            </header>
            
            <c:if test="${not empty param.message}">
                <div class="message success" role="alert">
                    <span>✅</span> ${param.message}
                </div>
            </c:if>
            
            <c:if test="${not empty param.error}">
                <div class="message error" role="alert">
                    <span>❌</span> ${param.error}
                </div>
            </c:if>
            
            <div class="controls-wrapper">
                <c:if test="${sessionScope.role eq 'admin'}">
                    <a href="${pageContext.request.contextPath}/student?action=new" class="btn btn-primary">
                        <span>➕</span> Add New Student
                    </a>
                </c:if>

                <form action="${pageContext.request.contextPath}/student" method="get" class="search-form" role="search">
                    <input type="hidden" name="action" value="search">
                    
                    <label for="search-input" class="sr-only">Search students</label>
                    <input type="text"
                           id="search-input"
                           name="keyword"
                           placeholder="Search by name, code..."
                           value="${keyword}"
                           style="padding: 10px 15px; border-radius: 5px; border: 1px solid #ccc; width: 220px;">
                    
                    <button type="submit" class="btn btn-primary" aria-label="Search">🔍</button>
                </form>
            </div>                      
                            
            <div style="margin-bottom: 20px;">
                <form action="student" method="get" style="display: flex; align-items: center; gap: 10px;">
                    <input type="hidden" name="action" value="filter">

                    <label for="major-filter"><strong>Filter by Major:</strong></label>

                    <select id="major-filter" name="major" style="padding: 10px; border-radius: 5px; border: 1px solid #ccc; min-width: 200px;">
                        <option value="">All Majors</option>
                        <option value="Ecommerce" ${selectedMajor == 'Ecommerce' ? 'selected' : ''}>Ecommerce</option>
                        <option value="Marketing" ${selectedMajor == 'Marketing' ? 'selected' : ''}>Marketing</option>
                        <option value="Computer Science" ${selectedMajor == 'Computer Science' ? 'selected' : ''}>Computer Science</option>
                        <option value="Data Science" ${selectedMajor == 'Data Science' ? 'selected' : ''}>Data Science</option>
                        <option value="Information Technology" ${selectedMajor == 'Information Technology' ? 'selected' : ''}>Information Technology</option>
                        <option value="Software Engineering" ${selectedMajor == 'Software Engineering' ? 'selected' : ''}>Software Engineering</option>
                        <option value="Business Administration" ${selectedMajor == 'Business Administration' ? 'selected' : ''}>Business Administration</option>
                    </select>

                    <button type="submit" class="btn btn-secondary">Apply</button>

                    <c:if test="${not empty selectedMajor}">
                        <a href="student?action=list" style="margin-left: 10px; color: #667eea; text-decoration: none;">Clear Filter</a>
                    </c:if>
                </form>
            </div>

            <c:choose>
                <c:when test="${not empty students}">
                    <div style="overflow-x: auto;">
                        <table>
                            <thead>
                                <tr>
                                    <th scope="col">
                                        <a href="student?action=sort&sortBy=id&order=${order == 'asc' ? 'desc' : 'asc'}">
                                            ID <c:if test="${sortBy == 'id'}">${order == 'asc' ? '▲' : '▼'}</c:if>
                                        </a>
                                    </th>

                                    <th scope="col">
                                        <a href="student?action=sort&sortBy=student_code&order=${order == 'asc' ? 'desc' : 'asc'}">
                                            Code <c:if test="${sortBy == 'student_code'}">${order == 'asc' ? '▲' : '▼'}</c:if>
                                        </a>
                                    </th>

                                    <th scope="col">
                                        <a href="student?action=sort&sortBy=full_name&order=${order == 'asc' ? 'desc' : 'asc'}">
                                            Name <c:if test="${sortBy == 'full_name'}">${order == 'asc' ? '▲' : '▼'}</c:if>
                                        </a>
                                    </th>

                                    <th scope="col">
                                        <a href="student?action=sort&sortBy=email&order=${order == 'asc' ? 'desc' : 'asc'}">
                                            Email <c:if test="${sortBy == 'email'}">${order == 'asc' ? '▲' : '▼'}</c:if>
                                        </a>
                                    </th>

                                    <th scope="col">
                                        <a href="student?action=sort&sortBy=major&order=${order == 'asc' ? 'desc' : 'asc'}">
                                            Major <c:if test="${sortBy == 'major'}">${order == 'asc' ? '▲' : '▼'}</c:if>
                                        </a>
                                    </th>
                                    <c:if test="${sessionScope.role eq 'admin'}">
                                        <th scope="col">Actions</th>
                                    </c:if >
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="student" items="${students}">
                                    <tr>
                                        <td>${student.id}</td>
                                        <td><strong>${student.studentCode}</strong></td>
                                        <td>${student.fullName}</td>
                                        <td>${student.email}</td>
                                        <td>
                                            <span style="background: #eef2ff; color: #4c6ef5; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600;">
                                                ${student.major}
                                            </span>
                                        </td>
                                        <c:if test="${sessionScope.role eq 'admin'}">
                                            <td>
                                                <div class="actions">
                                                    <a href="student?action=edit&id=${student.id}" class="btn btn-secondary" aria-label="Edit student ${student.fullName}">
                                                        ✏️ Edit
                                                    </a>
                                                    <a href="student?action=delete&id=${student.id}" 
                                                       class="btn btn-danger"
                                                       aria-label="Delete student ${student.fullName}"
                                                       onclick="return confirm('Are you sure you want to delete this student?')">
                                                        🗑️ Delete
                                                    </a>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <nav aria-label="Page navigation" class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="student?action=list&page=${currentPage - 1}" aria-label="Previous page">« Prev</a>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <strong aria-current="page">${i}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="student?action=list&page=${i}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <a href="student?action=list&page=${currentPage + 1}" aria-label="Next page">Next »</a>
                            </c:if>
                        </nav>
                        <p style="text-align:center; margin-top: 10px; color: #666; font-size: 14px;">
                            Showing page ${currentPage} of ${totalPages}
                        </p>
                    </c:if>

                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <span class="empty-state-icon" aria-hidden="true">📭</span>
                        <h3>No students found</h3>
                        <p>Start by adding a new student</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>