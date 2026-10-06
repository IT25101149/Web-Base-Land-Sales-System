<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User & Role Management - Ceylon Lands Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #0284c7;
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
            z-index: 10;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }

        .logo i { color: #6366f1; }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            color: #94a3b8;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .nav-links a:hover, .nav-links li.active a {
            background-color: rgba(99, 102, 241, 0.1);
            color: #6366f1;
        }

        /* Main Container */
        .main-container {
            margin-left: 260px;
            flex: 1;
            padding: 2.5rem;
            display: flex;
            flex-direction: column;
            gap: 1.8rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        header h1 {
            font-size: 1.85rem;
            font-weight: 700;
            letter-spacing: -0.02em;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 0.8rem;
        }

        .btn-primary-add {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: #fff;
            border: none;
            padding: 0.65rem 1.3rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
            transition: all 0.2s ease;
        }

        .btn-primary-add:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(79, 70, 229, 0.35);
        }

        .btn-back {
            background-color: #ffffff;
            border: 1px solid var(--border);
            color: var(--text-dark);
            padding: 0.65rem 1.2rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: all 0.2s ease;
        }

        .btn-back:hover {
            background-color: #f1f5f9;
        }

        /* Info Callout */
        .info-callout {
            background-color: #f0fdf4;
            border: 1px solid #bbf7d0;
            border-radius: 12px;
            padding: 1rem 1.3rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
        }

        .info-callout-text {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            color: #166534;
            font-size: 0.92rem;
        }

        .info-callout-text i {
            font-size: 1.3rem;
            color: #15803d;
        }

        /* Card / Table */
        .card {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 1.1rem 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        th {
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.06em;
            background-color: #f8fafc;
        }

        td {
            font-size: 0.92rem;
        }

        tr:hover td {
            background-color: #fafbfd;
        }

        .badge-role {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.35rem 0.85rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin { background-color: rgba(99, 102, 241, 0.12); color: #4f46e5; border: 1px solid rgba(99, 102, 241, 0.25); }
        .role-property { background-color: rgba(37, 99, 235, 0.12); color: #2563eb; border: 1px solid rgba(37, 99, 235, 0.25); }
        .role-sales { background-color: rgba(245, 158, 11, 0.12); color: #d97706; border: 1px solid rgba(245, 158, 11, 0.25); }
        .role-survey { background-color: rgba(14, 165, 233, 0.12); color: #0284c7; border: 1px solid rgba(14, 165, 233, 0.25); }
        .role-legal { background-color: rgba(168, 85, 247, 0.12); color: #9333ea; border: 1px solid rgba(168, 85, 247, 0.25); }
        .role-customer { background-color: rgba(34, 197, 94, 0.12); color: #16a34a; border: 1px solid rgba(34, 197, 94, 0.25); }

        .badge-status {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.3rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background-color: rgba(16, 185, 129, 0.12);
            color: #059669;
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-suspended {
            background-color: rgba(239, 68, 68, 0.12);
            color: #dc2626;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .dashboard-link {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            font-size: 0.85rem;
            font-weight: 600;
            color: #475569;
            background-color: #f1f5f9;
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            text-decoration: none;
        }

        .dashboard-link:hover {
            color: var(--primary);
            background-color: #e0e7ff;
        }

        .actions-cell {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            flex-wrap: wrap;
        }

        .btn-edit {
            color: #4f46e5;
            background: rgba(79, 70, 229, 0.08);
            border: 1px solid rgba(79, 70, 229, 0.2);
            padding: 0.4rem 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.2s ease;
        }

        .btn-edit:hover {
            background-color: #4f46e5;
            color: #fff;
        }

        .btn-suspend {
            color: #d97706;
            background: rgba(245, 158, 11, 0.08);
            border: 1px solid rgba(245, 158, 11, 0.25);
            padding: 0.4rem 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.2s ease;
        }

        .btn-suspend:hover {
            background-color: #d97706;
            color: #fff;
        }

        .btn-activate {
            color: #059669;
            background: rgba(16, 185, 129, 0.08);
            border: 1px solid rgba(16, 185, 129, 0.25);
            padding: 0.4rem 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.2s ease;
        }

        .btn-activate:hover {
            background-color: #059669;
            color: #fff;
        }

        .btn-reset-pass {
            color: #6366f1;
            background: rgba(99, 102, 241, 0.08);
            border: 1px solid rgba(99, 102, 241, 0.2);
            padding: 0.4rem 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.2s ease;
        }

        .btn-reset-pass:hover {
            background-color: #6366f1;
            color: #fff;
        }

        .btn-delete {
            color: var(--danger);
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            padding: 0.4rem 0.7rem;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.82rem;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            transition: all 0.2s ease;
        }

        .btn-delete:hover {
            background-color: var(--danger);
            color: #fff;
        }

        /* Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            padding: 1.5rem;
        }

        .modal-card {
            background: #ffffff;
            width: 100%;
            max-width: 520px;
            border-radius: 20px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            border: 1px solid var(--border);
            overflow: hidden;
            animation: modalPop 0.2s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes modalPop {
            from { opacity: 0; transform: scale(0.95); }
            to { opacity: 1; transform: scale(1); }
        }

        .modal-header {
            padding: 1.4rem 1.6rem;
            background: #f8fafc;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .modal-header h2 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-close-modal {
            background: transparent;
            border: none;
            font-size: 1.3rem;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0.3rem;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .btn-close-modal:hover {
            color: var(--text-dark);
            background: #e2e8f0;
        }

        .modal-body {
            padding: 1.6rem;
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .form-group label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #334155;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 0.95rem;
            background: #fff;
            color: var(--text-dark);
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .form-hint {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .role-preview-box {
            background-color: #f1f5f9;
            border-left: 4px solid var(--primary);
            padding: 0.75rem 1rem;
            border-radius: 6px;
            font-size: 0.85rem;
            color: #334155;
            display: flex;
            align-items: flex-start;
            gap: 0.5rem;
        }

        .modal-footer {
            padding: 1.2rem 1.6rem;
            background: #f8fafc;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: flex-end;
            gap: 0.75rem;
        }

        .btn-modal-cancel {
            background: #ffffff;
            border: 1px solid var(--border);
            color: var(--text-dark);
            padding: 0.65rem 1.2rem;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-modal-cancel:hover {
            background: #f1f5f9;
        }

        .btn-modal-submit {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: #fff;
            border: none;
            padding: 0.65rem 1.4rem;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(79, 70, 229, 0.25);
            transition: all 0.2s ease;
        }

        .btn-modal-submit:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 14px rgba(79, 70, 229, 0.35);
        }

        .user-highlight-card {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 0.85rem 1.1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo" style="display: flex; align-items: center; gap: 0.65rem; text-decoration: none;">
        <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 38px; width: 38px; border-radius: 8px; object-fit: cover; border: 1.5px solid #d4af37;">
        <span>Ceylon<span style="color: #d4af37;">Admin</span></span>
    </a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-grid-1x2-fill"></i> Executive Hub</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/audit"><i class="bi bi-clock-history"></i> Audit Trail Log</a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people-fill"></i> User Management</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/settings"><i class="bi bi-gear-fill"></i> System Settings</a></li>
        <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-building"></i> Properties</a></li>
        <li><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Survey & Valuation</a></li>
        <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales</a></li>
        <li><a href="${pageContext.request.contextPath}/legal"><i class="bi bi-file-earmark-ruled-fill"></i> Legal Docs</a></li>
        <li style="margin-top: 1.5rem; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 0.75rem;">
            <a href="${pageContext.request.contextPath}/logout" style="color: #f87171;"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-container">
    <header>
        <div>
            <h1>User & Role Management</h1>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.2rem;">
                Manage company staff accounts, assign departmental roles, and configure dynamic dashboard routing.
            </p>
        </div>
        <div class="header-actions">
            <button type="button" class="btn-primary-add" onclick="openAddUserModal()">
                <i class="bi bi-person-plus-fill"></i> Provision Staff Account
            </button>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </header>

    <!-- Feedback Alert Messages -->
    <c:if test="${not empty successMessage}">
        <div style="background-color: #d1fae5; border-left: 4px solid #10b981; color: #065f46; padding: 0.95rem 1.25rem; border-radius: 10px; display: flex; align-items: center; gap: 0.7rem; font-weight: 600; box-shadow: 0 2px 4px rgba(0,0,0,0.03);">
            <i class="bi bi-check-circle-fill" style="color: #10b981; font-size: 1.2rem;"></i>
            <span>${successMessage}</span>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div style="background-color: #fee2e2; border-left: 4px solid #ef4444; color: #991b1b; padding: 0.95rem 1.25rem; border-radius: 10px; display: flex; align-items: center; gap: 0.7rem; font-weight: 600; box-shadow: 0 2px 4px rgba(0,0,0,0.03);">
            <i class="bi bi-exclamation-triangle-fill" style="color: #ef4444; font-size: 1.2rem;"></i>
            <span>${errorMessage}</span>
        </div>
    </c:if>

    <!-- Info Card -->
    <div class="info-callout">
        <div class="info-callout-text">
            <i class="bi bi-shield-check"></i>
            <div>
                <strong>Admin-Exclusive Access:</strong> Only Administrators can create or reassign internal company roles. When a role is updated (e.g. Sales to Legal), the user's dashboard and access permissions will instantly reflect the new assignment upon login.
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="card">
        <div class="table-responsive">
            <table>
                <thead>
                <tr>
                    <th>User ID</th>
                    <th>Staff Member</th>
                    <th>Email Address</th>
                    <th>Assigned Role</th>
                    <th>Active Dashboard Target</th>
                    <th>Account Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td><strong>#${user.id}</strong></td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 0.75rem;">
                                <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%); color: #4f46e5; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                                        ${user.username.substring(0, 1).toUpperCase()}
                                </div>
                                <div>
                                    <div style="font-weight: 600; color: var(--text-dark);">${user.username}</div>
                                    <div style="font-size: 0.78rem; color: var(--text-muted);">
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}">System Administrator</c:when>
                                            <c:when test="${user.role == 'PROPERTY' or user.role == 'PROPERTY_MANAGER'}">Property Dept.</c:when>
                                            <c:when test="${user.role == 'SALES'}">Sales Department</c:when>
                                            <c:when test="${user.role == 'SURVEY'}">Survey & Valuation</c:when>
                                            <c:when test="${user.role == 'LEGAL'}">Legal Affairs</c:when>
                                            <c:otherwise>Client / External</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><span style="color: #334155;">${user.email}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}">
                                    <span class="badge-role role-admin"><i class="bi bi-shield-fill"></i> ADMIN</span>
                                </c:when>
                                <c:when test="${user.role == 'PROPERTY' or user.role == 'PROPERTY_MANAGER'}">
                                    <span class="badge-role role-property"><i class="bi bi-building"></i> PROPERTY</span>
                                </c:when>
                                <c:when test="${user.role == 'SALES'}">
                                    <span class="badge-role role-sales"><i class="bi bi-currency-dollar"></i> SALES</span>
                                </c:when>
                                <c:when test="${user.role == 'SURVEY'}">
                                    <span class="badge-role role-survey"><i class="bi bi-geo-alt-fill"></i> SURVEY</span>
                                </c:when>
                                <c:when test="${user.role == 'LEGAL'}">
                                    <span class="badge-role role-legal"><i class="bi bi-file-earmark-text-fill"></i> LEGAL</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-role role-customer"><i class="bi bi-person-fill"></i> ${user.role}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 'ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="dashboard-link">
                                        <i class="bi bi-speedometer2"></i> /admin/dashboard
                                    </a>
                                </c:when>
                                <c:when test="${user.role == 'PROPERTY' or user.role == 'PROPERTY_MANAGER'}">
                                    <a href="${pageContext.request.contextPath}/property" class="dashboard-link">
                                        <i class="bi bi-building"></i> /property
                                    </a>
                                </c:when>
                                <c:when test="${user.role == 'SALES'}">
                                    <a href="${pageContext.request.contextPath}/sales" class="dashboard-link">
                                        <i class="bi bi-cart-check"></i> /sales
                                    </a>
                                </c:when>
                                <c:when test="${user.role == 'SURVEY'}">
                                    <a href="${pageContext.request.contextPath}/survey" class="dashboard-link">
                                        <i class="bi bi-rulers"></i> /survey
                                    </a>
                                </c:when>
                                <c:when test="${user.role == 'LEGAL'}">
                                    <a href="${pageContext.request.contextPath}/legal" class="dashboard-link">
                                        <i class="bi bi-journal-bookmark-fill"></i> /legal
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/home" class="dashboard-link">
                                        <i class="bi bi-house"></i> /home
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${user.status == 'SUSPENDED'}">
                                    <span class="badge-status status-suspended"><i class="bi bi-slash-circle-fill"></i> SUSPENDED</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-status status-active"><i class="bi bi-check-circle-fill"></i> ACTIVE</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="actions-cell">
                                <button type="button" class="btn-edit" onclick="openEditUserModal('${user.id}', '${user.username}', '${user.email}', '${user.role}')" title="Edit Role / Email">
                                    <i class="bi bi-pencil-square"></i> Role
                                </button>
                                <c:if test="${user.username != 'admin'}">
                                    <c:choose>
                                        <c:when test="${user.status == 'SUSPENDED'}">
                                            <a href="${pageContext.request.contextPath}/admin/users/toggle-status/${user.id}" class="btn-activate" onclick="return confirm('Reactivate login access for \'${user.username}\'?');" title="Reactivate Account">
                                                <i class="bi bi-unlock-fill"></i> Reactivate
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/users/toggle-status/${user.id}" class="btn-suspend" onclick="return confirm('Are you sure you want to SUSPEND \'${user.username}\'? This will immediately block their login to Ceylon Lands.');" title="Suspend Account">
                                                <i class="bi bi-slash-circle"></i> Suspend
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="button" class="btn-reset-pass" onclick="openResetPasswordModal('${user.id}', '${user.username}')" title="Quick Password Reset">
                                        <i class="bi bi-key-fill"></i> Pass
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/users/delete/${user.id}" class="btn-delete" onclick="return confirm('WARNING: Are you sure you want to PERMANENTLY DELETE user \'${user.username}\'? (If you only want to block access, consider SUSPENDING them instead). Proceed with permanent deletion?');" title="Permanent Delete">
                                        <i class="bi bi-trash3-fill"></i> Delete
                                    </a>
                                </c:if>
                                <c:if test="${user.username == 'admin'}">
                                            <span style="font-size: 0.78rem; color: var(--text-muted); font-weight: 600; padding: 0.2rem 0.5rem; background: #f1f5f9; border-radius: 6px;">
                                                <i class="bi bi-shield-lock-fill" style="color: var(--primary);"></i> Root Admin
                                            </span>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal 1: Provision New Staff User -->
<div id="addUserModal" class="modal-overlay">
    <div class="modal-card">
        <div class="modal-header">
            <h2><i class="bi bi-person-plus-fill" style="color: var(--primary);"></i> Provision Staff Account</h2>
            <button type="button" class="btn-close-modal" onclick="closeAddUserModal()"><i class="bi bi-x-lg"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/users/add" method="POST">
            <div class="modal-body">
                <div class="form-group">
                    <label for="newUsername">Username <span style="color: var(--danger);">*</span></label>
                    <input type="text" id="newUsername" name="username" placeholder="e.g. kamal.perera" required pattern="[A-Za-z0-9_.-]{3,30}" title="Letters, numbers, underscores or periods (min 3 chars)">
                    <span class="form-hint">Unique handle used for signing in.</span>
                </div>

                <div class="form-group">
                    <label for="newEmail">Email Address <span style="color: var(--danger);">*</span></label>
                    <input type="email" id="newEmail" name="email" placeholder="e.g. kamal@ceylonlands.lk" required>
                </div>

                <div class="form-group">
                    <label for="newPassword">Initial Password <span style="color: var(--danger);">*</span></label>
                    <input type="password" id="newPassword" name="password" placeholder="Min. 6 characters" required minlength="6">
                    <span class="form-hint">Staff member can sign in immediately with this credential (minimum 6 characters).</span>
                </div>

                <div class="form-group">
                    <label for="newRole">Assigned Department / System Role <span style="color: var(--danger);">*</span></label>
                    <select id="newRole" name="role" required onchange="updateRoleHint(this.value, 'addRoleHint')">
                        <option value="SALES">Sales Officer / Manager (Dashboard: /sales)</option>
                        <option value="LEGAL">Legal Officer (Dashboard: /legal)</option>
                        <option value="SURVEY">Land Surveyor & Valuation (Dashboard: /survey)</option>
                        <option value="PROPERTY">Property Manager (Dashboard: /property)</option>
                        <option value="ADMIN">System Administrator (Executive Hub: /admin/dashboard)</option>
                        <option value="CUSTOMER">Customer (Client Portal: /customer/portal)</option>
                    </select>
                </div>

                <div id="addRoleHint" class="role-preview-box">
                    <i class="bi bi-info-circle-fill" style="color: var(--primary); font-size: 1.1rem; margin-top: 1px;"></i>
                    <span>User lands on <strong>Sales Dashboard (/sales)</strong> and can process reservations, payments, and sales contracts.</span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closeAddUserModal()">Cancel</button>
                <button type="submit" class="btn-modal-submit"><i class="bi bi-check-lg"></i> Create Staff Account</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal 2: Edit User & Change Role -->
<div id="editUserModal" class="modal-overlay">
    <div class="modal-card">
        <div class="modal-header">
            <h2><i class="bi bi-sliders" style="color: var(--primary);"></i> Edit User & Role</h2>
            <button type="button" class="btn-close-modal" onclick="closeEditUserModal()"><i class="bi bi-x-lg"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/users/edit" method="POST">
            <input type="hidden" id="editUserId" name="id">

            <div class="modal-body">
                <!-- Current User Header Info -->
                <div class="user-highlight-card">
                    <div>
                        <span style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; font-weight: 700;">Modifying User</span>
                        <div id="editUserDisplay" style="font-size: 1.1rem; font-weight: 700; color: var(--text-dark); margin-top: 2px;">username</div>
                    </div>
                    <div id="editCurrentRoleBadge"></div>
                </div>

                <div class="form-group">
                    <label for="editEmail">Email Address <span style="color: var(--danger);">*</span></label>
                    <input type="email" id="editEmail" name="email" required>
                </div>

                <div class="form-group">
                    <label for="editRole">System Role & Assigned Dashboard <span style="color: var(--danger);">*</span></label>
                    <select id="editRole" name="role" required onchange="updateRoleHint(this.value, 'editRoleHint')">
                        <option value="SALES">Sales Officer / Manager (Dashboard: /sales)</option>
                        <option value="LEGAL">Legal Officer (Dashboard: /legal)</option>
                        <option value="SURVEY">Land Surveyor & Valuation (Dashboard: /survey)</option>
                        <option value="PROPERTY">Property Manager (Dashboard: /property)</option>
                        <option value="ADMIN">System Administrator (Executive Hub: /admin/dashboard)</option>
                        <option value="CUSTOMER">Customer (Client Portal: /customer/portal)</option>
                    </select>
                    <span class="form-hint">Changing this role immediately transitions the user's dashboard and access permissions.</span>
                </div>

                <div id="editRoleHint" class="role-preview-box">
                    <i class="bi bi-arrow-repeat" style="color: var(--primary); font-size: 1.1rem; margin-top: 1px;"></i>
                    <span id="editRoleHintText">Switching role will update landing dashboard upon next login.</span>
                </div>

                <div class="form-group">
                    <label for="editPassword">Reset Password <span style="font-weight: 400; color: var(--text-muted);">(Leave blank to keep current, or min 6 chars)</span></label>
                    <input type="password" id="editPassword" name="password" placeholder="Optional new password (min 6 chars)" minlength="6">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closeEditUserModal()">Cancel</button>
                <button type="submit" class="btn-modal-submit"><i class="bi bi-check2-circle"></i> Save Role Changes</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal 3: Quick Reset Password -->
<div id="resetPasswordModal" class="modal-overlay">
    <div class="modal-card">
        <div class="modal-header">
            <h2><i class="bi bi-key-fill" style="color: var(--primary);"></i> Reset User Password</h2>
            <button type="button" class="btn-close-modal" onclick="closeResetPasswordModal()"><i class="bi bi-x-lg"></i></button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/users/reset-password" method="POST">
            <input type="hidden" id="resetUserId" name="id">

            <div class="modal-body">
                <div class="user-highlight-card">
                    <div>
                        <span style="font-size: 0.78rem; color: var(--text-muted); text-transform: uppercase; font-weight: 700;">Target User</span>
                        <div id="resetUserDisplay" style="font-size: 1.1rem; font-weight: 700; color: var(--text-dark); margin-top: 2px;">username</div>
                    </div>
                    <span class="badge-role role-admin" style="background: rgba(99, 102, 241, 0.1); color: var(--primary);">
                            <i class="bi bi-shield-lock"></i> Credential Override
                        </span>
                </div>

                <div class="form-group">
                    <label for="newPasswordInput">New Temporary or Permanent Password <span style="color: var(--danger);">*</span></label>
                    <input type="password" id="newPasswordInput" name="newPassword" placeholder="Minimum 6 characters" required minlength="6">
                    <span class="form-hint">The user will immediately need this new password to sign into the system.</span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closeResetPasswordModal()">Cancel</button>
                <button type="submit" class="btn-modal-submit"><i class="bi bi-check2-all"></i> Update Password</button>
            </div>
        </form>
    </div>
</div>

<script>
    const roleDescriptions = {
        'SALES': 'User lands on <strong>Sales Dashboard (/sales)</strong> and can process reservations, payments, and sales contracts.',
        'LEGAL': 'User lands on <strong>Legal Dashboard (/legal)</strong> and can review deed clearances, issue legal notices, and manage legal issues.',
        'SURVEY': 'User lands on <strong>Survey & Valuation Dashboard (/survey)</strong> and can approve plot boundaries, soil tests, and valuation logs.',
        'PROPERTY': 'User lands on <strong>Property Dashboard (/property)</strong> and can add, edit, and manage land parcels and plots.',
        'PROPERTY_MANAGER': 'User lands on <strong>Property Dashboard (/property)</strong> and can add, edit, and manage land parcels and plots.',
        'ADMIN': 'User lands on <strong>Executive Hub (/admin/dashboard)</strong> with unrestricted system administration and audit trail access.',
        'CUSTOMER': 'User lands on <strong>Customer Portal (/customer/portal)</strong> to track land reservations, submit payments & legal KYC documents.'
    };

    function updateRoleHint(role, targetElementId) {
        const el = document.getElementById(targetElementId);
        if (!el) return;
        const text = roleDescriptions[role] || 'User will receive permissions matching role ' + role;
        el.innerHTML = '<i class="bi bi-info-circle-fill" style="color: var(--primary); font-size: 1.1rem; margin-top: 1px;"></i><span>' + text + '</span>';
    }

    function openAddUserModal() {
        document.getElementById('newUsername').value = '';
        document.getElementById('newEmail').value = '';
        document.getElementById('newPassword').value = '';
        document.getElementById('newRole').value = 'SALES';
        updateRoleHint('SALES', 'addRoleHint');
        document.getElementById('addUserModal').style.display = 'flex';
    }

    function closeAddUserModal() {
        document.getElementById('addUserModal').style.display = 'none';
    }

    function openEditUserModal(id, username, email, role) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserDisplay').textContent = username;
        document.getElementById('editEmail').value = email || '';
        document.getElementById('editPassword').value = '';

        const normalizedRole = role ? role.toUpperCase() : 'SALES';
        const selectEl = document.getElementById('editRole');
        selectEl.value = normalizedRole;

        // If user is primary admin, disable changing role
        if (username.toLowerCase() === 'admin') {
            selectEl.disabled = true;
        } else {
            selectEl.disabled = false;
        }

        document.getElementById('editCurrentRoleBadge').innerHTML =
            '<span class="badge-role role-' + normalizedRole.toLowerCase() + '">' + normalizedRole + '</span>';

        updateRoleHint(normalizedRole, 'editRoleHint');
        document.getElementById('editUserModal').style.display = 'flex';
    }

    function closeEditUserModal() {
        document.getElementById('editUserModal').style.display = 'none';
    }

    function openResetPasswordModal(id, username) {
        document.getElementById('resetUserId').value = id;
        document.getElementById('resetUserDisplay').textContent = username;
        document.getElementById('newPasswordInput').value = '';
        document.getElementById('resetPasswordModal').style.display = 'flex';
    }

    function closeResetPasswordModal() {
        document.getElementById('resetPasswordModal').style.display = 'none';
    }

    // Close modal when clicking outside of modal card
    window.onclick = function(event) {
        const addModal = document.getElementById('addUserModal');
        const editModal = document.getElementById('editUserModal');
        const resetModal = document.getElementById('resetPasswordModal');
        if (event.target === addModal) closeAddUserModal();
        if (event.target === editModal) closeEditUserModal();
        if (event.target === resetModal) closeResetPasswordModal();
    };

    // Close on ESC key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeAddUserModal();
            closeEditUserModal();
            closeResetPasswordModal();
        }
    });
</script>
</body>
</html>

