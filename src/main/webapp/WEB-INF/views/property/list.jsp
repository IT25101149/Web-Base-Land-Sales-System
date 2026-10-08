<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Management Dashboard - Ceylon Lands</title>
    <!-- Modern Typography & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8fafc;
            --card-bg: #ffffff;
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --primary-light: #eef2ff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --success: #10b981;
            --success-light: #ecfdf5;
            --warning: #f59e0b;
            --warning-light: #fffbeb;
            --purple: #8b5cf6;
            --purple-light: #f5f3ff;
            --danger: #ef4444;
            --danger-light: #fef2f2;
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

        /* Sidebar Navigation */
        .sidebar {
            width: 270px;
            background-color: #0f172a;
            color: #fff;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            position: fixed;
            height: 100vh;
            z-index: 100;
        }

        .logo {
            font-size: 1.45rem;
            font-weight: 800;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.65rem;
            margin-bottom: 2rem;
            text-decoration: none;
            letter-spacing: -0.5px;
        }

        .logo i {
            color: var(--primary);
            font-size: 1.6rem;
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .nav-links a {
            color: #94a3b8;
            text-decoration: none;
            padding: 0.8rem 1rem;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-weight: 600;
            font-size: 0.92rem;
            transition: all 0.2s ease;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.08);
            color: #fff;
        }

        .nav-links .active a {
            background-color: var(--primary);
            color: #fff;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.35);
        }

        .sidebar-footer {
            margin-top: auto;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.25rem;
        }

        /* Main Container */
        .main-container {
            margin-left: 270px;
            flex: 1;
            padding: 2.5rem;
            max-width: 1500px;
        }

        /* Header Bar */
        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header-title h1 {
            font-size: 1.85rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            color: var(--text-dark);
        }

        .header-title p {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-top: 0.3rem;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 0.85rem;
        }

        .role-pill {
            background: #e0e7ff;
            color: var(--primary);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.82rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.4rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.92rem;
            text-decoration: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            transform: translateY(-1px);
        }

        /* Alerts */
        .alert-banner {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.75rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 600;
            font-size: 0.92rem;
        }

        .alert-success { background: var(--success-light); border: 1px solid #bbf7d0; color: #15803d; }
        .alert-danger { background: var(--danger-light); border: 1px solid #fecaca; color: #b91c1c; }

        /* KPI Cards Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.06);
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .stat-label {
            font-size: 0.82rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-muted);
        }

        .stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }

        .stat-icon.indigo { background: var(--primary-light); color: var(--primary); }
        .stat-icon.emerald { background: var(--success-light); color: var(--success); }
        .stat-icon.amber { background: var(--warning-light); color: var(--warning); }
        .stat-icon.purple { background: var(--purple-light); color: var(--purple); }

        .stat-val {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1;
            margin-bottom: 0.65rem;
        }

        .stat-subinfo {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
            font-size: 0.85rem;
            color: var(--text-muted);
            border-top: 1px solid var(--border);
            padding-top: 0.75rem;
            margin-top: 0.5rem;
        }

        .stat-subinfo strong {
            color: var(--text-dark);
            font-weight: 700;
        }

        .stat-pill {
            display: inline-block;
            padding: 0.2rem 0.6rem;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-top: 0.4rem;
            width: fit-content;
        }

        .pill-indigo { background: var(--primary-light); color: var(--primary); }
        .pill-emerald { background: var(--success-light); color: var(--success); }
        .pill-amber { background: var(--warning-light); color: var(--warning); }
        .pill-purple { background: var(--purple-light); color: var(--purple); }

        /* Distribution & Portfolio Health Bar */
        .health-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .health-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .health-header h3 {
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .progress-multi {
            display: flex;
            height: 14px;
            border-radius: 10px;
            overflow: hidden;
            background: #e2e8f0;
            margin-bottom: 1rem;
        }

        .progress-part.available { background: var(--success); }
        .progress-part.reserved { background: var(--warning); }
        .progress-part.sold { background: var(--purple); }

        .progress-legend {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.45rem;
        }

        .legend-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
        }

        .types-chips {
            display: flex;
            gap: 0.65rem;
            margin-top: 1.25rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
            flex-wrap: wrap;
        }

        .type-chip {
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            padding: 0.35rem 0.85rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        /* Filter & Controls Bar */
        .controls-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 1.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .filter-tabs {
            display: flex;
            gap: 0.5rem;
            background: #f1f5f9;
            padding: 0.3rem;
            border-radius: 10px;
        }

        .filter-btn {
            background: none;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.85rem;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .filter-btn:hover {
            color: var(--text-dark);
        }

        .filter-btn.active {
            background: #fff;
            color: var(--text-dark);
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .search-and-view {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .search-box {
            position: relative;
            width: 280px;
        }

        .search-box input {
            width: 100%;
            padding: 0.55rem 1rem 0.55rem 2.4rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.88rem;
            outline: none;
            transition: border-color 0.2s;
        }

        .search-box input:focus {
            border-color: var(--primary);
        }

        .search-box i {
            position: absolute;
            left: 0.8rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .view-toggle {
            display: flex;
            background: #f1f5f9;
            padding: 0.25rem;
            border-radius: 8px;
        }

        .view-btn {
            border: none;
            background: none;
            padding: 0.45rem 0.75rem;
            border-radius: 6px;
            cursor: pointer;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .view-btn.active {
            background: #fff;
            color: var(--primary);
            box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        }

        /* Cards Grid */
        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(330px, 1fr));
            gap: 1.5rem;
        }

        .property-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.03);
            display: flex;
            flex-direction: column;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .property-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px -4px rgba(0,0,0,0.08);
        }

        .property-img {
            height: 200px;
            position: relative;
            background: #cbd5e1;
        }

        .property-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .status-badge {
            position: absolute;
            top: 0.85rem;
            right: 0.85rem;
            padding: 0.35rem 0.85rem;
            border-radius: 9999px;
            font-size: 0.72rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .status-badge.available { background: var(--success); color: white; }
        .status-badge.reserved { background: var(--warning); color: white; }
        .status-badge.sold { background: var(--purple); color: white; }
        .status-badge.pending_survey { background: #0284c7; color: white; }

        .type-badge-top {
            position: absolute;
            top: 0.85rem;
            left: 0.85rem;
            background: rgba(15, 23, 42, 0.75);
            backdrop-filter: blur(4px);
            color: #fff;
            padding: 0.3rem 0.75rem;
            border-radius: 8px;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .property-details {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            flex: 1;
        }

        .property-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-dark);
            line-height: 1.3;
        }

        .property-location {
            font-size: 0.88rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .property-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.88rem;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            padding: 0.75rem 0;
            margin: 0.25rem 0;
        }

        .property-pricing {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
        }

        .property-price {
            font-size: 1.35rem;
            font-weight: 800;
            color: var(--primary);
        }

        .property-perch-rate {
            font-size: 0.78rem;
            color: var(--text-muted);
            font-weight: 600;
        }

        .card-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: auto;
            padding-top: 0.75rem;
        }

        .btn-action-edit {
            flex: 1;
            background: #f1f5f9;
            color: var(--text-dark);
            border: 1px solid var(--border);
            padding: 0.55rem 0.75rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.85rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.35rem;
            transition: all 0.2s ease;
        }

        .btn-action-edit:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .btn-action-delete {
            background: #fff;
            color: var(--danger);
            border: 1px solid #fecaca;
            padding: 0.55rem 0.75rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.85rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .btn-action-delete:hover {
            background: var(--danger);
            color: white;
            border-color: var(--danger);
        }

        .btn-action-icon {
            background: #f8fafc;
            color: var(--text-muted);
            border: 1px solid var(--border);
            padding: 0.55rem 0.75rem;
            border-radius: 8px;
            font-size: 0.9rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .btn-action-icon:hover {
            color: var(--primary);
            border-color: var(--primary);
        }

        /* Table View */
        .property-table-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            display: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 0.85rem 1.25rem;
            color: var(--text-muted);
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
            background: #f8fafc;
        }

        td {
            padding: 1.1rem 1.25rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.92rem;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .table-thumb {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.25rem 0.7rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-pill.available { background: var(--success-light); color: var(--success); }
        .status-pill.reserved { background: var(--warning-light); color: var(--warning); }
        .status-pill.sold { background: var(--purple-light); color: var(--purple); }
        .status-pill.pending_survey { background: #e0f2fe; color: #0369a1; }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 3rem;
            color: #cbd5e1;
            margin-bottom: 1rem;
            display: block;
        }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/property" class="logo" style="display: flex; align-items: center; gap: 0.65rem; text-decoration: none;">
        <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 38px; width: 38px; border-radius: 8px; object-fit: cover; border: 1.5px solid #d4af37;">
        <span>Ceylon<span style="color: #d4af37;">Lands</span></span>
    </a>

    <ul class="nav-links">
        <c:choose>
            <c:when test="${pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                <li class="active"><a href="${pageContext.request.contextPath}/property"><i class="bi bi-grid-1x2-fill"></i> Property Dashboard</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${pageContext.request.contextPath}/"><i class="bi bi-grid-1x2-fill"></i> System Dashboard</a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>
            </c:otherwise>
        </c:choose>

        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
            <li><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>
        </c:if>

        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_SALES')}">
            <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
        </c:if>

        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_SURVEY')}">
            <li><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Surveys & Valuation</a></li>
        </c:if>

        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_LEGAL')}">
            <li><a href="${pageContext.request.contextPath}/legal"><i class="bi bi-file-earmark-text-fill"></i> Legal Docs</a></li>
        </c:if>

        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
            <li><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-person-gear"></i> System Users</a></li>
        </c:if>

        <li style="margin-top: 1rem; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 0.5rem;">
            <a href="${pageContext.request.contextPath}/properties" target="_blank"><i class="bi bi-compass"></i> Public Land Catalog</a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <form action="${pageContext.request.contextPath}/logout" method="POST">
            <button type="submit" style="background: none; border: none; color: #ef4444; font-size: 0.88rem; font-weight: 600; cursor: pointer; display: flex; align-items: center; gap: 0.5rem; padding: 0;">
                <i class="bi bi-box-arrow-right"></i> Log Out (<c:out value="${pageContext.request.userPrincipal.name}" />)
            </button>
        </form>
    </div>
</div>

<!-- Main Content Area -->
<div class="main-container">

    <!-- Header -->
    <div class="header-bar">
        <div class="header-title">
            <h1>Property Portfolio & Land Asset Management</h1>
            <p>Real-time land plots overview, inventory status tracking, and land asset valuations.</p>
        </div>
        <div class="header-actions" style="display: flex; align-items: center; gap: 0.75rem;">
            <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
            <div class="role-pill">
                <i class="bi bi-shield-check"></i>
                <c:choose>
                    <c:when test="${pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                        Property Manager
                    </c:when>
                    <c:otherwise>
                        System Administrator
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                <a href="${pageContext.request.contextPath}/property/add" class="btn-primary">
                    <i class="bi bi-plus-circle-fill"></i> Add New Property Plot
                </a>
            </c:if>
        </div>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty successMsg}">
        <div class="alert-banner alert-success">
            <i class="bi bi-check-circle-fill"></i> ${successMsg}
        </div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert-banner alert-danger">
            <i class="bi bi-exclamation-triangle-fill"></i> ${errorMsg}
        </div>
    </c:if>

    <!-- KPI Statistics Cards -->
    <div class="stats-grid">
        <!-- 1. Total Portfolio -->
        <div class="stat-card">
            <div class="stat-top">
                <div>
                    <div class="stat-label">Total Portfolio</div>
                    <div class="stat-val">${totalProperties}</div>
                </div>
                <div class="stat-icon indigo">
                    <i class="bi bi-layers-half"></i>
                </div>
            </div>
            <div class="stat-subinfo">
                <div>Extent: <strong><fmt:formatNumber value="${totalPerches}" maxFractionDigits="1"/> Perches</strong></div>
                <div>Asset Valuation: <strong>LKR <fmt:formatNumber value="${totalValuation}" maxFractionDigits="0"/></strong></div>
            </div>
            <span class="stat-pill pill-indigo">All Managed Lands</span>
        </div>

        <!-- 2. Available Lands -->
        <div class="stat-card">
            <div class="stat-top">
                <div>
                    <div class="stat-label">Available for Sale</div>
                    <div class="stat-val" style="color: var(--success);">${availableCount}</div>
                </div>
                <div class="stat-icon emerald">
                    <i class="bi bi-check-circle-fill"></i>
                </div>
            </div>
            <div class="stat-subinfo">
                <div>Available Land: <strong><fmt:formatNumber value="${availablePerches}" maxFractionDigits="1"/> Perches</strong></div>
                <div>Market Value: <strong>LKR <fmt:formatNumber value="${availableValuation}" maxFractionDigits="0"/></strong></div>
            </div>
            <span class="stat-pill pill-emerald">${availablePercent}% Ready For Acquisition</span>
        </div>

        <!-- 3. Reserved Plots -->
        <div class="stat-card">
            <div class="stat-top">
                <div>
                    <div class="stat-label">Reserved Plots</div>
                    <div class="stat-val" style="color: var(--warning);">${reservedCount}</div>
                </div>
                <div class="stat-icon amber">
                    <i class="bi bi-hourglass-split"></i>
                </div>
            </div>
            <div class="stat-subinfo">
                <div>Under Deposit: <strong><fmt:formatNumber value="${reservedPerches}" maxFractionDigits="1"/> Perches</strong></div>
                <div>Locked Valuation: <strong>LKR <fmt:formatNumber value="${reservedValuation}" maxFractionDigits="0"/></strong></div>
            </div>
            <span class="stat-pill pill-amber">${reservedPercent}% In Deposit Pipeline</span>
        </div>

        <!-- 4. Sold / Finalized -->
        <div class="stat-card">
            <div class="stat-top">
                <div>
                    <div class="stat-label">Sold & Transferred</div>
                    <div class="stat-val" style="color: var(--purple);">${soldCount}</div>
                </div>
                <div class="stat-icon purple">
                    <i class="bi bi-patch-check-fill"></i>
                </div>
            </div>
            <div class="stat-subinfo">
                <div>Transferred Extent: <strong><fmt:formatNumber value="${soldPerches}" maxFractionDigits="1"/> Perches</strong></div>
                <div>Realized Revenue: <strong>LKR <fmt:formatNumber value="${soldValuation}" maxFractionDigits="0"/></strong></div>
            </div>
            <span class="stat-pill pill-purple">${soldPercent}% Deeds Finalized</span>
        </div>
    </div>

    <!-- Portfolio Health & Zoning Distribution Widget -->
    <div class="health-card">
        <div class="health-header">
            <h3><i class="bi bi-pie-chart-fill" style="color: var(--primary);"></i> Land Asset Distribution & Categorization</h3>
            <div style="font-size: 0.88rem; color: var(--text-muted);">
                Average Land Rate: <strong style="color: var(--text-dark);">LKR <fmt:formatNumber value="${avgPerchPrice}" maxFractionDigits="0"/> / Perch</strong>
            </div>
        </div>

        <!-- Visual Progress Bar -->
        <div class="progress-multi">
            <div class="progress-part available" style="width: ${availablePercent}%;" title="Available: ${availablePercent}%"></div>
            <div class="progress-part reserved" style="width: ${reservedPercent}%;" title="Reserved: ${reservedPercent}%"></div>
            <div class="progress-part sold" style="width: ${soldPercent}%;" title="Sold: ${soldPercent}%"></div>
        </div>

        <!-- Legend -->
        <div class="progress-legend">
            <div class="legend-item">
                <div class="legend-dot" style="background: var(--success);"></div>
                <span>Available: ${availableCount} Plots (${availablePercent}%)</span>
            </div>
            <div class="legend-item">
                <div class="legend-dot" style="background: var(--warning);"></div>
                <span>Reserved: ${reservedCount} Plots (${reservedPercent}%)</span>
            </div>
            <div class="legend-item">
                <div class="legend-dot" style="background: var(--purple);"></div>
                <span>Sold & Closed: ${soldCount} Plots (${soldPercent}%)</span>
            </div>
        </div>

        <!-- Zoning / Land Type Breakdown Chips -->
        <div class="types-chips">
            <span class="type-chip"><i class="bi bi-house-door-fill" style="color: #4f46e5;"></i> Residential: <strong>${residentialCount}</strong></span>
            <span class="type-chip"><i class="bi bi-shop" style="color: #0891b2;"></i> Commercial: <strong>${commercialCount}</strong></span>
            <span class="type-chip"><i class="bi bi-tree-fill" style="color: #16a34a;"></i> Agricultural: <strong>${agriculturalCount}</strong></span>
            <span class="type-chip"><i class="bi bi-buildings-fill" style="color: #ea580c;"></i> Industrial: <strong>${industrialCount}</strong></span>
        </div>
    </div>

    <!-- Filter & Search Controls Bar -->
    <div class="controls-card">
        <!-- Filter Tabs -->
        <div class="filter-tabs">
            <button class="filter-btn active" data-filter="all">All Lands (${totalProperties})</button>
            <button class="filter-btn" data-filter="available">Available (${availableCount})</button>
            <c:if test="${not empty pendingSurveyCount and pendingSurveyCount > 0}">
                <button class="filter-btn" data-filter="pending_survey" style="color: #0284c7;"><i class="bi bi-compass"></i> Under Survey (${pendingSurveyCount})</button>
            </c:if>
            <button class="filter-btn" data-filter="reserved">Reserved (${reservedCount})</button>
            <button class="filter-btn" data-filter="sold">Sold (${soldCount})</button>
        </div>

        <div class="search-and-view">
            <!-- Search Box -->
            <div class="search-box">
                <i class="bi bi-search"></i>
                <input type="text" id="propertySearchInput" placeholder="Search land by name, location, type...">
            </div>

            <!-- View Switcher -->
            <div class="view-toggle">
                <button class="view-btn active" id="btnGridView" title="Grid Cards View"><i class="bi bi-grid-fill"></i></button>
                <button class="view-btn" id="btnTableView" title="Data Table View"><i class="bi bi-table"></i></button>
            </div>
        </div>
    </div>

    <!-- 1. Cards Grid View -->
    <div class="property-grid" id="propertyGridView">
        <c:forEach var="prop" items="${properties}">
            <div class="property-card" data-status="${prop.status.toLowerCase()}" data-search="${prop.title.toLowerCase()} ${prop.location.toLowerCase()} ${prop.type.toLowerCase()}">
                <div class="property-img">
                    <img src="${prop.imageUrl != null && !prop.imageUrl.isEmpty() ? prop.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600'}" alt="${prop.title}" onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600';">
                    <span class="type-badge-top">${prop.type}</span>
                    <span class="status-badge ${prop.status.toLowerCase()}">${prop.status}</span>
                    <c:if test="${prop.imageCount > 1}">
                            <span style="position: absolute; bottom: 0.65rem; left: 0.65rem; background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(4px); color: #ffffff; padding: 0.2rem 0.55rem; border-radius: 12px; font-size: 0.72rem; font-weight: 700; z-index: 2; display: inline-flex; align-items: center; gap: 0.3rem;">
                                <i class="bi bi-camera-fill"></i> ${prop.imageCount} Photos
                            </span>
                    </c:if>
                </div>
                <div class="property-details">
                    <h3 class="property-title">${prop.title}</h3>
                    <p class="property-location"><i class="bi bi-geo-alt-fill" style="color: var(--primary);"></i> ${prop.location}</p>

                    <div class="property-meta">
                        <span><i class="bi bi-aspect-ratio"></i> Extent: <strong>${prop.size} Perches</strong></span>
                        <span><i class="bi bi-tag-fill"></i> Zoning: <strong>${prop.type}</strong></span>
                    </div>

                    <div class="property-pricing">
                        <div class="property-price">LKR <fmt:formatNumber value="${prop.price}" type="number" maxFractionDigits="0"/></div>
                        <div class="property-perch-rate">
                            <c:if test="${prop.size != null and prop.size > 0}">
                                ~LKR <fmt:formatNumber value="${prop.price / prop.size}" maxFractionDigits="0"/> / perch
                            </c:if>
                        </div>
                    </div>

                    <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                        <div class="card-actions">
                            <form action="${pageContext.request.contextPath}/property/quick-status/${prop.id}" method="post" style="margin: 0; flex: 1.2;">
                                <select name="status" onchange="this.form.submit()" title="Quick Update Status" style="width: 100%; padding: 0.5rem 0.4rem; border-radius: 8px; border: 1px solid var(--border); background: #f8fafc; cursor: pointer; color: var(--text-dark); font-weight: 700; font-size: 0.8rem;">
                                    <option value="AVAILABLE" ${prop.status != null and prop.status.equalsIgnoreCase('AVAILABLE') ? 'selected' : ''}>✓ Available</option>
                                    <option value="RESERVED" ${prop.status != null and prop.status.equalsIgnoreCase('RESERVED') ? 'selected' : ''}>⏳ Reserved</option>
                                    <option value="SOLD" ${prop.status != null and prop.status.equalsIgnoreCase('SOLD') ? 'selected' : ''}>⛔ Sold</option>
                                    <option value="PENDING_SURVEY" ${prop.status != null and prop.status.equalsIgnoreCase('PENDING_SURVEY') ? 'selected' : ''}>📐 Under Survey</option>
                                </select>
                            </form>
                            <a href="${pageContext.request.contextPath}/property/edit/${prop.id}" class="btn-action-edit">
                                <i class="bi bi-pencil-square"></i> Edit
                            </a>
                            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_SURVEY')}">
                                <a href="${pageContext.request.contextPath}/survey" class="btn-action-icon" title="View Survey Dossier">
                                    <i class="bi bi-geo-alt"></i>
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/properties/detail/${prop.id}" target="_blank" class="btn-action-icon" title="Public View">
                                <i class="bi bi-box-arrow-up-right"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/property/delete/${prop.id}" class="btn-action-delete" title="Delete Property" onclick="return confirm('Are you sure you want to delete plot #${prop.id} - ${prop.title}?');">
                                <i class="bi bi-trash-fill"></i>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 2. Enterprise Table View -->
    <div class="property-table-card" id="propertyTableView">
        <table>
            <thead>
            <tr>
                <th>Plot ID</th>
                <th>Land Project</th>
                <th>Location</th>
                <th>Zoning</th>
                <th>Extent (Perches)</th>
                <th>Total Price (LKR)</th>
                <th>Per-Perch Rate</th>
                <th>Status & Quick Update</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="prop" items="${properties}">
                <tr data-status="${prop.status.toLowerCase()}" data-search="${prop.title.toLowerCase()} ${prop.location.toLowerCase()} ${prop.type.toLowerCase()}">
                    <td style="font-weight: 700; color: var(--text-muted);">#${prop.id}</td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                            <img src="${prop.imageUrl != null && !prop.imageUrl.isEmpty() ? prop.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=200'}" class="table-thumb" alt="Thumbnail" onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=200';">
                            <div>
                                <div style="font-weight: 700; color: var(--text-dark); display: flex; align-items: center; gap: 0.4rem;">
                                        ${prop.title}
                                    <c:if test="${prop.imageCount > 1}">
                                                <span style="background: rgba(15, 23, 42, 0.08); color: #475569; padding: 0.1rem 0.4rem; border-radius: 6px; font-size: 0.68rem; font-weight: 700; display: inline-flex; align-items: center; gap: 0.25rem;">
                                                    <i class="bi bi-camera-fill"></i> ${prop.imageCount}
                                                </span>
                                    </c:if>
                                </div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${prop.location}</div>
                            </div>
                        </div>
                    </td>
                    <td><i class="bi bi-geo-alt" style="color: var(--primary);"></i> ${prop.location}</td>
                    <td><span class="type-chip" style="font-size: 0.75rem;">${prop.type}</span></td>
                    <td style="font-weight: 700;">${prop.size}</td>
                    <td style="font-weight: 800; color: var(--primary);">LKR <fmt:formatNumber value="${prop.price}" type="number" maxFractionDigits="0"/></td>
                    <td style="font-size: 0.85rem; color: var(--text-muted);">
                        <c:if test="${prop.size != null and prop.size > 0}">
                            LKR <fmt:formatNumber value="${prop.price / prop.size}" maxFractionDigits="0"/>
                        </c:if>
                    </td>
                    <td>
                        <div style="display: flex; flex-direction: column; gap: 0.35rem;">
                                    <span class="status-pill ${prop.status.toLowerCase()}">
                                        <c:choose>
                                            <c:when test="${prop.status != null and prop.status.equalsIgnoreCase('AVAILABLE')}"><i class="bi bi-check-circle-fill"></i> Available</c:when>
                                            <c:when test="${prop.status != null and prop.status.equalsIgnoreCase('PENDING_SURVEY')}"><i class="bi bi-compass-fill"></i> Under Survey</c:when>
                                            <c:when test="${prop.status != null and prop.status.equalsIgnoreCase('RESERVED')}"><i class="bi bi-hourglass-split"></i> Reserved</c:when>
                                            <c:when test="${prop.status != null and prop.status.equalsIgnoreCase('SOLD')}"><i class="bi bi-patch-check-fill"></i> Sold</c:when>
                                            <c:otherwise>${prop.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN') or pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                                <form action="${pageContext.request.contextPath}/property/quick-status/${prop.id}" method="post" style="margin: 0;">
                                    <select name="status" onchange="this.form.submit()" title="Quick Update Status" style="font-size: 0.72rem; padding: 0.25rem 0.4rem; border-radius: 6px; border: 1px solid #cbd5e1; background: #fff; cursor: pointer; color: var(--text-dark); font-weight: 600;">
                                        <option value="AVAILABLE" ${prop.status != null and prop.status.equalsIgnoreCase('AVAILABLE') ? 'selected' : ''}>Available</option>
                                        <option value="RESERVED" ${prop.status != null and prop.status.equalsIgnoreCase('RESERVED') ? 'selected' : ''}>Reserved</option>
                                        <option value="SOLD" ${prop.status != null and prop.status.equalsIgnoreCase('SOLD') ? 'selected' : ''}>Sold</option>
                                        <option value="PENDING_SURVEY" ${prop.status != null and prop.status.equalsIgnoreCase('PENDING_SURVEY') ? 'selected' : ''}>Under Survey</option>
                                    </select>
                                </form>
                            </c:if>
                        </div>
                    </td>
                    <td>
                        <div style="display: flex; gap: 0.4rem;">
                            <a href="${pageContext.request.contextPath}/property/edit/${prop.id}" class="btn-action-edit" style="padding: 0.35rem 0.65rem; font-size: 0.8rem;">
                                <i class="bi bi-pencil-square"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/property/delete/${prop.id}" class="btn-action-delete" style="padding: 0.35rem 0.65rem; font-size: 0.8rem;" onclick="return confirm('Are you sure you want to delete this property?');">
                                <i class="bi bi-trash"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="emptySearchResults" class="empty-state" style="display: none;">
        <i class="bi bi-search"></i>
        <h3>No Land Plots Found</h3>
        <p>No property plots matched your current search or status filter criteria.</p>
    </div>

</div>

<!-- Client-side Interactive Filter & Search Script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var currentFilter = 'all';
        var filterButtons = document.querySelectorAll('.filter-btn');
        var searchInput = document.getElementById('propertySearchInput');
        var gridView = document.getElementById('propertyGridView');
        var tableView = document.getElementById('propertyTableView');
        var btnGridView = document.getElementById('btnGridView');
        var btnTableView = document.getElementById('btnTableView');
        var emptyResults = document.getElementById('emptySearchResults');

        // Tab Filtering
        filterButtons.forEach(function(btn) {
            btn.addEventListener('click', function() {
                filterButtons.forEach(function(b) { b.classList.remove('active'); });
                this.classList.add('active');
                currentFilter = this.getAttribute('data-filter');
                applyFilters();
            });
        });

        // Live Search
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                applyFilters();
            });
        }

        // View Toggle
        if (btnGridView && btnTableView) {
            btnGridView.addEventListener('click', function() {
                btnGridView.classList.add('active');
                btnTableView.classList.remove('active');
                gridView.style.display = 'grid';
                tableView.style.display = 'none';
            });

            btnTableView.addEventListener('click', function() {
                btnTableView.classList.add('active');
                btnGridView.classList.remove('active');
                gridView.style.display = 'none';
                tableView.style.display = 'block';
            });
        }

        function applyFilters() {
            var query = searchInput ? searchInput.value.toLowerCase().trim() : '';
            var cards = document.querySelectorAll('#propertyGridView .property-card');
            var rows = document.querySelectorAll('#propertyTableView tbody tr');
            var visibleCount = 0;

            cards.forEach(function(card) {
                var status = card.getAttribute('data-status');
                var searchText = card.getAttribute('data-search') || '';

                var matchesStatus = (currentFilter === 'all') || (status === currentFilter);
                var matchesQuery = (query === '') || (searchText.indexOf(query) !== -1);

                if (matchesStatus && matchesQuery) {
                    card.style.display = 'flex';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });

            rows.forEach(function(row) {
                var status = row.getAttribute('data-status');
                var searchText = row.getAttribute('data-search') || '';

                var matchesStatus = (currentFilter === 'all') || (status === currentFilter);
                var matchesQuery = (query === '') || (searchText.indexOf(query) !== -1);

                if (matchesStatus && matchesQuery) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            if (emptyResults) {
                if (visibleCount === 0) {
                    emptyResults.style.display = 'block';
                } else {
                    emptyResults.style.display = 'none';
                }
            }
        }
    });
</script>
</body>
</html>