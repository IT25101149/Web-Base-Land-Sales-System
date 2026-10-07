<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers CRM - Land Sales System</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.9);
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --danger: #ef4444;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: 260px;
            background-color: #0f172a;
            color: #fff;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            position: fixed;
            height: 100vh;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i {
            color: var(--primary);
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-links a {
            color: #94a3b8;
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .nav-links a:hover, .nav-links .active a {
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
        }

        .nav-links .active a {
            background-color: var(--primary);
        }

        /* Main Content */
        .main-container {
            margin-left: 260px;
            flex: 1;
            padding: 2rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        header h1 {
            font-size: 1.75rem;
            font-weight: 700;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background-color 0.2s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
        }

        /* Table */
        .table-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 0.75rem 1rem;
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.875rem;
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.95rem;
        }

        .btn-edit {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            margin-right: 0.75rem;
        }

        .btn-delete {
            color: var(--danger);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="logo" style="display: flex; align-items: center; gap: 0.65rem;">
            <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 38px; width: 38px; border-radius: 8px; object-fit: cover; border: 1.5px solid #d4af37;">
            <span>Ceylon<span style="color: #d4af37;">Lands</span></span>
        </div>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a></li>

            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_SALES') or pageContext.request.isUserInRole('ROLE_SURVEY')}">
                <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>
            </c:if>

            <li class="active"><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>

            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_SALES')}">
                <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
            </c:if>

            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_SURVEY')}">
                <li><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Surveys</a></li>
            </c:if>

            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_LEGAL')}">
                <li><a href="${pageContext.request.contextPath}/legal"><i class="bi bi-file-earmark-text-fill"></i> Legal Docs</a></li>
            </c:if>

            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-person-gear"></i> System Users</a></li>
            </c:if>
        </ul>

        <div style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 1rem;">
            <form action="${pageContext.request.contextPath}/logout" method="POST">
                <button type="submit" style="background: none; border: none; color: #ef4444; font-size: 0.88rem; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 0.5rem; padding: 0;">
                    <i class="bi bi-box-arrow-right"></i> Log Out
                </button>
            </form>
        </div>
    </div>

    <!-- Main Content Area -->
    <div class="main-container">
        <header>
            <div>
                <h1>Registered Customers</h1>
                <p style="color: var(--text-muted); font-size: 0.9rem;">Manage registered customer profiles and account records.</p>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <a href="${pageContext.request.contextPath}/crm/inquiries" class="btn-primary" style="background-color: #0f172a;">
                    <i class="bi bi-chat-left-text-fill"></i> View Inquiries
                </a>
                <a href="${pageContext.request.contextPath}/crm/add" class="btn-primary">
                    <i class="bi bi-person-plus-fill"></i> Add Customer
                </a>
            </div>
        </header>

        <!-- Flash messages -->
        <c:if test="${not empty successMsg}">
            <div style="background: #f0fdf4; border: 1px solid #bbf7d0; color: #15803d; padding: 0.85rem 1.25rem; border-radius: 10px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; font-weight: 600;">
                <i class="bi bi-check-circle-fill"></i> ${successMsg}
            </div>
        </c:if>
        <c:if test="${not empty errorMsg}">
            <div style="background: #fef2f2; border: 1px solid #fecaca; color: #b91c1c; padding: 0.85rem 1.25rem; border-radius: 10px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; font-weight: 600;">
                <i class="bi bi-exclamation-triangle-fill"></i> ${errorMsg}
            </div>
        </c:if>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cust" items="${customers}">
                        <tr>
                            <td>#${cust.id}</td>
                            <td style="font-weight: 600;">${cust.name}</td>
                            <td>${cust.username != null ? cust.username : '-'}</td>
                            <td>${cust.email}</td>
                            <td>${cust.phone}</td>
                            <td>${cust.address}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/crm/edit/${cust.id}" class="btn-edit">
                                    <i class="bi bi-pencil-square"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/crm/delete/${cust.id}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this customer record?');">
                                    <i class="bi bi-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty customers}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: var(--text-muted); padding: 2rem;">No customers found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>

</body>
</html>