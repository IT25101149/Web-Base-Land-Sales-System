<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enterprise Audit Trail - Ceylon Lands Admin</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --primary: #4f46e5;
            --primary-dark: #3730a3;
            --primary-light: rgba(79, 70, 229, 0.08);
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
            width: 270px;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            color: #fff;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            position: fixed;
            height: 100vh;
            z-index: 100;
            box-shadow: 4px 0 20px rgba(0,0,0,0.06);
        }

        .logo {
            font-size: 1.45rem;
            font-weight: 800;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.65rem;
            text-decoration: none;
            letter-spacing: -0.02em;
        }

        .logo i { color: #818cf8; font-size: 1.6rem; }

        .logo-badge {
            font-size: 0.68rem;
            background: rgba(99, 102, 241, 0.25);
            color: #a5b4fc;
            padding: 0.2rem 0.5rem;
            border-radius: 9999px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            margin-left: auto;
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
            flex: 1;
        }

        .nav-section-title {
            font-size: 0.72rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin: 1rem 0 0.4rem 0.6rem;
        }

        .nav-links a {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.75rem 1rem;
            color: #94a3b8;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.92rem;
            transition: all 0.2s ease;
        }

        .nav-links a:hover, .nav-links li.active a {
            background-color: rgba(99, 102, 241, 0.15);
            color: #c7d2fe;
        }

        .nav-links li.active a {
            background: linear-gradient(135deg, #4f46e5 0%, #4338ca 100%);
            color: #ffffff;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.3);
        }

        /* Main Container */
        .main-container {
            margin-left: 270px;
            flex: 1;
            padding: 2.2rem 3rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            max-width: 1600px;
        }

        /* Header Section */
        .header-section {
            background: linear-gradient(135deg, #ffffff 0%, #f1f5f9 100%);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem 2.2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px -2px rgba(0,0,0,0.03);
        }

        .header-title h1 {
            font-size: 1.85rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .header-title p {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-top: 0.35rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 0.85rem;
        }

        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.7rem 1.25rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.9rem;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
        }

        .btn-action-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: #fff;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
        }

        .btn-action-primary:hover {
            box-shadow: 0 6px 18px rgba(79, 70, 229, 0.4);
            transform: translateY(-1px);
        }

        .btn-action-outline {
            background: #ffffff;
            color: var(--text-dark);
            border: 1px solid var(--border);
        }

        .btn-action-outline:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        /* Stats Strip */
        .stats-strip {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.25rem;
        }

        .stat-box {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.25rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 1.2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.02);
        }

        .stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            flex-shrink: 0;
        }

        .icon-indigo { background: rgba(99, 102, 241, 0.12); color: #4f46e5; }
        .icon-emerald { background: rgba(16, 185, 129, 0.12); color: #059669; }
        .icon-amber { background: rgba(245, 158, 11, 0.12); color: #d97706; }
        .icon-blue { background: rgba(2, 132, 199, 0.12); color: #0284c7; }

        .stat-text h4 {
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .stat-text p {
            font-size: 1.45rem;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1.2;
            margin-top: 0.2rem;
        }

        /* Filter Card */
        .filter-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.5rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
        }

        .filter-form {
            display: grid;
            grid-template-columns: 2fr 1.5fr 1.5fr 1.5fr auto auto;
            gap: 1rem;
            align-items: flex-end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .form-group label {
            font-size: 0.8rem;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .form-control {
            padding: 0.65rem 0.9rem;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 0.9rem;
            background-color: #ffffff;
            color: var(--text-dark);
            outline: none;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.12);
        }

        /* Table Card */
        .table-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem;
            box-shadow: 0 4px 20px -2px rgba(0,0,0,0.02);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
        }

        .table-header h3 {
            font-size: 1.2rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .live-search-box {
            position: relative;
            width: 320px;
        }

        .live-search-box input {
            width: 100%;
            padding: 0.65rem 1rem 0.65rem 2.4rem;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 0.88rem;
            outline: none;
        }

        .live-search-box i {
            position: absolute;
            left: 0.85rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }

        /* Audit Table */
        .table-responsive {
            overflow-x: auto;
        }

        table.audit-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        table.audit-table th {
            padding: 0.95rem 1rem;
            font-size: 0.75rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            border-bottom: 2px solid var(--border);
            background: #f8fafc;
        }

        table.audit-table th:first-child { border-top-left-radius: 10px; border-bottom-left-radius: 10px; }
        table.audit-table th:last-child { border-top-right-radius: 10px; border-bottom-right-radius: 10px; }

        table.audit-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.88rem;
            vertical-align: middle;
        }

        table.audit-table tr:hover td {
            background-color: #f8fafc;
        }

        /* Segregated Column Styles */
        .col-date {
            white-space: nowrap;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 0.45rem;
        }

        .col-date i { color: #6366f1; font-size: 0.95rem; }

        .col-time {
            white-space: nowrap;
        }

        .time-exact {
            font-weight: 700;
            font-size: 0.88rem;
            color: #334155;
            font-variant-numeric: tabular-nums;
        }

        .time-relative {
            font-size: 0.75rem;
            color: #94a3b8;
            margin-top: 0.15rem;
        }

        .operator-cell {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            white-space: nowrap;
        }

        .operator-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 0.8rem;
            color: #334155;
        }

        .operator-name {
            font-weight: 700;
            color: var(--text-dark);
            font-size: 0.92rem;
        }

        .role-pill {
            display: inline-block;
            padding: 0.18rem 0.5rem;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .role-admin { background: rgba(99, 102, 241, 0.12); color: #4f46e5; }
        .role-property { background: rgba(37, 99, 235, 0.12); color: #2563eb; }
        .role-sales { background: rgba(245, 158, 11, 0.12); color: #d97706; }
        .role-survey { background: rgba(2, 132, 199, 0.12); color: #0284c7; }
        .role-legal { background: rgba(168, 85, 247, 0.12); color: #9333ea; }
        .role-customer { background: rgba(16, 185, 129, 0.12); color: #059669; }
        .role-system { background: rgba(100, 116, 139, 0.12); color: #475569; }

        .module-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.25rem 0.6rem;
            border-radius: 8px;
            font-size: 0.78rem;
            font-weight: 700;
            white-space: nowrap;
        }

        .module-property { background: #eff6ff; color: #1d4ed8; border: 1px solid #bfdbfe; }
        .module-survey { background: #f0fdfa; color: #0f766e; border: 1px solid #99f6e4; }
        .module-sales { background: #fffbeb; color: #b45309; border: 1px solid #fde68a; }
        .module-legal { background: #faf5ff; color: #7e22ce; border: 1px solid #e9d5ff; }
        .module-security { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .module-users { background: #f3e8ff; color: #6b21a8; border: 1px solid #d8b4fe; }
        .module-customer { background: #ecfdf5; color: #047857; border: 1px solid #a7f3d0; }

        .action-tag {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-size: 0.78rem;
            font-weight: 700;
            padding: 0.25rem 0.5rem;
            background: #f1f5f9;
            color: #334155;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            display: inline-block;
            white-space: nowrap;
        }

        .desc-text {
            color: #334155;
            line-height: 1.45;
            max-width: 440px;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.2rem 0.55rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .status-success { background: rgba(16, 185, 129, 0.1); color: #059669; }
        .status-warning { background: rgba(245, 158, 11, 0.1); color: #d97706; }
        .status-danger { background: rgba(239, 68, 68, 0.1); color: #dc2626; }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo" style="display: flex; align-items: center; gap: 0.65rem; text-decoration: none;">
        <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 38px; width: 38px; border-radius: 8px; object-fit: cover; border: 1.5px solid #d4af37;">
        <span>Ceylon<span style="color: #d4af37;">Admin</span></span>
        <span class="logo-badge">PRO</span>
    </a>

    <ul class="nav-links">
        <div class="nav-section-title">Command Center</div>
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-grid-1x2-fill"></i>
                <span>Executive Hub</span>
            </a>
        </li>
        <li class="active">
            <a href="${pageContext.request.contextPath}/admin/audit">
                <i class="bi bi-clock-history"></i>
                <span>Audit Trail Log</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/users">
                <i class="bi bi-people-fill"></i>
                <span>User Management</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/settings">
                <i class="bi bi-gear-fill"></i>
                <span>System Settings</span>
            </a>
        </li>

        <div class="nav-section-title">Enterprise Modules</div>
        <li>
            <a href="${pageContext.request.contextPath}/property">
                <i class="bi bi-building"></i>
                <span>Properties</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/survey">
                <i class="bi bi-geo-alt-fill"></i>
                <span>Survey & Valuation</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/sales">
                <i class="bi bi-currency-dollar"></i>
                <span>Sales & Reservations</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/legal">
                <i class="bi bi-file-earmark-ruled-fill"></i>
                <span>Legal Conveyancing</span>
            </a>
        </li>

        <li style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 0.75rem;">
            <a href="${pageContext.request.contextPath}/logout" style="color: #f87171;">
                <i class="bi bi-box-arrow-right"></i>
                <span>Secure Sign Out</span>
            </a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-container">

    <!-- Header -->
    <div class="header-section">
        <div class="header-title">
            <h1>
                <i class="bi bi-shield-check" style="color: var(--primary);"></i>
                <span>Enterprise Audit Trail & Compliance</span>
            </h1>
            <p>Complete traceability of all system actions: who performed it, at what exact time, on what date, and across which business department.</p>
        </div>
        <div class="header-actions">
            <button type="button" onclick="exportAuditTableToCSV('CeylonLands_Audit_Log.csv')" class="btn-action btn-action-outline">
                <i class="bi bi-download"></i>
                <span>Export CSV</span>
            </button>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-action btn-action-primary">
                <i class="bi bi-arrow-left"></i>
                <span>Executive Hub</span>
            </a>
        </div>
    </div>

    <!-- Stats Strip -->
    <div class="stats-strip">
        <div class="stat-box">
            <div class="stat-icon icon-indigo">
                <i class="bi bi-journal-text"></i>
            </div>
            <div class="stat-text">
                <h4>Total Audit Logs</h4>
                <p id="statTotal">${totalCount}</p>
            </div>
        </div>

        <div class="stat-box">
            <div class="stat-icon icon-emerald">
                <i class="bi bi-funnel-fill"></i>
            </div>
            <div class="stat-text">
                <h4>Filtered Matches</h4>
                <p id="statFiltered">${filteredCount}</p>
            </div>
        </div>

        <div class="stat-box">
            <div class="stat-icon icon-amber">
                <i class="bi bi-calendar-event"></i>
            </div>
            <div class="stat-text">
                <h4>Today's Activity</h4>
                <p>${todayCount}</p>
            </div>
        </div>

        <div class="stat-box">
            <div class="stat-icon icon-blue">
                <i class="bi bi-people-fill"></i>
            </div>
            <div class="stat-text">
                <h4>Distinct Operators</h4>
                <p>${distinctUsers.size()}</p>
            </div>
        </div>
    </div>

    <!-- Filter Controls -->
    <div class="filter-card">
        <form action="${pageContext.request.contextPath}/admin/audit" method="get" class="filter-form">
            <!-- Search Query -->
            <div class="form-group">
                <label><i class="bi bi-search"></i> Keywords</label>
                <input type="text" name="query" value="${query}" class="form-control" placeholder="Search action, description, operator...">
            </div>

            <!-- Module Select -->
            <div class="form-group">
                <label><i class="bi bi-folder-fill"></i> Module</label>
                <select name="module" class="form-control">
                    <option value="">All Modules</option>
                    <c:forEach var="moduleItem" items="${distinctModules}">
                        <option value="${moduleItem}" ${selectedModule == moduleItem ? 'selected' : ''}>${moduleItem}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Operator Select -->
            <div class="form-group">
                <label><i class="bi bi-person-fill"></i> Operator (Kauda)</label>
                <select name="username" class="form-control">
                    <option value="">All Operators</option>
                    <c:forEach var="usr" items="${distinctUsers}">
                        <option value="${usr}" ${selectedUsername == usr ? 'selected' : ''}>${usr}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Date Picker -->
            <div class="form-group">
                <label><i class="bi bi-calendar-date"></i> Date (Kawadda)</label>
                <input type="date" name="date" value="${selectedDate}" class="form-control">
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn-action btn-action-primary" style="height: 42px;">
                <i class="bi bi-filter"></i>
                <span>Apply Filter</span>
            </button>

            <!-- Reset Button -->
            <a href="${pageContext.request.contextPath}/admin/audit" class="btn-action btn-action-outline" style="height: 42px;">
                <i class="bi bi-arrow-counterclockwise"></i>
                <span>Reset</span>
            </a>
        </form>
    </div>

    <!-- Main Audit Table -->
    <div class="table-card">
        <div class="table-header">
            <h3>
                <i class="bi bi-list-check" style="color: var(--primary);"></i>
                <span>Audit Entries Trail</span>
            </h3>
            <div class="live-search-box">
                <i class="bi bi-search"></i>
                <input type="text" id="liveTableFilter" placeholder="Instant filter in table..." onkeyup="filterAuditTable()">
            </div>
        </div>

        <div class="table-responsive">
            <table class="audit-table" id="auditLogTable">
                <thead>
                <tr>
                    <th>Date (Kawadda)</th>
                    <th>Time (Keeyatada)</th>
                    <th>Operator (Kauda)</th>
                    <th>Module</th>
                    <th>Action</th>
                    <th>Event Details & Description</th>
                    <th>IP Address</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty logs}">
                        <tr>
                            <td colspan="8" style="text-align: center; padding: 3rem; color: #94a3b8;">
                                <i class="bi bi-inbox" style="font-size: 2.5rem; display: block; margin-bottom: 0.5rem;"></i>
                                <strong>No audit log records match the selected criteria.</strong>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="log" items="${logs}">
                            <tr class="audit-row">
                                <!-- 1. Date (Kawadda) -->
                                <td>
                                    <div class="col-date">
                                        <i class="bi bi-calendar3"></i>
                                        <span class="cell-date">${log.formattedDate}</span>
                                    </div>
                                </td>

                                <!-- 2. Time (Keeyatada) -->
                                <td>
                                    <div class="col-time">
                                        <div class="time-exact cell-time">${log.formattedTime}</div>
                                        <div class="time-relative">${log.relativeTime}</div>
                                    </div>
                                </td>

                                <!-- 3. Operator (Kauda) -->
                                <td>
                                    <div class="operator-cell">
                                        <div class="operator-avatar">${log.username.substring(0, 1).toUpperCase()}</div>
                                        <div>
                                            <div class="operator-name cell-user">${log.username}</div>
                                            <span class="role-pill role-${log.userRole.toLowerCase().replace('role_', '')}">
                                                    ${log.userRole.replace('ROLE_', '')}
                                            </span>
                                        </div>
                                    </div>
                                </td>

                                <!-- 4. Module -->
                                <td>
                                    <c:choose>
                                        <c:when test="${log.module == 'Property' or log.module == 'PROPERTY'}">
                                            <span class="module-badge module-property cell-module"><i class="bi bi-building"></i> Property</span>
                                        </c:when>
                                        <c:when test="${log.module == 'Survey' or log.module == 'SURVEY'}">
                                            <span class="module-badge module-survey cell-module"><i class="bi bi-geo-alt-fill"></i> Survey</span>
                                        </c:when>
                                        <c:when test="${log.module == 'Sales' or log.module == 'SALES'}">
                                            <span class="module-badge module-sales cell-module"><i class="bi bi-currency-dollar"></i> Sales</span>
                                        </c:when>
                                        <c:when test="${log.module == 'Legal' or log.module == 'LEGAL'}">
                                            <span class="module-badge module-legal cell-module"><i class="bi bi-file-earmark-text"></i> Legal</span>
                                        </c:when>
                                        <c:when test="${log.module == 'USER_MANAGEMENT'}">
                                            <span class="module-badge module-users cell-module"><i class="bi bi-people-fill"></i> Users</span>
                                        </c:when>
                                        <c:when test="${log.module == 'CUSTOMER' or log.module == 'Customer'}">
                                            <span class="module-badge module-customer cell-module"><i class="bi bi-person-circle"></i> Customer</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="module-badge module-security cell-module"><i class="bi bi-shield-fill"></i> ${log.module}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <!-- 5. Action -->
                                <td>
                                    <span class="action-tag cell-action">${log.action}</span>
                                </td>

                                <!-- 6. Details -->
                                <td>
                                    <div class="desc-text cell-desc">${log.description}</div>
                                </td>

                                <!-- 7. IP Address -->
                                <td>
                                    <span style="font-family: monospace; font-size: 0.82rem; color: #64748b;">${log.ipAddress}</span>
                                </td>

                                <!-- 8. Status -->
                                <td>
                                            <span class="status-pill status-${log.status.toLowerCase()}">
                                                <i class="bi bi-check-circle-fill"></i>
                                                <span>${log.status}</span>
                                            </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Live Client Filtering & CSV Export Scripts -->
<script>
    function filterAuditTable() {
        var input = document.getElementById("liveTableFilter");
        var filter = input.value.toLowerCase();
        var rows = document.querySelectorAll("#auditLogTable tbody tr.audit-row");
        var visibleCount = 0;

        rows.forEach(function(row) {
            var text = row.innerText.toLowerCase();
            if (text.indexOf(filter) > -1) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        var statFiltered = document.getElementById("statFiltered");
        if (statFiltered) {
            statFiltered.innerText = visibleCount;
        }
    }

    function exportAuditTableToCSV(filename) {
        var csv = [];
        var rows = document.querySelectorAll("#auditLogTable tr");

        for (var i = 0; i < rows.length; i++) {
            var row = [];
            var cols = rows[i].querySelectorAll("th, td");
            if (rows[i].style.display === "none") continue;

            for (var j = 0; j < cols.length; j++) {
                var cellText = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, " ").trim();
                cellText = cellText.replace(/"/g, '""');
                row.push('"' + cellText + '"');
            }
            csv.push(row.join(","));
        }

        var csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
        var downloadLink = document.createElement("a");
        downloadLink.download = filename;
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = "none";
        document.body.appendChild(downloadLink);
        downloadLink.click();
        document.body.removeChild(downloadLink);
    }
</script>
</body>
</html>
