<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Land Survey & Valuation Management - Ceylon Lands</title>
    <!-- Fonts & Icons -->
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
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.82rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .role-pill.surveyor { background: #dcfce7; color: #15803d; }
        .role-pill.property { background: #e0e7ff; color: #4f46e5; }
        .role-pill.admin { background: #f3e8ff; color: #7e22ce; }

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
            font-size: 0.85rem;
            color: var(--text-muted);
            border-top: 1px solid var(--border);
            padding-top: 0.75rem;
            margin-top: 0.5rem;
        }

        /* Pending Queue Section */
        .queue-card {
            background: #fffbeb;
            border: 1px solid #fde68a;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.08);
        }

        .queue-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .queue-header h3 {
            font-size: 1.15rem;
            font-weight: 800;
            color: #92400e;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .queue-header p {
            color: #b45309;
            font-size: 0.88rem;
            margin-top: 0.2rem;
        }

        .queue-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 1.25rem;
        }

        .queue-item {
            background: #ffffff;
            border: 1px solid #fef3c7;
            border-radius: 12px;
            padding: 1.25rem;
            box-shadow: 0 2px 6px rgba(245, 158, 11, 0.05);
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .queue-item-top {
            display: flex;
            gap: 0.85rem;
            align-items: center;
        }

        .queue-thumb {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
            background: #e2e8f0;
        }

        .queue-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .queue-loc {
            font-size: 0.82rem;
            color: var(--text-muted);
        }

        .queue-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            background: #f8fafc;
            padding: 0.5rem 0.75rem;
            border-radius: 8px;
        }

        .btn-certify {
            background: #10b981;
            color: white;
            border: none;
            padding: 0.65rem 1.2rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.88rem;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            transition: all 0.2s ease;
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.25);
        }

        .btn-certify:hover {
            background: #059669;
            transform: translateY(-1px);
        }

        /* Certified Table Section */
        .table-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
            padding: 1.5rem;
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .table-header h2 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .search-box {
            position: relative;
            width: 300px;
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

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            padding: 0.85rem 1rem;
            color: var(--text-muted);
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
            background: #f8fafc;
        }

        td {
            padding: 1.1rem 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.92rem;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-pill.approved { background: var(--success-light); color: var(--success); }
        .status-pill.pending { background: var(--warning-light); color: var(--warning); }

        .btn-inspect {
            background: #f1f5f9;
            color: var(--text-dark);
            border: 1px solid var(--border);
            padding: 0.45rem 0.85rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.82rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            transition: all 0.2s ease;
        }

        .btn-inspect:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .btn-delete {
            background: #fff;
            color: var(--danger);
            border: 1px solid #fecaca;
            padding: 0.45rem 0.75rem;
            border-radius: 8px;
            font-size: 0.85rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .btn-delete:hover {
            background: var(--danger);
            color: white;
            border-color: var(--danger);
        }

        /* Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 1.5rem;
        }

        .modal-card {
            background: #fff;
            border-radius: 20px;
            max-width: 650px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .modal-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--text-dark);
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-muted);
        }

        .modal-body {
            padding: 2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .form-group {
            margin-bottom: 1.25rem;
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .form-group label {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .form-group input, .form-group select, .form-group textarea {
            padding: 0.65rem 0.85rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.9rem;
            outline: none;
        }

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: var(--primary);
        }

        .dossier-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .dossier-item {
            background: #f8fafc;
            padding: 0.85rem 1rem;
            border-radius: 10px;
            border: 1px solid var(--border);
        }

        .dossier-item span {
            display: block;
            font-size: 0.75rem;
            text-transform: uppercase;
            color: var(--text-muted);
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .dossier-item strong {
            font-size: 0.95rem;
            color: var(--text-dark);
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
                <c:when test="${pageContext.request.isUserInRole('ROLE_SURVEY')}">
                    <li class="active"><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Surveys & Valuation</a></li>
                    <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Land Portfolio</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/"><i class="bi bi-grid-1x2-fill"></i> System Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>
                    <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                        <li><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>
                        <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
                    </c:if>
                    <li class="active"><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Surveys & Valuation</a></li>
                    <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                        <li><a href="${pageContext.request.contextPath}/legal"><i class="bi bi-file-earmark-text-fill"></i> Legal Docs</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-person-gear"></i> System Users</a></li>
                    </c:if>
                </c:otherwise>
            </c:choose>

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

    <!-- Main Container -->
    <div class="main-container">

        <!-- Header -->
        <div class="header-bar">
            <div class="header-title">
                <h1>Land Survey & Cadastral Valuation Management</h1>
                <p>Boundary beacons demarcation, official plan certification, topography inspection, and market valuations.</p>
            </div>
            <div class="header-actions" style="display: flex; align-items: center; gap: 0.75rem;">
                <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
                <div class="role-pill surveyor">
                    <i class="bi bi-patch-check-fill"></i> Licensed Cadastral Surveyor
                </div>
                <button class="btn-primary" onclick="openNewSurveyModal()">
                    <i class="bi bi-plus-circle-fill"></i> Register Survey Plan
                </button>
            </div>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty surveySuccess}">
            <div class="alert-banner alert-success">
                <i class="bi bi-check-circle-fill"></i> ${surveySuccess}
            </div>
        </c:if>
        <c:if test="${not empty surveyError}">
            <div class="alert-banner alert-danger">
                <i class="bi bi-exclamation-triangle-fill"></i> ${surveyError}
            </div>
        </c:if>

        <!-- KPI Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-top">
                    <div>
                        <div class="stat-label">Total Survey Plans</div>
                        <div class="stat-val">${totalSurveys}</div>
                    </div>
                    <div class="stat-icon indigo">
                        <i class="bi bi-geo-fill"></i>
                    </div>
                </div>
                <div class="stat-subinfo">Registered Cadastral Plans</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div>
                        <div class="stat-label">Approved & Certified</div>
                        <div class="stat-val" style="color: var(--success);">${approvedSurveys}</div>
                    </div>
                    <div class="stat-icon emerald">
                        <i class="bi bi-patch-check-fill"></i>
                    </div>
                </div>
                <div class="stat-subinfo">Active & Available for Public Sale</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div>
                        <div class="stat-label">Pending Inspections</div>
                        <div class="stat-val" style="color: var(--warning);">${inProgressSurveys}</div>
                    </div>
                    <div class="stat-icon amber">
                        <i class="bi bi-hourglass-split"></i>
                    </div>
                </div>
                <div class="stat-subinfo">Needs Surveyor Field Action</div>
            </div>

            <div class="stat-card">
                <div class="stat-top">
                    <div>
                        <div class="stat-label">Certified Valuation</div>
                        <div class="stat-val" style="font-size: 1.6rem; color: var(--purple);">
                            LKR <fmt:formatNumber value="${totalValuation}" maxFractionDigits="0"/>
                        </div>
                    </div>
                    <div class="stat-icon purple">
                        <i class="bi bi-cash-stack"></i>
                    </div>
                </div>
                <div class="stat-subinfo">Total Approved Land Asset Value</div>
            </div>
        </div>

        <!-- 🟡 Pending Field Inspections & Certification Queue -->
        <c:if test="${not empty pendingSurveysList}">
            <div class="queue-card">
                <div class="queue-header">
                    <div>
                        <h3><i class="bi bi-exclamation-circle-fill"></i> Lands Awaiting Surveyor Field Demarcation & Approval</h3>
                        <p>Newly registered land plots from Property Management requiring boundary beacons fixing and plan certification before public listing.</p>
                    </div>
                    <span style="background: #f59e0b; color: #fff; padding: 0.35rem 0.85rem; border-radius: 20px; font-size: 0.82rem; font-weight: 800;">
                        ${pendingSurveysList.size()} Action Required
                    </span>
                </div>

                <div class="queue-grid">
                    <c:forEach var="ps" items="${pendingSurveysList}">
                        <div class="queue-item">
                            <div class="queue-item-top">
                                <img src="${ps.property != null && ps.property.imageUrl != null ? ps.property.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=200'}" class="queue-thumb" alt="Land">
                                <div>
                                    <div class="queue-title">${ps.property != null ? ps.property.title : 'Unassigned Plot'}</div>
                                    <div class="queue-loc"><i class="bi bi-geo-alt-fill" style="color: var(--primary);"></i> ${ps.property != null ? ps.property.location : 'Location N/A'}</div>
                                </div>
                            </div>
                            <div class="queue-meta">
                                <span>Extent: <strong>${ps.landExtent}</strong></span>
                                <span>Target Value: <strong>LKR <fmt:formatNumber value="${ps.valuationAmount}" maxFractionDigits="0"/></strong></span>
                            </div>
                            <c:choose>
                                <c:when test="${isSurveyor}">
                                    <button class="btn-certify" onclick="openApproveModal(${ps.id}, '${ps.property != null ? ps.property.title : ''}', '${ps.property != null ? ps.property.size : ''}', '${ps.valuationAmount}')">
                                        <i class="bi bi-check2-circle"></i> Inspect & Certify Survey
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <div style="background: #f1f5f9; color: var(--text-muted); text-align: center; padding: 0.6rem; border-radius: 8px; font-size: 0.82rem; font-weight: 700;">
                                        <i class="bi bi-clock-history"></i> Under Cadastral Surveyor Review
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- 🟢 Official Cadastral Survey Records Table -->
        <div class="table-card">
            <div class="table-header">
                <h2>Certified Cadastral Surveys & Valuations</h2>
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" id="surveySearchInput" placeholder="Search by plan, surveyor, plot...">
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Survey Dossier</th>
                        <th>Plan & Lot</th>
                        <th>Land Plot</th>
                        <th>Extent</th>
                        <th>Certified Surveyor</th>
                        <th>Market Valuation</th>
                        <th>Govt Valuation</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="surveyTableBody">
                    <c:forEach var="s" items="${surveys}">
                        <tr data-search="${s.surveyNumber.toLowerCase()} ${s.planNumber != null ? s.planNumber.toLowerCase() : ''} ${s.surveyorName.toLowerCase()} ${s.property != null ? s.property.title.toLowerCase() : ''}">
                            <td style="font-weight: 700; color: var(--text-dark);">
                                ${s.surveyNumber}
                                <div style="font-size: 0.78rem; color: var(--text-muted);">${s.surveyDate}</div>
                            </td>
                            <td>
                                <strong>${s.planNumber != null && !s.planNumber.isEmpty() ? s.planNumber : 'Pending Plan'}</strong>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${s.lotNumber != null ? s.lotNumber : 'Lot TBD'}</div>
                            </td>
                            <td>
                                <div style="font-weight: 700;">${s.property != null ? s.property.title : 'Unlinked Land'}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);">${s.property != null ? s.property.location : ''}</div>
                            </td>
                            <td style="font-weight: 700;">${s.landExtent}</td>
                            <td>${s.surveyorName}</td>
                            <td style="font-weight: 800; color: var(--primary);">
                                LKR <fmt:formatNumber value="${s.valuationAmount}" maxFractionDigits="0"/>
                            </td>
                            <td style="font-size: 0.88rem; color: var(--text-muted);">
                                LKR <fmt:formatNumber value="${s.governmentValuation}" maxFractionDigits="0"/>
                            </td>
                            <td>
                                <span class="status-pill ${s.status.toLowerCase() == 'approved' or s.status.toLowerCase() == 'completed' ? 'approved' : 'pending'}">
                                    <i class="bi bi-circle-fill" style="font-size: 0.5rem;"></i> ${s.status}
                                </span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 0.4rem;">
                                    <button class="btn-inspect" onclick="inspectSurvey(${s.id})">
                                        <i class="bi bi-file-earmark-text"></i> Dossier
                                    </button>
                                    <c:if test="${isSurveyor}">
                                        <a href="${pageContext.request.contextPath}/survey/delete/${s.id}" class="btn-delete" title="Delete Survey" onclick="return confirm('Delete survey dossier #${s.surveyNumber}?');">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <!-- Modal 1: Inspect Survey Dossier (Read-Only) -->
    <div class="modal-overlay" id="dossierModal">
        <div class="modal-card">
            <div class="modal-header">
                <h3 id="dossierTitle">Cadastral Survey Dossier</h3>
                <button class="modal-close" onclick="closeModal('dossierModal')">&times;</button>
            </div>
            <div class="modal-body">
                <div class="dossier-grid">
                    <div class="dossier-item">
                        <span>Survey Dossier No</span>
                        <strong id="dossierNumber">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>Plan & Lot Number</span>
                        <strong id="dossierPlanLot">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>Certified Extent</span>
                        <strong id="dossierExtent">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>Licensed Surveyor</span>
                        <strong id="dossierSurveyor">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>Assessed Market Valuation</span>
                        <strong id="dossierValuation" style="color: var(--primary);">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>Government Department Valuation</span>
                        <strong id="dossierGovtVal">---</strong>
                    </div>
                </div>

                <h4 style="font-size: 0.95rem; font-weight: 700; margin-bottom: 0.75rem;">Demarcated Physical Boundaries</h4>
                <div class="dossier-grid">
                    <div class="dossier-item">
                        <span>North Boundary</span>
                        <strong id="dossierNorth">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>South Boundary</span>
                        <strong id="dossierSouth">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>East Boundary</span>
                        <strong id="dossierEast">---</strong>
                    </div>
                    <div class="dossier-item">
                        <span>West Boundary</span>
                        <strong id="dossierWest">---</strong>
                    </div>
                </div>

                <div class="dossier-item" style="margin-bottom: 1rem;">
                    <span>Topography & Utilities</span>
                    <p id="dossierUtilities" style="font-size: 0.88rem; margin-top: 0.25rem;">---</p>
                </div>

                <div class="dossier-item">
                    <span>Surveyor Certification Remarks</span>
                    <p id="dossierRemarks" style="font-size: 0.88rem; margin-top: 0.25rem; font-style: italic;">---</p>
                </div>

                <div style="margin-top: 1.5rem; text-align: right;">
                    <button class="btn-inspect" onclick="closeModal('dossierModal')">Close Dossier</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal 2: Certify & Approve Survey Modal (Surveyors Only) -->
    <c:if test="${isSurveyor}">
        <div class="modal-overlay" id="approveModal">
            <div class="modal-card">
                <div class="modal-header">
                    <h3>Certify & Approve Cadastral Survey</h3>
                    <button class="modal-close" onclick="closeModal('approveModal')">&times;</button>
                </div>
                <form action="${pageContext.request.contextPath}/survey/approve" method="POST">
                    <input type="hidden" id="approveSurveyId" name="surveyId">
                    <div class="modal-body">
                        <p style="color: var(--text-muted); font-size: 0.88rem; margin-bottom: 1.25rem;">
                            Certifying this survey will authenticate the boundary demarcation and <strong>automatically activate the property for public sale</strong>.
                        </p>

                        <div class="form-group">
                            <label>Target Land Plot</label>
                            <input type="text" id="approveLandTitle" readonly style="background: #f1f5f9; font-weight: 700;">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="approvePlanNumber">Survey Plan Number</label>
                                <input type="text" id="approvePlanNumber" name="planNumber" required placeholder="e.g. PP/WP/COL/2026/89">
                            </div>
                            <div class="form-group">
                                <label for="approveLotNumber">Lot Number</label>
                                <input type="text" id="approveLotNumber" name="lotNumber" required placeholder="e.g. Lot 05B">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="approveExtent">Certified Extent (Perches)</label>
                                <input type="number" step="0.1" id="approveExtent" name="certifiedExtent" required placeholder="e.g. 12.5">
                            </div>
                            <div class="form-group">
                                <label for="approveValuation">Assessed Valuation (LKR)</label>
                                <input type="number" step="1000" id="approveValuation" name="valuationAmount" required placeholder="e.g. 3500000">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="approveSurveyorName">Licensed Surveyor / Valuer Name</label>
                            <input type="text" id="approveSurveyorName" name="surveyorName" required value="Eng. K. D. Rajapaksha (Licensed Surveyor)" placeholder="Surveyor Full Name">
                        </div>

                        <div class="form-group">
                            <label for="approveRemarks">Certification Remarks & Boundary Notes</label>
                            <textarea id="approveRemarks" name="remarks" rows="3" placeholder="Boundary stones fixed. Plan authenticated for Deed of Transfer registration.">All 4 corner boundary beacons verified with GPS coordinates. Title deed boundary measurements authenticated.</textarea>
                        </div>

                        <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                            <button type="button" class="btn-inspect" style="flex: 1;" onclick="closeModal('approveModal')">Cancel</button>
                            <button type="submit" class="btn-certify" style="flex: 2;">
                                <i class="bi bi-patch-check-fill"></i> Approve & Publish Land Plot
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal 3: Register New Survey Plan -->
        <div class="modal-overlay" id="newSurveyModal">
            <div class="modal-card">
                <div class="modal-header">
                    <h3>Register New Cadastral Survey Dossier</h3>
                    <button class="modal-close" onclick="closeModal('newSurveyModal')">&times;</button>
                </div>
                <form action="${pageContext.request.contextPath}/survey/save" method="POST">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="newPropertyId">Select Land Plot</label>
                            <select id="newPropertyId" name="propertyId" required>
                                <option value="">-- Choose a Property --</option>
                                <c:forEach var="p" items="${properties}">
                                    <option value="${p.id}">${p.title} (${p.location}) - ${p.status}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="newSurveyNumber">Survey Number</label>
                                <input type="text" id="newSurveyNumber" name="surveyNumber" required placeholder="e.g. SRV-2026-005">
                            </div>
                            <div class="form-group">
                                <label for="newSurveyDateStr">Survey Date</label>
                                <input type="date" id="newSurveyDateStr" name="surveyDateStr">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="newPlanNumber">Plan Number</label>
                                <input type="text" id="newPlanNumber" name="planNumber" required placeholder="e.g. PP/WP/GAM/4521">
                            </div>
                            <div class="form-group">
                                <label for="newLotNumber">Lot Number</label>
                                <input type="text" id="newLotNumber" name="lotNumber" required placeholder="e.g. Lot 12">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="newLandExtent">Land Extent</label>
                                <input type="text" id="newLandExtent" name="landExtent" required placeholder="e.g. 15.0 Perches">
                            </div>
                            <div class="form-group">
                                <label for="newValuationAmount">Market Valuation (LKR)</label>
                                <input type="number" id="newValuationAmount" name="valuationAmount" step="1000" required placeholder="e.g. 4500000">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newSurveyorName">Surveyor Name</label>
                            <input type="text" id="newSurveyorName" name="surveyorName" required placeholder="e.g. Eng. Sunil Weerasinghe">
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="newStatus">Certification Status</label>
                                <select id="newStatus" name="status">
                                    <option value="APPROVED">APPROVED (Certified & Activates Land)</option>
                                    <option value="IN_PROGRESS">IN_PROGRESS (Under Field Inspection)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="newGovernmentValuation">Govt Valuation (LKR)</label>
                                <input type="number" id="newGovernmentValuation" name="governmentValuation" step="1000" placeholder="e.g. 4000000">
                            </div>
                        </div>

                        <div style="display: flex; gap: 1rem; margin-top: 1.5rem;">
                            <button type="button" class="btn-inspect" style="flex: 1;" onclick="closeModal('newSurveyModal')">Cancel</button>
                            <button type="submit" class="btn-primary" style="flex: 2;">Save Survey Record</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Client-side Scripts -->
    <script>
        function openModal(id) {
            document.getElementById(id).style.display = 'flex';
        }

        function closeModal(id) {
            document.getElementById(id).style.display = 'none';
        }

        function openNewSurveyModal() {
            openModal('newSurveyModal');
        }

        function openApproveModal(surveyId, title, extent, valuation) {
            document.getElementById('approveSurveyId').value = surveyId;
            document.getElementById('approveLandTitle').value = title;
            document.getElementById('approveExtent').value = extent || '';
            document.getElementById('approveValuation').value = valuation || '';
            openModal('approveModal');
        }

        function inspectSurvey(id) {
            fetch('${pageContext.request.contextPath}/survey/api/' + id)
                .then(function(res) { return res.json(); })
                .then(function(data) {
                    document.getElementById('dossierNumber').innerText = data.surveyNumber || 'N/A';
                    document.getElementById('dossierPlanLot').innerText = (data.planNumber || 'N/A') + ' - ' + (data.lotNumber || 'N/A');
                    document.getElementById('dossierExtent').innerText = data.landExtent || 'N/A';
                    document.getElementById('dossierSurveyor').innerText = data.surveyorName || 'N/A';
                    document.getElementById('dossierValuation').innerText = data.valuationAmount ? 'LKR ' + Number(data.valuationAmount).toLocaleString() : 'N/A';
                    document.getElementById('dossierGovtVal').innerText = data.governmentValuation ? 'LKR ' + Number(data.governmentValuation).toLocaleString() : 'N/A';
                    document.getElementById('dossierNorth').innerText = data.northBoundary || 'Not recorded';
                    document.getElementById('dossierSouth').innerText = data.southBoundary || 'Not recorded';
                    document.getElementById('dossierEast').innerText = data.eastBoundary || 'Not recorded';
                    document.getElementById('dossierWest').innerText = data.westBoundary || 'Not recorded';
                    document.getElementById('dossierUtilities').innerText = (data.topography || '') + ' | ' + (data.accessRoadWidth || '') + ' | ' + (data.utilitiesStatus || '');
                    document.getElementById('dossierRemarks').innerText = data.remarks || 'No surveyor remarks logged.';
                    openModal('dossierModal');
                })
                .catch(function(err) {
                    alert('Error loading survey dossier: ' + err);
                });
        }

        // Live Search
        var searchInput = document.getElementById('surveySearchInput');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                var query = this.value.toLowerCase().trim();
                var rows = document.querySelectorAll('#surveyTableBody tr');
                rows.forEach(function(row) {
                    var text = row.getAttribute('data-search') || '';
                    if (query === '' || text.indexOf(query) !== -1) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        }
    </script>
</body>
</html>