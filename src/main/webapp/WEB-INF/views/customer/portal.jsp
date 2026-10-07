<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Portal - Ceylon Lands</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --bg-color: #f8fafc;
            --primary: #0e7231;
            --primary-hover: #08431c;
            --secondary: #d4af37;
            --secondary-hover: #bfa030;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --card-bg: #ffffff;
            --white: #ffffff;
            --dark-header: #07120a;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
        }

        @media print {
            body * { visibility: hidden !important; }
            #officialCertModal, #officialCertModal * { visibility: visible !important; }
            #officialCertModal { position: absolute !important; left: 0 !important; top: 0 !important; width: 100% !important; background: #fff !important; padding: 0 !important; display: block !important; }
            .no-print { display: none !important; }
            #printableCertificate { margin: 0 !important; border-width: 4px !important; }
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        h1, h2, h3, h4, .logo, .stat-value {
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 1. Header Navigation */
        nav {
            background-color: rgba(7, 18, 10, 0.96);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(212, 175, 55, 0.25);
            padding: 1.1rem 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--white);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i { color: #22c55e; }
        .logo .highlight { color: var(--secondary); }

        .nav-links {
            display: flex;
            gap: 1.8rem;
            list-style: none;
            align-items: center;
        }

        .nav-links a {
            color: #cbd5e1;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .nav-links a:hover, .nav-links a.active {
            color: var(--secondary);
        }

        .btn-outline-portal {
            padding: 0.55rem 1.25rem;
            border: 1px solid rgba(212, 175, 55, 0.5);
            color: var(--secondary) !important;
            border-radius: 30px;
            font-weight: 600 !important;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            transition: all 0.3s ease;
        }

        .btn-outline-portal:hover {
            background-color: var(--secondary);
            color: #000 !important;
        }

        /* 2. Banner */
        .portal-header {
            background: linear-gradient(135deg, #07120a 0%, #0d2818 100%);
            color: var(--white);
            padding: 3rem 5%;
            border-bottom: 1px solid rgba(212, 175, 55, 0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .portal-title h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 0.35rem;
        }

        .portal-title p {
            color: #94a3b8;
            font-size: 1rem;
        }

        .customer-chip {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .customer-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: var(--secondary);
            color: #07120a;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 1.2rem;
        }

        /* 3. Main Portal Grid */
        .portal-container {
            max-width: 1350px;
            margin: -1.5rem auto 4rem auto;
            padding: 0 5%;
            width: 100%;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 2rem;
            position: relative;
            z-index: 10;
        }

        @media (max-width: 900px) {
            .portal-container {
                grid-template-columns: 1fr;
            }
        }

        /* Sidebar Tabs */
        .portal-sidebar {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.5rem 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            height: fit-content;
        }

        .tab-btn {
            display: flex;
            align-items: center;
            gap: 0.85rem;
            padding: 0.85rem 1.2rem;
            color: var(--text-muted);
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            border: none;
            background: transparent;
            width: 100%;
            text-align: left;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .tab-btn i {
            font-size: 1.15rem;
        }

        .tab-btn:hover {
            background: #f1f5f9;
            color: var(--text-dark);
        }

        .tab-btn.active {
            background: #0b5e28;
            color: #fff;
            box-shadow: 0 4px 12px rgba(11, 94, 40, 0.25);
        }

        .tab-btn .badge-pill {
            margin-left: auto;
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 0.2rem 0.6rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .tab-btn:not(.active) .badge-pill {
            background: #e2e8f0;
            color: var(--text-dark);
        }

        /* Content Area */
        .portal-content {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            min-height: 550px;
        }

        .content-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .content-header h2 {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .content-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-top: 0.25rem;
        }

        /* Metric Cards */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2.5rem;
        }

        .metric-card {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1.25rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .metric-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.06);
        }

        .metric-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }

        .icon-wishlist { background: rgba(239, 68, 68, 0.12); color: #ef4444; }
        .icon-inquiry { background: rgba(14, 165, 233, 0.12); color: #0284c7; }
        .icon-reviews { background: rgba(245, 158, 11, 0.12); color: #d97706; }
        .icon-support { background: rgba(16, 185, 129, 0.12); color: #059669; }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1;
        }

        .stat-label {
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 600;
            margin-top: 0.35rem;
        }

        /* Forms */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem;
        }

        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
        }

        .form-group {
            margin-bottom: 1.25rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        @media (max-width: 600px) {
            .form-group.full-width { grid-column: span 1; }
        }

        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 0.85rem 1.1rem;
            border: 1px solid var(--border);
            border-radius: 10px;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.2s ease;
            background: #ffffff;
        }

        .form-control:focus {
            border-color: #0b5e28;
            box-shadow: 0 0 0 3px rgba(11, 94, 40, 0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 110px;
        }

        .btn-action {
            background: #0b5e28;
            color: #fff;
            border: none;
            padding: 0.85rem 1.8rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 0.95rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            background: #08431c;
            transform: translateY(-1px);
        }

        /* Wishlist Cards */
        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1.5rem;
        }

        .wishlist-card {
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            background: #fff;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            flex-direction: column;
        }

        .wishlist-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -6px rgba(0,0,0,0.08);
        }

        .wishlist-img-wrap {
            height: 160px;
            position: relative;
            overflow: hidden;
        }

        .wishlist-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .wishlist-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(7, 18, 10, 0.8);
            color: #22c55e;
            padding: 0.25rem 0.6rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .wishlist-body {
            padding: 1.25rem;
            display: flex;
            flex-direction: column;
            flex: 1;
            gap: 0.5rem;
        }

        .wishlist-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .wishlist-location {
            font-size: 0.85rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }

        .wishlist-price {
            font-size: 1.15rem;
            font-weight: 800;
            color: #0b5e28;
            margin-top: 0.25rem;
        }

        .wishlist-actions {
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid #f1f5f9;
            display: flex;
            gap: 0.5rem;
        }

        .btn-view {
            flex: 1;
            background: #0b5e28;
            color: #fff;
            padding: 0.55rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-view:hover { background: #08431c; }

        .btn-remove {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            border: none;
            padding: 0.55rem 0.85rem;
            border-radius: 8px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-remove:hover {
            background: #ef4444;
            color: #fff;
        }

        /* Tables & Lists */
        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.95rem;
        }

        th {
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
        }

        .status-open { background: rgba(245, 158, 11, 0.12); color: #d97706; }
        .status-resolved { background: rgba(16, 185, 129, 0.12); color: #059669; }

        .stars-gold {
            color: #f59e0b;
        }

        /* Alert notifications */
        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            font-size: 0.92rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.25);
            color: #047857;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 1rem;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
            color: #cbd5e1;
        }

        .empty-state h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 0.5rem;
        }

        /* Rating Stars input */
        .star-rating-input {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 0.35rem;
        }

        .star-rating-input input {
            display: none;
        }

        .star-rating-input label {
            font-size: 1.8rem;
            color: #cbd5e1;
            cursor: pointer;
            transition: color 0.2s;
            margin-bottom: 0;
        }

        .star-rating-input input:checked ~ label,
        .star-rating-input label:hover,
        .star-rating-input label:hover ~ label {
            color: #f59e0b;
        }
    </style>
</head>
<body>

    <!-- 1. Navigation Bar -->
    <nav>
        <a href="${pageContext.request.contextPath}/home" class="logo" style="text-decoration: none;">
            <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 46px; width: 46px; border-radius: 10px; object-fit: cover; border: 2px solid #d4af37; box-shadow: 0 4px 10px rgba(0,0,0,0.35);">
            <div style="display: flex; flex-direction: column; line-height: 1.15;">
                <span style="font-family: 'Outfit', sans-serif; font-weight: 800; font-size: 1.45rem; letter-spacing: 0.5px; color: #ffffff;">Ceylon<span class="highlight" style="color: var(--secondary);">Lands</span></span>
                <span style="font-size: 0.62rem; text-transform: uppercase; letter-spacing: 1.5px; color: #94a3b8; font-weight: 600;">Prime Land Sales &amp; Development</span>
            </div>
        </a>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/properties">Lands & Projects</a></li>
            <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/how-it-works">How It Works</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            <li style="display: flex; align-items: center; margin: 0 0.5rem;">
                <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
            </li>
            <li><a href="${pageContext.request.contextPath}/customer/portal" class="btn-outline-portal active"><i class="bi bi-person-circle"></i> My Account</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-outline-portal" style="background: rgba(239, 68, 68, 0.15); border-color: rgba(239, 68, 68, 0.4); color: #fca5a5;"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
        </ul>
    </nav>

    <!-- 2. Portal Header -->
    <div class="portal-header">
        <div class="portal-title">
            <h1>Customer Portal</h1>
            <p>Manage your profile, saved lands, inquiries, support tickets, and reviews.</p>
        </div>
        <div class="customer-chip">
            <div class="customer-avatar">
                ${pageContext.request.userPrincipal.name.substring(0, 1).toUpperCase()}
            </div>
            <div>
                <div style="font-weight: 700; font-size: 1rem;">${customer.name != null ? customer.name : pageContext.request.userPrincipal.name}</div>
                <div style="font-size: 0.8rem; color: #94a3b8;">Customer Account </div>
            </div>
        </div>
    </div>

    <!-- 3. Portal Main Container -->
    <div class="portal-container">

        <!-- Sidebar Navigation -->
        <div class="portal-sidebar">
            <button class="tab-btn active" onclick="switchTab('overview')">
                <i class="bi bi-grid-fill"></i>
                <span>Overview</span>
            </button>

            <button class="tab-btn" onclick="switchTab('profile')">
                <i class="bi bi-person-vcard-fill"></i>
                <span>My Profile</span>
            </button>

            <button class="tab-btn" onclick="switchTab('wishlist')">
                <i class="bi bi-heart-fill"></i>
                <span>Wishlist</span>
                <span class="badge-pill">${wishlist.size()}</span>
            </button>

            <button class="tab-btn" onclick="switchTab('reservations')">
                <i class="bi bi-file-earmark-check-fill"></i>
                <span>My Reservations & Deeds</span>
                <span class="badge-pill" style="background: #3186FF; color: #fff;">${reservations.size()}</span>
            </button>

            <button class="tab-btn" onclick="switchTab('inquiries')">
                <i class="bi bi-envelope-paper-fill"></i>
                <span>My Inquiries</span>
                <span class="badge-pill">${inquiries.size()}</span>
            </button>

            <button class="tab-btn" onclick="switchTab('reviews')">
                <i class="bi bi-star-fill"></i>
                <span>My Reviews</span>
                <span class="badge-pill">${reviews.size()}</span>
            </button>

            <button class="tab-btn" onclick="switchTab('support')">
                <i class="bi bi-headset"></i>
                <span>Support Requests</span>
                <span class="badge-pill">${supportRequests.size()}</span>
            </button>

            <button class="tab-btn" onclick="switchTab('feedback')">
                <i class="bi bi-chat-square-quote-fill"></i>
                <span>Platform Feedback</span>
            </button>
        </div>

        <!-- Content Panels -->
        <div class="portal-content">

            <!-- Flash Alerts -->
            <c:if test="${portalSuccess != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${portalSuccess}</div>
            </c:if>
            <c:if test="${portalError != null}">
                <div class="alert alert-danger" style="background: #fef2f2; border: 1px solid #ef4444; color: #991b1b; padding: 1rem 1.25rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; font-weight: 600;"><i class="bi bi-exclamation-triangle-fill"></i> ${portalError}</div>
            </c:if>
            <c:if test="${profileSuccess != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${profileSuccess}</div>
            </c:if>
            <c:if test="${wishlistMsg != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${wishlistMsg}</div>
            </c:if>
            <c:if test="${reviewSuccess != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${reviewSuccess}</div>
            </c:if>
            <c:if test="${supportSuccess != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${supportSuccess}</div>
            </c:if>
            <c:if test="${feedbackSuccess != null}">
                <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> ${feedbackSuccess}</div>
            </c:if>

            <!-- TAB 1: OVERVIEW -->
            <div id="tab-overview" class="tab-panel">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-speedometer2" style="color: #0b5e28;"></i> Dashboard Overview</h2>
                        <p>Welcome back, ${customer.name != null ? customer.name : pageContext.request.userPrincipal.name}! Here is a quick snapshot of your account activity.</p>
                    </div>
                </div>

                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-icon icon-wishlist"><i class="bi bi-heart-fill"></i></div>
                        <div>
                            <div class="stat-value">${wishlist.size()}</div>
                            <div class="stat-label">Saved in Wishlist</div>
                        </div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-icon icon-inquiry"><i class="bi bi-envelope-check-fill"></i></div>
                        <div>
                            <div class="stat-value">${inquiries.size()}</div>
                            <div class="stat-label">Inquiries Sent</div>
                        </div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-icon icon-reviews"><i class="bi bi-star-fill"></i></div>
                        <div>
                            <div class="stat-value">${reviews.size()}</div>
                            <div class="stat-label">Ratings & Reviews</div>
                        </div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-icon icon-support"><i class="bi bi-ticket-detailed-fill"></i></div>
                        <div>
                            <div class="stat-value">${supportRequests.size()}</div>
                            <div class="stat-label">Support Tickets</div>
                        </div>
                    </div>
                </div>

                <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 16px; padding: 1.5rem; margin-top: 1.5rem;">
                    <h3 style="font-size: 1.2rem; font-weight: 700; margin-bottom: 0.75rem;">Quick Actions</h3>
                    <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                        <button onclick="switchTab('reservations')" class="btn-action" style="background: #319bff; box-shadow: 0 4px 10px rgba(11, 94, 40, 0.2);"><i class="bi bi-file-earmark-check-fill"></i> My Reservations & Deeds (${reservations.size()})</button>
                        <a href="${pageContext.request.contextPath}/properties" class="btn-action"><i class="bi bi-compass"></i> Explore Lands for Sale</a>
                        <button onclick="switchTab('profile')" class="btn-action" style="background: #475569;"><i class="bi bi-person-gear"></i> Update My Profile</button>
                        <button onclick="switchTab('support')" class="btn-action" style="background: #0284c7;"><i class="bi bi-headset"></i> Open Support Request</button>
                    </div>
                </div>
            </div>

            <!-- TAB 2: MY PROFILE -->
            <div id="tab-profile" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-person-vcard-fill" style="color: #0b5e28;"></i> Update Profile</h2>
                        <p>Keep your personal details, contact number, and security password up to date.</p>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/customer/profile/update" method="POST">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Username</label>
                            <input type="text" class="form-control" value="${pageContext.request.userPrincipal.name}" disabled style="background: #f1f5f9;">
                        </div>

                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="name" class="form-control" value="${customer.name}" required placeholder="Enter your full name">
                        </div>

                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" class="form-control" value="${customer.email}" required placeholder="e.g. name@example.com">
                        </div>

                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" value="${customer.phone}" required placeholder="e.g. +94771234567">
                        </div>

                        <div class="form-group full-width">
                            <label>Home / Postal Address</label>
                            <input type="text" name="address" class="form-control" value="${customer.address}" placeholder="Enter your residential address">
                        </div>

                        <div class="form-group full-width">
                            <label>Change Password (Leave blank to keep current password)</label>
                            <input type="password" name="newPassword" class="form-control" placeholder="••••••••">
                        </div>
                    </div>

                    <button type="submit" class="btn-action" style="margin-top: 1rem;"><i class="bi bi-save"></i> Save Profile Changes</button>
                </form>
            </div>

            <!-- TAB 3: WISHLIST -->
            <div id="tab-wishlist" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-heart-fill" style="color: #ef4444;"></i> Saved Wishlist Lands</h2>
                        <p>Properties you have bookmarked for quick comparison and tracking.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/properties" class="btn-action" style="font-size: 0.85rem; padding: 0.5rem 1rem;"><i class="bi bi-plus-circle"></i> Browse More Lands</a>
                </div>

                <c:choose>
                    <c:when test="${empty wishlist}">
                        <div class="empty-state">
                            <i class="bi bi-heartbreak"></i>
                            <h3>Your Wishlist is Empty</h3>
                            <p>You haven't saved any properties yet. Browse our land catalog and click the bookmark button!</p>
                            <a href="${pageContext.request.contextPath}/properties" class="btn-action" style="margin-top: 1rem;">Browse Properties</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="wishlist-grid">
                            <c:forEach var="item" items="${wishlist}">
                                <div class="wishlist-card">
                                    <div class="wishlist-img-wrap">
                                        <img src="${item.property.imageUrl != null ? item.property.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600'}" alt="${item.property.title}">
                                        <span class="wishlist-badge">${item.property.type}</span>
                                    </div>
                                    <div class="wishlist-body">
                                        <div class="wishlist-title">${item.property.title}</div>
                                        <div class="wishlist-location"><i class="bi bi-geo-alt-fill" style="color: #ef4444;"></i> ${item.property.location}</div>
                                        <div class="wishlist-price">
                                            <fmt:formatNumber value="${item.property.price}" type="currency" currencySymbol="Rs. " maxFractionDigits="0" />
                                            <span style="font-size: 0.8rem; font-weight: 500; color: var(--text-muted);">/ Perch</span>
                                        </div>
                                        <div class="wishlist-actions">
                                            <a href="${pageContext.request.contextPath}/properties/${item.property.id}" class="btn-view">View Details</a>
                                            <a href="${pageContext.request.contextPath}/customer/wishlist/remove/${item.property.id}" class="btn-remove" title="Remove from Wishlist" onclick="return confirm('Remove this land from your wishlist?');"><i class="bi bi-trash-fill"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- TAB 4: MY INQUIRIES -->
            <div id="tab-inquiries" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-envelope-paper-fill" style="color: #0b5e28;"></i> My Property Inquiries & Reservations</h2>
                        <p>Track all property inquiries and appointment requests you submitted.</p>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty inquiries}">
                        <div class="empty-state">
                            <i class="bi bi-chat-left-dots"></i>
                            <h3>No Inquiries Yet</h3>
                            <p>You haven't made any property inquiries. Browse properties and send inquiries to connect with our agents!</p>
                            <a href="${pageContext.request.contextPath}/properties" class="btn-action" style="margin-top: 1rem;">Browse Properties</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-card">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Property</th>
                                        <th>Your Message</th>
                                        <th>Status / State</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="inq" items="${inquiries}">
                                        <tr>
                                            <td><strong>${inq.inquiryDate}</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inq.property != null}">
                                                        <a href="${pageContext.request.contextPath}/properties/${inq.property.id}" style="color: #0b5e28; font-weight: 700; text-decoration: none;">
                                                            ${inq.property.title}
                                                        </a>
                                                        <div style="font-size: 0.8rem; color: var(--text-muted);"><i class="bi bi-geo-alt-fill"></i> ${inq.property.location}</div>
                                                    </c:when>
                                                    <c:otherwise>General Land Inquiry</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-size: 0.85rem; color: #475569; max-width: 250px;">"${inq.message}"</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inq.status == 'COMPLETED'}">
                                                        <span class="badge-status" style="background: #ecfdf5; color: #047857; border: 1px solid #6ee7b7; font-weight: 700;"><i class="bi bi-award-fill"></i> Sale Completed</span>
                                                        <div style="font-size: 0.75rem; color: #065f46; margin-top: 0.2rem; font-weight: 700;">Deed Transferred & Registered</div>
                                                    </c:when>
                                                    <c:when test="${inq.status == 'FULL_APPROVED' || inq.status == 'PAYMENT_VERIFIED'}">
                                                        <span class="badge-status" style="background: #dcfce7; color: #15803d; border: 1px solid #86efac; font-weight: 700;"><i class="bi bi-patch-check-fill"></i> Payment Verified</span>
                                                        <div style="font-size: 0.75rem; color: #166534; margin-top: 0.2rem; font-weight: 600;">Legal conveyancing unlocked</div>
                                                    </c:when>
                                                    <c:when test="${inq.status == 'PAYMENT_SUBMITTED'}">
                                                        <span class="badge-status" style="background: #dbeafe; color: #1e40af; border: 1px solid #93c5fd; font-weight: 700;"><i class="bi bi-clock-history"></i> Slip Submitted</span>
                                                        <div style="font-size: 0.75rem; color: #2563eb; margin-top: 0.2rem; font-weight: 600;">Waiting for Sales Approval</div>
                                                    </c:when>
                                                    <c:when test="${inq.status == 'PENDING_PAYMENT'}">
                                                        <span class="badge-status" style="background: #e0f2fe; color: #0369a1; border: 1px solid #7dd3fc; font-weight: 700;"><i class="bi bi-bank"></i> Reservation Confirmed</span>
                                                        <div style="font-size: 0.75rem; color: #0284c7; margin-top: 0.2rem; font-weight: 700;">Bank Details Dispatched!</div>
                                                    </c:when>
                                                    <c:when test="${inq.status == 'CANCELLED'}">
                                                        <span class="badge-status" style="background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5;"><i class="bi bi-x-circle-fill"></i> Cancelled</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status" style="background: #fef3c7; color: #b45309; border: 1px solid #fcd34d;"><i class="bi bi-hourglass-split"></i> Under Sales Review</span>
                                                        <div style="font-size: 0.75rem; color: #d97706; margin-top: 0.2rem;">Awaiting Sales Manager Approval</div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${inq.status == 'COMPLETED'}">
                                                        <button type="button" onclick="switchTab('legal-deeds')" class="btn-action" style="padding: 0.45rem 0.9rem; font-size: 0.82rem; background: #ecfdf5; color: #047857; border: 1px solid #6ee7b7; border-radius: 8px; font-weight: 700; display: inline-flex; align-items: center; gap: 0.35rem; cursor: pointer;">
                                                            <i class="bi bi-award"></i> View Deed Transfer
                                                        </button>
                                                    </c:when>
                                                    <c:when test="${inq.status == 'PENDING_PAYMENT' or inq.status == 'PAYMENT_SUBMITTED' or inq.status == 'FULL_APPROVED' or inq.status == 'PAYMENT_VERIFIED'}">
                                                        <button type="button" onclick="switchTab('reservations')" class="btn-action" style="padding: 0.45rem 0.9rem; font-size: 0.82rem; background: linear-gradient(135deg, #0b5e28 0%, #07401b 100%); color: #fff; display: inline-flex; align-items: center; gap: 0.35rem; box-shadow: 0 4px 8px rgba(11, 94, 40, 0.2); border-radius: 8px; border: none; cursor: pointer;">
                                                            <i class="bi bi-file-earmark-check-fill"></i> View My Reservation & Pay
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #94a3b8; font-size: 0.82rem;"><i class="bi bi-clock"></i> In review</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- TAB 5: MY RATINGS & REVIEWS -->
            <div id="tab-reviews" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-star-fill" style="color: #f59e0b;"></i> My Property Reviews & Ratings</h2>
                        <p>All reviews and star ratings you have published on properties.</p>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="empty-state">
                            <i class="bi bi-stars"></i>
                            <h3>No Reviews Submitted Yet</h3>
                            <p>Visit any property in our catalog to share your rating and review feedback.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Property</th>
                                        <th>Rating</th>
                                        <th>Review Comment</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="rev" items="${reviews}">
                                        <tr>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/properties/${rev.property.id}" style="color: #0b5e28; font-weight: 700; text-decoration: none;">
                                                    ${rev.property.title}
                                                </a>
                                            </td>
                                            <td>
                                                <span class="stars-gold">
                                                    <c:forEach begin="1" end="${rev.rating}">★</c:forEach>
                                                    <c:forEach begin="${rev.rating + 1}" end="5">☆</c:forEach>
                                                </span>
                                                (${rev.rating}/5)
                                            </td>
                                            <td>"${rev.comment}"</td>
                                            <td><small style="color: var(--text-muted);">${rev.createdAt}</small></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- TAB 6: SUPPORT REQUESTS -->
            <div id="tab-support" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-headset" style="color: #059669;"></i> Customer Support Helpdesk</h2>
                        <p>Submit legal, payment, or survey assistance requests to our customer support team.</p>
                    </div>
                </div>

                <!-- Create Support Request Form -->
                <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 16px; padding: 1.5rem; margin-bottom: 2rem;">
                    <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 1rem;">Open a New Support Ticket</h3>
                    <form action="${pageContext.request.contextPath}/customer/support/create" method="POST">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Subject</label>
                                <input type="text" name="subject" class="form-control" required placeholder="e.g. Deed Verification Question">
                            </div>

                            <div class="form-group">
                                <label>Department / Category</label>
                                <select name="category" class="form-control" required>
                                    <option value="Legal & Deeds">Legal & Deed Verification</option>
                                    <option value="Payment & Installments">Payment & Installment Plans</option>
                                    <option value="Land Survey & Boundaries">Land Survey & Plot Demarcation</option>
                                    <option value="Site Visit Booking">Site Visit & Consultation</option>
                                    <option value="General Support">General Support</option>
                                </select>
                            </div>

                            <div class="form-group full-width">
                                <label>Message / Description</label>
                                <textarea name="message" class="form-control" required placeholder="Explain your inquiry in detail..."></textarea>
                            </div>
                        </div>

                        <button type="submit" class="btn-action"><i class="bi bi-send-fill"></i> Submit Support Ticket</button>
                    </form>
                </div>

                <!-- Tickets List -->
                <h3 style="font-size: 1.15rem; font-weight: 700; margin-bottom: 1rem;">My Previous Support Tickets</h3>
                <c:choose>
                    <c:when test="${empty supportRequests}">
                        <p style="color: var(--text-muted); font-size: 0.9rem;">No support requests submitted yet.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Ticket #</th>
                                        <th>Category</th>
                                        <th>Subject</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="ticket" items="${supportRequests}">
                                        <tr>
                                            <td><strong>#${ticket.id}</strong></td>
                                            <td><span style="font-weight: 600; color: #0284c7;">${ticket.category}</span></td>
                                            <td>${ticket.subject}</td>
                                            <td><small>${ticket.createdAt}</small></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${ticket.status == 'OPEN'}">
                                                        <span class="badge-status status-open"><i class="bi bi-hourglass-split"></i> Open</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-status status-resolved"><i class="bi bi-check-circle"></i> Resolved</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- TAB: MY LAND RESERVATIONS & DEEDS -->
            <div id="tab-reservations" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-file-earmark-check-fill" style="color: #0b5e28;"></i> My Land Reservations & Title Deeds</h2>
                        <p>Track your active land plot bookings, deed drafting milestones, advance payments, and upload your ownership registration documents.</p>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty reservations}">
                        <div class="empty-state">
                            <i class="bi bi-tree"></i>
                            <h3>No Active Land Reservations</h3>
                            <p>You haven't reserved any land plots yet. Explore our verified listings and reserve your ideal piece of land today!</p>
                            <a href="${pageContext.request.contextPath}/properties" class="btn-action" style="margin-top: 1rem; display: inline-flex;"><i class="bi bi-compass"></i> Explore Land Listings</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="display: flex; flex-direction: column; gap: 1.75rem;">
                            <c:forEach var="res" items="${reservations}">
                                <div style="background: #ffffff; border: 1px solid var(--border); border-radius: 18px; padding: 1.75rem; box-shadow: 0 4px 15px rgba(0,0,0,0.03);">
                                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem; margin-bottom: 1.25rem;">
                                        <div style="display: flex; gap: 1.25rem; align-items: center;">
                                            <img src="${res.property.imageUrl != null && !res.property.imageUrl.isEmpty() ? res.property.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="${res.property.title}" style="width: 100px; height: 80px; object-fit: cover; border-radius: 12px; border: 1px solid var(--border);">
                                            <div>
                                                <span style="font-size: 0.8rem; font-weight: 700; color: #0b5e28; text-transform: uppercase; letter-spacing: 0.5px;">Reservation #${res.id}</span>
                                                <h3 style="font-size: 1.25rem; font-weight: 800; color: var(--text-dark); margin: 0.15rem 0;">${res.property.title}</h3>
                                                <p style="color: var(--text-muted); font-size: 0.88rem; margin: 0;"><i class="bi bi-geo-alt-fill"></i> ${res.property.location} &bull; ${res.property.size} Perches</p>
                                            </div>
                                        </div>
                                        <div style="text-align: right;">
                                            <div style="font-size: 1.25rem; font-weight: 800; color: var(--text-dark);">
                                                Rs. <fmt:formatNumber value="${res.salePrice}" type="number" maxFractionDigits="2"/>
                                            </div>
                                            <div style="font-size: 0.85rem; color: #059669; font-weight: 700;">
                                                Advance: Rs. <fmt:formatNumber value="${res.advancePaid != null ? res.advancePaid : 0}" type="number" maxFractionDigits="2"/>
                                            </div>
                                            <div style="font-size: 0.8rem; color: #b45309;">
                                                Balance Due: Rs. <fmt:formatNumber value="${res.balanceAmount != null ? res.balanceAmount : res.salePrice}" type="number" maxFractionDigits="2"/>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Bank Transfer Notification (If Payment Pending) -->
                                    <c:if test="${res.paymentStatus == 'PENDING_PAYMENT' || empty res.paymentStatus}">
                                        <div style="background: #fffbeb; border: 1px solid #fde68a; border-radius: 12px; padding: 1rem 1.25rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 0.85rem;">
                                            <i class="bi bi-bank" style="font-size: 1.3rem; color: #d97706; margin-top: 0.1rem;"></i>
                                            <div style="flex: 1;">
                                                <div style="font-weight: 800; font-size: 0.92rem; color: #92400e; margin-bottom: 0.25rem;">
                                                    Bank Payment Required (Rs. <fmt:formatNumber value="${res.advancePaid != null && res.advancePaid > 0 ? res.advancePaid : res.salePrice}" type="number" maxFractionDigits="2"/>)
                                                </div>
                                                <div style="font-size: 0.85rem; color: #78350f; line-height: 1.4; white-space: pre-line; background: #fff; padding: 0.6rem 0.8rem; border-radius: 8px; border: 1px solid #fef3c7; margin: 0.35rem 0;">${not empty res.bankDetails ? res.bankDetails : 'Commercial Bank - Ceylon Lands (Pvt) Ltd - A/C 1000849201 - Colombo 03'}</div>
                                                <div style="font-size: 0.8rem; color: #b45309; font-weight: 600;">
                                                    <i class="bi bi-info-circle-fill"></i> Please transfer the payment and submit your bank slip reference below. Document submission will unlock once payment is approved.
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Payment Slip Submitted - Awaiting Sales Manager Approval -->
                                    <c:if test="${res.paymentStatus == 'PAYMENT_SUBMITTED'}">
                                        <div style="background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%); border: 1.5px solid #60a5fa; border-radius: 14px; padding: 1.15rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(37, 99, 235, 0.08);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #2563eb; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(37, 99, 235, 0.25);">
                                                <i class="bi bi-clock-history"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 0.98rem; color: #1e40af; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-check2-circle" style="color: #2563eb;"></i> Payment Slip Submitted — Awaiting Sales Approval
                                                    </span>
                                                    <span style="background: #1e40af; color: #ffffff; font-size: 0.78rem; font-weight: 700; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        Ref: ${not empty res.paymentReference ? res.paymentReference : 'Submitted'}
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.85rem; color: #1e3a8a; margin: 0; line-height: 1.5;">
                                                    We have received your payment reference. The Sales Manager is currently verifying your bank transfer with our accounts team. Once approved, <strong>Step 2 (Buyer Identity & Deed Registration)</strong> will unlock automatically.
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Payment Approved -->
                                    <c:if test="${res.paymentStatus == 'PAYMENT_VERIFIED' || res.paymentStatus == 'FULLY_PAID' || res.paymentStatus == 'PAID'}">
                                        <div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 12px; padding: 0.85rem 1.25rem; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.75rem;">
                                            <i class="bi bi-patch-check-fill" style="font-size: 1.3rem; color: #16a34a;"></i>
                                            <div>
                                                <div style="font-weight: 800; font-size: 0.92rem; color: #166534;">Payment Approved & Verified by Sales Manager!</div>
                                                <div style="font-size: 0.82rem; color: #15803d;">Ownership document submission is now <strong>UNLOCKED</strong>. Please submit your NIC and Deed info to start Title Conveyancing.</div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Documents Rejected / Correction Requested by Legal Officer -->
                                    <c:if test="${res.legalStatus == 'DOCS_REJECTED'}">
                                        <div style="background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%); border: 1.5px solid #ef4444; border-radius: 14px; padding: 1.25rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(239, 68, 68, 0.15);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #dc2626; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(220, 38, 38, 0.25);">
                                                <i class="bi bi-exclamation-octagon-fill"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: gap; 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 1rem; color: #991b1b; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-shield-x"></i> Document Issue Detected — Action Required
                                                    </span>
                                                    <span style="background: #dc2626; color: #ffffff; font-size: 0.78rem; font-weight: 800; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        <i class="bi bi-exclamation-triangle"></i> Correction Required
                                                    </span>
                                                </div>
                                                <div style="background: #ffffff; border: 1px solid #fca5a5; border-radius: 8px; padding: 0.75rem 1rem; margin: 0.5rem 0; font-size: 0.88rem; color: #7f1d1d;">
                                                    <strong>Legal Officer Notice:</strong> "${not empty res.legalNotes ? res.legalNotes : 'Please re-submit clear NIC and address proof documents for deed registration.'}"
                                                </div>
                                                <p style="font-size: 0.85rem; color: #991b1b; margin: 0; line-height: 1.5;">
                                                    Please click <strong>[View Payment & Deed Dossier]</strong> below to fix your details and re-submit your documents.
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Documents Submitted - Awaiting Legal Officer Approval -->
                                    <c:if test="${res.legalStatus == 'DOCS_SUBMITTED'}">
                                        <div style="background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%); border: 1.5px solid #f59e0b; border-radius: 14px; padding: 1.15rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(245, 158, 11, 0.1);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #f59e0b; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(245, 158, 11, 0.25);">
                                                <i class="bi bi-file-earmark-check-fill"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 0.98rem; color: #92400e; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-check2-circle" style="color: #059669;"></i> Documents Submitted Successfully — Waiting for Legal Approval
                                                    </span>
                                                    <span style="background: #d97706; color: #ffffff; font-size: 0.78rem; font-weight: 800; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        <i class="bi bi-arrow-repeat"></i> In Processing
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.85rem; color: #78350f; margin: 0; line-height: 1.5;">
                                                    Your Buyer NIC and Ownership Registration details have been received and transferred to our Legal Department. The Legal Officer is currently performing title clearance and drafting your <strong>Deed of Transfer</strong>.
                                                </p>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Milestone 3: Title Cleared Notification -->
                                    <c:if test="${res.legalStatus == 'TITLE_CLEARED'}">
                                        <div style="background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); border: 1.5px solid #22c55e; border-radius: 14px; padding: 1.15rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(34, 197, 94, 0.12);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #16a34a; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(22, 163, 74, 0.25);">
                                                <i class="bi bi-shield-check"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 0.98rem; color: #166534; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-patch-check-fill" style="color: #15803d;"></i> Title Search 100% Cleared & Verified
                                                    </span>
                                                    <span style="background: #16a34a; color: #ffffff; font-size: 0.78rem; font-weight: 800; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        <i class="bi bi-check-lg"></i> Title OK
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.85rem; color: #14532d; margin: 0; line-height: 1.5;">
                                                    The Land Registry title search for this plot is fully cleared with unencumbered freehold title. Our Legal Department is now preparing your <strong>Deed of Transfer</strong>.
                                                </p>
                                                <c:if test="${not empty res.legalNotes}">
                                                    <div style="background: #ffffff; border: 1px solid #bbf7d0; border-radius: 8px; padding: 0.5rem 0.75rem; margin-top: 0.5rem; font-size: 0.82rem; color: #166534;">
                                                        <strong>Legal Note:</strong> ${res.legalNotes}
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Milestone 4: Deed Drafted Notification -->
                                    <c:if test="${res.legalStatus == 'DEED_DRAFTED'}">
                                        <div style="background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%); border: 1.5px solid #0284c7; border-radius: 14px; padding: 1.15rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(2, 132, 199, 0.12);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #0284c7; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(2, 132, 199, 0.25);">
                                                <i class="bi bi-file-earmark-text-fill"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 0.98rem; color: #075985; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-journal-check" style="color: #0284c7;"></i> Deed of Transfer Drafted
                                                    </span>
                                                    <span style="background: #0284c7; color: #ffffff; font-size: 0.78rem; font-weight: 800; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        <i class="bi bi-file-earmark-check"></i> Deed Drafted
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.85rem; color: #0c4a6e; margin: 0; line-height: 1.5;">
                                                    Your official <strong>Deed of Transfer ${not empty res.deedNumber ? '('.concat(res.deedNumber).concat(')') : ''}</strong> has been drafted by <strong>${not empty res.notaryName ? res.notaryName : 'Attesting Notary Public'}</strong>. Stamp duty and notary execution preparation are underway.
                                                </p>
                                                <c:if test="${not empty res.legalNotes}">
                                                    <div style="background: #ffffff; border: 1px solid #bae6fd; border-radius: 8px; padding: 0.5rem 0.75rem; margin-top: 0.5rem; font-size: 0.82rem; color: #0369a1;">
                                                        <strong>Conveyancing Details:</strong> ${res.legalNotes}
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Milestone 5: Ready for Signing Notification -->
                                    <c:if test="${res.legalStatus == 'READY_TO_SIGN'}">
                                        <div style="background: linear-gradient(135deg, #faf5ff 0%, #f3e8ff 100%); border: 1.5px solid #9333ea; border-radius: 14px; padding: 1.15rem 1.4rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1rem; box-shadow: 0 4px 14px rgba(147, 51, 234, 0.15);">
                                            <div style="width: 44px; height: 44px; border-radius: 50%; background: #9333ea; color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; flex-shrink: 0; box-shadow: 0 4px 10px rgba(147, 51, 234, 0.25);">
                                                <i class="bi bi-pen-fill"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.35rem;">
                                                    <span style="font-weight: 800; font-size: 0.98rem; color: #6b21a8; display: flex; align-items: center; gap: 0.4rem;">
                                                        <i class="bi bi-pen" style="color: #9333ea;"></i> Deed Ready for Notary Signing & Execution
                                                    </span>
                                                    <span style="background: #9333ea; color: #ffffff; font-size: 0.78rem; font-weight: 800; padding: 0.25rem 0.65rem; border-radius: 20px;">
                                                        <i class="bi bi-calendar-check"></i> Ready to Sign
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.85rem; color: #581c87; margin: 0; line-height: 1.5;">
                                                    Please contact our Legal Department or visit our Colombo Office for Deed execution before Notary Public <strong>${not empty res.notaryName ? res.notaryName : 'Attorney-at-Law'}</strong>. Deed Reference: <strong>${not empty res.deedNumber ? res.deedNumber : 'Pending'}</strong>.
                                                </p>
                                                <c:if test="${not empty res.legalNotes}">
                                                    <div style="background: #ffffff; border: 1px solid #e9d5ff; border-radius: 8px; padding: 0.5rem 0.75rem; margin-top: 0.5rem; font-size: 0.82rem; color: #7e22ce;">
                                                        <strong>Signing Instructions:</strong> ${res.legalNotes}
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Milestone 6: Ownership Transferred Notification -->
                                    <c:if test="${res.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                        <div style="background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); border: 2px solid #16a34a; border-radius: 16px; padding: 1.35rem 1.5rem; margin-bottom: 1.25rem; display: flex; align-items: flex-start; gap: 1.15rem; box-shadow: 0 6px 20px rgba(22, 163, 74, 0.18);">
                                            <div style="width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, #15803d 0%, #166534 100%); color: #ffffff; display: flex; align-items: center; justify-content: center; font-size: 1.6rem; flex-shrink: 0; box-shadow: 0 4px 12px rgba(21, 128, 61, 0.35);">
                                                <i class="bi bi-award-fill"></i>
                                            </div>
                                            <div style="flex: 1;">
                                                <div style="display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 0.4rem;">
                                                    <span style="font-weight: 800; font-size: 1.08rem; color: #14532d; display: flex; align-items: center; gap: 0.45rem;">
                                                        <i class="bi bi-check-circle-fill" style="color: #16a34a;"></i> Congratulations! Official Ownership Transferred & Deed Registered
                                                    </span>
                                                    <span style="background: #15803d; color: #ffffff; font-size: 0.82rem; font-weight: 800; padding: 0.3rem 0.85rem; border-radius: 20px; box-shadow: 0 2px 6px rgba(21, 128, 61, 0.3);">
                                                        <i class="bi bi-patch-check-fill"></i> Ownership Granted
                                                    </span>
                                                </div>
                                                <p style="font-size: 0.88rem; color: #166534; margin: 0; line-height: 1.5;">
                                                    The Deed of Transfer has been registered at the Land Registry under Deed Number <strong>${res.deedNumber}</strong> by <strong>${not empty res.notaryName ? res.notaryName : 'Notary Public'}</strong>. You are now the lawful registered owner of this property.
                                                </p>
                                                <c:if test="${not empty res.legalNotes}">
                                                    <div style="background: #ffffff; border: 1px solid #bbf7d0; border-radius: 8px; padding: 0.6rem 0.85rem; margin-top: 0.5rem; font-size: 0.85rem; color: #14532d;">
                                                        <strong>Registration & Day Book Notes:</strong> ${res.legalNotes}
                                                    </div>
                                                </c:if>
                                                <div style="display: flex; gap: 0.75rem; margin-top: 0.85rem; flex-wrap: wrap;">
                                                    <button type="button" onclick="showOfficialCertificateModal('${res.id}')" style="background: linear-gradient(135deg, #0b5e28 0%, #07401b 100%); color: #ffffff; padding: 0.5rem 1.15rem; border-radius: 8px; font-weight: 700; font-size: 0.85rem; border: none; cursor: pointer; display: inline-flex; align-items: center; gap: 0.4rem; box-shadow: 0 3px 8px rgba(11, 94, 40, 0.25);">
                                                        <i class="bi bi-patch-check-fill" style="color: #d4af37;"></i> View & Print Official Ownership Certificate
                                                    </button>
                                                    <c:if test="${not empty res.transferCertificateUrl}">
                                                        <a href="${res.transferCertificateUrl}" target="_blank" style="background: #ffffff; border: 1.5px solid #15803d; color: #15803d; padding: 0.5rem 1.15rem; border-radius: 8px; font-weight: 700; font-size: 0.85rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.4rem;">
                                                            <i class="bi bi-file-earmark-pdf-fill"></i> Download Attached Deed Document
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- 4-Step Conveyancing Stepper -->
                                    <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 14px; padding: 1.25rem; margin-bottom: 1.25rem;">
                                        <div style="font-size: 0.85rem; font-weight: 700; color: #334155; margin-bottom: 0.75rem; display: flex; align-items: center; justify-content: space-between;">
                                            <span><i class="bi bi-signpost-split"></i> Legal & Ownership Transfer Progress</span>
                                            <c:choose>
                                                <c:when test="${res.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                                    <span style="color: #15803d; font-weight: 800;"><i class="bi bi-award-fill"></i> Deed Registered & Ownership Granted</span>
                                                </c:when>
                                                <c:when test="${res.legalStatus == 'READY_TO_SIGN'}">
                                                    <span style="color: #6d28d9; font-weight: 800;"><i class="bi bi-pen-fill"></i> Ready for Notary Signing</span>
                                                </c:when>
                                                <c:when test="${res.legalStatus == 'DEED_DRAFTED'}">
                                                    <span style="color: #0369a1; font-weight: 800;"><i class="bi bi-file-earmark-text"></i> Deed of Transfer Drafted</span>
                                                </c:when>
                                                <c:when test="${res.legalStatus == 'TITLE_CLEARED'}">
                                                    <span style="color: #15803d; font-weight: 800;"><i class="bi bi-shield-check"></i> Title Search 100% Cleared</span>
                                                </c:when>
                                                <c:when test="${res.legalStatus == 'DOCS_REJECTED'}">
                                                    <span style="color: #991b1b; font-weight: 800; background: #fee2e2; border: 1px solid #fca5a5; padding: 0.25rem 0.65rem; border-radius: 20px; display: inline-flex; align-items: center; gap: 0.35rem;">
                                                        <i class="bi bi-exclamation-circle-fill"></i> Document Correction Required
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.legalStatus == 'DOCS_SUBMITTED'}">
                                                    <span style="color: #92400e; font-weight: 800; background: #fef3c7; border: 1px solid #fde68a; padding: 0.25rem 0.65rem; border-radius: 20px; display: inline-flex; align-items: center; gap: 0.35rem;">
                                                        <i class="bi bi-hourglass-split"></i> In Processing — Waiting for Legal Approval
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.paymentStatus == 'PAYMENT_VERIFIED' || res.paymentStatus == 'FULLY_PAID' || res.paymentStatus == 'PAID'}">
                                                    <span style="color: #0b5e28; font-weight: 800;"><i class="bi bi-upload"></i> Action Required: Submit NIC & Deed Info</span>
                                                </c:when>
                                                <c:when test="${res.paymentStatus == 'PAYMENT_SUBMITTED'}">
                                                    <span style="color: #1e40af; font-weight: 800;"><i class="bi bi-clock-history"></i> Step 1: Payment Slip Submitted (Awaiting Sales Approval)</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #d97706; font-weight: 800;"><i class="bi bi-lock-fill"></i> Step 1: Complete Bank Payment</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 0.5rem; text-align: center;">
                                            <c:choose>
                                                <c:when test="${res.paymentStatus == 'PAYMENT_VERIFIED' or res.paymentStatus == 'FULLY_PAID' or res.paymentStatus == 'PAID'}">
                                                    <div style="background: #dcfce7; border: 1px solid #86efac; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: #166534;">
                                                        <i class="bi bi-check-circle-fill"></i> 1. Payment Verified
                                                    </div>
                                                </c:when>
                                                <c:when test="${res.paymentStatus == 'PAYMENT_SUBMITTED'}">
                                                    <div style="background: #dbeafe; border: 1px solid #93c5fd; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: #1d4ed8;">
                                                        <i class="bi bi-clock-history"></i> 1. Slip Submitted
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="background: #fef3c7; border: 1px solid #fde68a; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: #92400e;">
                                                        <i class="bi bi-credit-card-2-front-fill"></i> 1. Pay Advance
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <div style="background: ${not empty res.buyerNic ? '#dcfce7' : (res.paymentStatus == 'PAYMENT_VERIFIED' ? '#fef3c7' : '#f1f5f9')}; border: 1px solid ${not empty res.buyerNic ? '#86efac' : (res.paymentStatus == 'PAYMENT_VERIFIED' ? '#fde68a' : '#e2e8f0')}; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: ${not empty res.buyerNic ? '#166534' : (res.paymentStatus == 'PAYMENT_VERIFIED' ? '#92400e' : '#94a3b8')};">
                                                <i class="bi ${not empty res.buyerNic ? 'bi-check-circle-fill' : (res.paymentStatus == 'PAYMENT_VERIFIED' ? 'bi-arrow-up-circle-fill' : 'bi-lock-fill')}"></i> 2. Buyer NIC/KYC
                                            </div>
                                            <div style="background: ${res.legalStatus == 'TITLE_CLEARED' or res.legalStatus == 'DEED_DRAFTED' or res.legalStatus == 'READY_TO_SIGN' or res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#dcfce7' : (res.legalStatus == 'DOCS_SUBMITTED' ? '#fef3c7' : '#f1f5f9')}; border: 1px solid ${res.legalStatus == 'TITLE_CLEARED' or res.legalStatus == 'DEED_DRAFTED' or res.legalStatus == 'READY_TO_SIGN' or res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#86efac' : (res.legalStatus == 'DOCS_SUBMITTED' ? '#fde68a' : '#e2e8f0')}; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: ${res.legalStatus == 'TITLE_CLEARED' or res.legalStatus == 'DEED_DRAFTED' or res.legalStatus == 'READY_TO_SIGN' or res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#166534' : (res.legalStatus == 'DOCS_SUBMITTED' ? '#92400e' : '#64748b')};">
                                                <i class="bi ${res.legalStatus == 'TITLE_CLEARED' or res.legalStatus == 'DEED_DRAFTED' or res.legalStatus == 'READY_TO_SIGN' or res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? 'bi-check-circle-fill' : (res.legalStatus == 'DOCS_SUBMITTED' ? 'bi-arrow-repeat' : 'bi-hourglass')}"></i> 3. Title & Deed
                                            </div>
                                            <div style="background: ${res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#dcfce7' : (res.legalStatus == 'READY_TO_SIGN' ? '#fef3c7' : '#f1f5f9')}; border: 1px solid ${res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#86efac' : (res.legalStatus == 'READY_TO_SIGN' ? '#fde68a' : '#e2e8f0')}; padding: 0.5rem; border-radius: 8px; font-size: 0.75rem; font-weight: 700; color: ${res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? '#166534' : (res.legalStatus == 'READY_TO_SIGN' ? '#92400e' : '#64748b')};">
                                                <i class="bi ${res.legalStatus == 'OWNERSHIP_TRANSFERRED' ? 'bi-award-fill' : (res.legalStatus == 'READY_TO_SIGN' ? 'bi-pen-fill' : 'bi-file-earmark-lock')}"></i> 4. Deed Transferred
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Bottom Action Bar -->
                                    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.75rem;">
                                        <div style="font-size: 0.85rem; color: var(--text-muted);">
                                            Registered Buyer: <strong style="color: var(--text-dark);">${not empty res.buyerFullName ? res.buyerFullName : customer.name}</strong>
                                            <c:if test="${not empty res.buyerNic}">
                                                &bull; NIC: <strong style="color: #059669;">${res.buyerNic}</strong>
                                            </c:if>
                                            <c:if test="${not empty res.deedNumber}">
                                                &bull; Deed: <strong style="color: #0369a1;">${res.deedNumber}</strong>
                                            </c:if>
                                        </div>

                                        <!-- Hidden container for safe multiline data transfer without JS syntax errors -->
                                        <div id="res-data-${res.id}" style="display: none;">
                                            <span class="res-title"><c:out value="${res.property.title}"/></span>
                                            <span class="res-location"><c:out value="${res.property.location}"/></span>
                                            <span class="res-size"><c:out value="${res.property.size}"/></span>
                                            <span class="res-price"><c:out value="${res.salePrice}"/></span>
                                            <span class="res-advance"><c:out value="${res.advancePaid != null ? res.advancePaid : 0}"/></span>
                                            <span class="res-balance"><c:out value="${res.balanceAmount != null ? res.balanceAmount : res.salePrice}"/></span>
                                            <span class="res-payment-status"><c:out value="${res.paymentStatus}"/></span>
                                            <div class="res-bank-details"><c:out value="${res.bankDetails}"/></div>
                                            <span class="res-pay-ref"><c:out value="${res.paymentReference}"/></span>
                                            <span class="res-pay-slip"><c:out value="${res.paymentSlipUrl}"/></span>
                                            <span class="res-legal-status"><c:out value="${res.legalStatus}"/></span>
                                            <span class="res-legal-notes"><c:out value="${res.legalNotes}"/></span>
                                            <span class="res-deed-no"><c:out value="${res.deedNumber}"/></span>
                                            <span class="res-notary"><c:out value="${res.notaryName}"/></span>
                                            <span class="res-transfer-cert"><c:out value="${res.transferCertificateUrl}"/></span>
                                            <span class="res-buyer-name"><c:out value="${not empty res.buyerFullName ? res.buyerFullName : customer.name}"/></span>
                                            <span class="res-buyer-nic"><c:out value="${res.buyerNic}"/></span>
                                            <span class="res-nic-img"><c:out value="${res.nicImageUrl}"/></span>
                                            <span class="res-addr-proof"><c:out value="${res.addressProofUrl}"/></span>
                                        </div>

                                        <div style="display: flex; gap: 0.5rem; align-items: center; flex-wrap: wrap;">
                                            <c:if test="${res.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                                <button type="button" onclick="showOfficialCertificateModal('${res.id}')" style="padding: 0.55rem 1rem; font-size: 0.82rem; background: #ecfdf5; border: 1.5px solid #10b981; color: #065f46; border-radius: 8px; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.35rem;">
                                                    <i class="bi bi-patch-check-fill" style="color: #059669;"></i> View Transfer Certificate
                                                </button>
                                            </c:if>
                                            <button type="button" class="btn-action" style="padding: 0.6rem 1.25rem; font-size: 0.9rem;"
                                                    onclick="openReservationById('${res.id}')">
                                                <i class="bi bi-file-earmark-person-fill"></i> View Payment & Deed Dossier
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- TAB 7: PLATFORM FEEDBACK -->
            <div id="tab-feedback" class="tab-panel" style="display: none;">
                <div class="content-header">
                    <div>
                        <h2><i class="bi bi-chat-square-quote-fill" style="color: #d4af37;"></i> Platform Feedback & Suggestions</h2>
                        <p>We value your experience. Help us improve Ceylon Lands services with your feedback.</p>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/customer/feedback/submit" method="POST" style="background: #f8fafc; border: 1px solid var(--border); border-radius: 16px; padding: 1.5rem;">
                    <div class="form-group">
                        <label>How would you rate your overall experience with Ceylon Lands?</label>
                        <div class="star-rating-input">
                            <input type="radio" id="star5" name="rating" value="5" checked><label for="star5">★</label>
                            <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                            <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                            <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                            <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Feedback Category</label>
                        <select name="feedbackType" class="form-control" required>
                            <option value="EXPERIENCE">Overall Platform Experience</option>
                            <option value="SUGGESTION">Feature Suggestion</option>
                            <option value="COMPLIMENT">Compliment / Testimonial</option>
                            <option value="COMPLAINT">Service Complaint</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Your Comments & Suggestions</label>
                        <textarea name="comments" class="form-control" required placeholder="Write your thoughts or testimonial here..."></textarea>
                    </div>

                    <button type="submit" class="btn-action"><i class="bi bi-check-lg"></i> Submit Feedback</button>
                </form>
            </div>

        </div>
    </div>

    <!-- Interactive Popup Modal for Reservation Info, Bank Details, and Buyer NIC Upload -->
    <div id="reservationDossierModal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.65); z-index: 9999; align-items: center; justify-content: center; backdrop-filter: blur(5px); padding: 1rem;">
        <div style="background: #fff; width: 100%; max-width: 720px; border-radius: 20px; padding: 2.25rem; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.3); position: relative; max-height: 92vh; overflow-y: auto;">
            <button onclick="closeReservationDossierModal()" style="position: absolute; top: 1.25rem; right: 1.25rem; background: none; border: none; font-size: 1.6rem; color: #64748b; cursor: pointer;">&times;</button>

            <div style="display: flex; align-items: center; gap: 0.85rem; margin-bottom: 1.5rem;">
                <div style="width: 50px; height: 50px; border-radius: 50%; background: rgba(11, 94, 40, 0.12); color: #0b5e28; display: flex; align-items: center; justify-content: center; font-size: 1.5rem;">
                    <i class="bi bi-file-earmark-lock2-fill"></i>
                </div>
                <div>
                    <h3 style="margin: 0; font-size: 1.35rem; color: #0f172a;">Land Plot Reservation & Conveyancing Dossier</h3>
                    <p style="margin: 0; color: #64748b; font-size: 0.88rem;">Bank Payment Clearance & Buyer Ownership Registration</p>
                </div>
            </div>

            <!-- Plot & Financial Summary -->
            <div style="background: #f8fafc; border: 1px solid var(--border); border-radius: 14px; padding: 1.25rem; margin-bottom: 1.5rem;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; font-size: 0.9rem;">
                    <div>Land Title: <strong id="resModalTitle" style="color: #0b5e28;">-</strong></div>
                    <div>District Location: <strong id="resModalLocation" style="color: #0f172a;">-</strong></div>
                    <div>Plot Area: <strong id="resModalSize" style="color: #0f172a;">-</strong> Perches</div>
                    <div>Payment Status: <strong id="resModalPaymentStatus" style="color: #b45309;">-</strong></div>
                </div>
                <hr style="margin: 0.85rem 0; border: none; border-top: 1px solid #e2e8f0;">
                <div style="display: flex; justify-content: space-between; font-size: 0.9rem;">
                    <div>Total Price: <strong id="resModalPrice" style="color: #0f172a;">-</strong></div>
                    <div>Advance Required: <strong id="resModalAdvance" style="color: #059669;">-</strong></div>
                    <div>Balance: <strong id="resModalBalance" style="color: #dc2626;">-</strong></div>
                </div>
            </div>

            <!-- SECTION 1: BANK TRANSFER & PAYMENT SLIP SUBMISSION -->
            <div style="background: #ffffff; border: 1px solid #cbd5e1; border-radius: 14px; padding: 1.25rem; margin-bottom: 1.5rem;">
                <h4 style="font-size: 1.05rem; font-weight: 800; color: #0f172a; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.4rem;">
                    <i class="bi bi-bank2" style="color: #d97706;"></i> Step 1: Official Bank Account Transfer Details
                </h4>

                <div style="background: #fffbeb; border: 1px solid #fde68a; border-radius: 8px; padding: 0.85rem 1rem; font-size: 0.88rem; color: #92400e; white-space: pre-line; margin-bottom: 1rem;" id="resModalBankDetails">
                    -
                </div>

                <!-- Payment Slip Upload Form (Active when payment not yet verified) -->
                <div id="paymentSubmissionFormBox">
                    <div id="paymentSubmittedNoticeBox" style="display: none; background: #eff6ff; border: 1.5px solid #93c5fa; padding: 0.95rem 1.15rem; border-radius: 12px; margin-bottom: 1rem; color: #1e40af;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.25rem; flex-wrap: wrap; gap: 0.35rem;">
                            <strong style="font-size: 0.92rem; display: flex; align-items: center; gap: 0.4rem;">
                                <i class="bi bi-clock-history" style="color: #2563eb;"></i> Payment Slip Submitted — Awaiting Approval
                            </strong>
                            <span style="background: #2563eb; color: #fff; font-size: 0.75rem; font-weight: 700; padding: 0.2rem 0.55rem; border-radius: 12px;" id="modalSubmittedRefBadge">
                                Ref: Submitted
                            </span>
                        </div>
                        <div style="font-size: 0.82rem; color: #1e3a8a; line-height: 1.4;">
                            Your payment reference has been submitted. The Sales Manager is currently verifying the bank transfer. You can update your reference/slip below if needed.
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/customer/reservation/submit-payment" method="POST">
                        <input type="hidden" id="payModalSaleId" name="saleId">

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 0.75rem;">
                            <div>
                                <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">Bank Transfer Reference / Transaction ID</label>
                                <input type="text" id="payModalReference" name="paymentReference" class="form-control" required placeholder="e.g. TRX-20268492 or Cheque #">
                            </div>
                            <div>
                                <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">Payment Slip Photo / Receipt Link (URL)</label>
                                <input type="text" id="payModalSlipUrl" name="paymentSlipUrl" class="form-control" placeholder="https://example.com/slip.jpg">
                            </div>
                        </div>

                        <button type="submit" class="btn-action" style="background: #d97706; padding: 0.6rem 1.25rem; font-size: 0.88rem;">
                            <i class="bi bi-cloud-arrow-up-fill"></i> Submit Payment Reference to Sales Manager
                        </button>
                    </form>
                </div>

                <div id="paymentVerifiedNoticeBox" style="display: none; background: #ecfdf5; border: 1px solid #a7f3d0; padding: 0.75rem 1rem; border-radius: 8px; color: #065f46; font-weight: 700; font-size: 0.88rem;">
                    <i class="bi bi-check-circle-fill" style="color: #10b981;"></i> Payment Verified by Sales Manager. Step 1 is complete!
                </div>
            </div>

            <!-- SECTION 2: BUYER NIC & DEED DOCUMENTATION (LOCKED UNTIL PAYMENT APPROVED) -->
            <div style="background: #ffffff; border: 1px solid #cbd5e1; border-radius: 14px; padding: 1.25rem;">
                <h4 style="font-size: 1.05rem; font-weight: 800; color: #0f172a; margin-bottom: 0.5rem; display: flex; align-items: center; gap: 0.4rem;">
                    <i class="bi bi-person-vcard-fill" style="color: #0b5e28;"></i> Step 2: Buyer Ownership Documentation (NIC & Proof of Identity)
                </h4>

                <!-- Locked Banner (if payment pending) -->
                <div id="docsLockedBanner" style="background: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 10px; padding: 1.5rem; text-align: center; color: #64748b; margin-top: 0.75rem;">
                    <i class="bi bi-lock-fill" style="font-size: 2rem; color: #94a3b8; display: block; margin-bottom: 0.5rem;"></i>
                    <strong style="color: #334155; font-size: 0.95rem; display: block; margin-bottom: 0.25rem;">Document Submission is Locked</strong>
                    <span id="docsLockedBannerText" style="font-size: 0.85rem;">This section will automatically unlock once your bank payment is verified by the Sales Manager.</span>
                </div>

                <!-- Unlocked Form (when payment verified) -->
                <div id="docsUnlockedForm" style="display: none; margin-top: 1rem;">

                    <!-- Notice when Documents Rejected / Correction Required -->
                    <div id="docsRejectedNoticeBox" style="display: none; background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%); border: 1.5px solid #ef4444; border-radius: 12px; padding: 1rem 1.25rem; margin-bottom: 1.25rem; color: #991b1b;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.35rem; flex-wrap: wrap; gap: 0.5rem;">
                            <strong style="font-size: 0.95rem; color: #991b1b; display: flex; align-items: center; gap: 0.4rem;">
                                <i class="bi bi-exclamation-triangle-fill" style="color: #dc2626; font-size: 1.15rem;"></i> Document Issue Detected by Legal Officer
                            </strong>
                            <span style="background: #dc2626; color: #fff; font-size: 0.75rem; font-weight: 800; padding: 0.2rem 0.65rem; border-radius: 20px;">
                                Action Required
                            </span>
                        </div>
                        <div style="background: #fff; border: 1px solid #fca5a5; border-radius: 8px; padding: 0.65rem 0.85rem; font-size: 0.85rem; color: #7f1d1d; margin: 0.4rem 0;">
                            <strong>Legal Officer Feedback:</strong> <span id="modalLegalRejectNoteText">-</span>
                        </div>
                        <p style="margin: 0; font-size: 0.84rem; color: #991b1b; line-height: 1.4;">
                            Please correct your details or upload clear document links below and click <strong>[Re-submit Corrected Documents]</strong>.
                        </p>
                    </div>

                    <!-- Notice when Documents already submitted & waiting for Legal Approval -->
                    <div id="docsSubmittedNoticeBox" style="display: none; background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%); border: 1.5px solid #f59e0b; border-radius: 12px; padding: 1rem 1.25rem; margin-bottom: 1.25rem; color: #92400e;">
                        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.35rem; flex-wrap: wrap; gap: 0.5rem;">
                            <strong style="font-size: 0.95rem; color: #92400e; display: flex; align-items: center; gap: 0.4rem;">
                                <i class="bi bi-check-circle-fill" style="color: #10b981; font-size: 1.15rem;"></i> Documents Submitted Successfully — Waiting for Legal Approval
                            </strong>
                            <span style="background: #d97706; color: #fff; font-size: 0.75rem; font-weight: 800; padding: 0.2rem 0.65rem; border-radius: 20px;">
                                <i class="bi bi-arrow-repeat"></i> In Processing
                            </span>
                        </div>
                        <p style="margin: 0; font-size: 0.84rem; color: #78350f; line-height: 1.5;">
                            Your Buyer NIC and Ownership Registration details have been received and are currently under review by our Legal Officer and Notary Public. You can update or re-upload your details below if needed.
                        </p>
                    </div>

                    <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 1rem; line-height: 1.5;">
                        Please provide your legal name and national identity document details as required by the Land Registry and Notary Public for drafting the Deed of Transfer.
                    </p>

                    <form action="${pageContext.request.contextPath}/customer/reservation/upload-docs" method="POST">
                        <input type="hidden" id="resModalSaleId" name="saleId">

                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                            <div>
                                <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">Full Legal Name (For Deed Title)</label>
                                <input type="text" id="resModalBuyerName" name="buyerFullName" class="form-control" required placeholder="e.g. Johnathan Doe Perera">
                            </div>
                            <div>
                                <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">National Identity Card (NIC) / Passport #</label>
                                <input type="text" id="resModalBuyerNic" name="buyerNic" class="form-control" required placeholder="e.g. 199012345678 or 901234567V">
                            </div>
                        </div>

                        <div class="form-group" style="margin-bottom: 1rem;">
                            <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">
                                NIC Front & Back Photo Link / Document URL
                            </label>
                            <input type="text" id="resModalNicImg" name="nicImageUrl" class="form-control" placeholder="https://example.com/my-nic-copy.jpg">
                            <small style="color: var(--text-muted); font-size: 0.78rem; display: block; margin-top: 0.25rem;">
                                Attach a direct image link or cloud URL of your scanned NIC/Passport for notary identity verification.
                            </small>
                        </div>

                        <div class="form-group" style="margin-bottom: 1rem;">
                            <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">
                                Proof of Address / Utility Bill Document URL (Optional)
                            </label>
                            <input type="text" id="resModalAddrProof" name="addressProofUrl" class="form-control" placeholder="https://example.com/utility-bill.pdf">
                        </div>

                        <div class="form-group" style="margin-bottom: 1.5rem;">
                            <label style="display: block; font-weight: 700; font-size: 0.85rem; color: #334155; margin-bottom: 0.35rem;">
                                Special Instructions / Joint Owner Details (Optional)
                            </label>
                            <textarea name="notes" rows="2" class="form-control" placeholder="e.g. Please add spouse as co-owner or contact me regarding notary schedule."></textarea>
                        </div>

                        <div style="display: flex; gap: 0.75rem; justify-content: flex-end;">
                            <button type="button" onclick="closeReservationDossierModal()" style="padding: 0.75rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 10px; font-weight: 700; cursor: pointer; color: #475569;">Close</button>
                            <button type="submit" class="btn-action" style="padding: 0.75rem 1.5rem; font-size: 0.95rem;">
                                <i class="bi bi-cloud-upload-fill"></i> Submit Documents to Legal Dept
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- SECTION 3: LEGAL TITLE STATUS, DEED & TRANSFER CERTIFICATE -->
            <div id="legalSectionBox" style="background: #ffffff; border: 1px solid #cbd5e1; border-radius: 14px; padding: 1.25rem; margin-top: 1.5rem;">
                <h4 style="font-size: 1.05rem; font-weight: 800; color: #0f172a; margin-bottom: 0.75rem; display: flex; align-items: center; gap: 0.4rem;">
                    <i class="bi bi-file-earmark-check-fill" style="color: #0b5e28;"></i> Step 3: Legal Conveyancing, Deed & Ownership Transfer
                </h4>

                <!-- Status Banner inside modal -->
                <div id="modalLegalStatusBanner" style="padding: 1rem 1.25rem; border-radius: 12px; margin-bottom: 1rem; background: #f8fafc; border: 1px solid #e2e8f0;">
                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.35rem; flex-wrap: wrap; gap: 0.5rem;">
                        <strong id="modalLegalStatusTitle" style="font-size: 0.95rem; display: flex; align-items: center; gap: 0.4rem; color: #334155;">
                            <i class="bi bi-hourglass-split"></i> Awaiting Legal Review
                        </strong>
                        <span id="modalLegalStatusBadge" style="font-size: 0.75rem; font-weight: 800; padding: 0.2rem 0.65rem; border-radius: 20px; background: #e2e8f0; color: #475569;">
                            Pending
                        </span>
                    </div>
                    <p id="modalLegalStatusDesc" style="margin: 0; font-size: 0.85rem; line-height: 1.5; color: #64748b;">
                        -
                    </p>
                </div>

                <!-- Deed & Notary Details Grid -->
                <div id="modalDeedDetailsGrid" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 1rem; margin-bottom: 1rem;">
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.75rem; font-size: 0.88rem;">
                        <div>Deed of Transfer #: <strong id="modalDeedNumText" style="color: #0369a1;">-</strong></div>
                        <div>Attesting Notary Public: <strong id="modalNotaryNameText" style="color: #0f172a;">-</strong></div>
                    </div>
                    <div style="margin-top: 0.5rem; font-size: 0.85rem;" id="modalLegalNotesContainer">
                        <span style="color: #64748b; font-weight: 700;">Land Registry Folio / Conveyancing Notes:</span>
                        <div id="modalLegalNotesText" style="background: #fff; border: 1px solid #e2e8f0; border-radius: 6px; padding: 0.5rem 0.75rem; margin-top: 0.25rem; color: #334155;">-</div>
                    </div>
                </div>

                <!-- Certificate & Deed Action Buttons -->
                <div id="modalCertActionsBox" style="display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center;">
                    <button type="button" id="modalViewCertBtn" onclick="showOfficialCertificateModalFromResModal()" style="display: none; background: linear-gradient(135deg, #0b5e28 0%, #07401b 100%); color: #ffffff; padding: 0.65rem 1.25rem; border-radius: 8px; font-weight: 700; font-size: 0.88rem; border: none; cursor: pointer; align-items: center; gap: 0.4rem; box-shadow: 0 3px 8px rgba(11, 94, 40, 0.25);">
                        <i class="bi bi-patch-check-fill" style="color: #d4af37;"></i> View & Print Official Ownership Certificate
                    </button>
                    <a id="modalViewDocLink" href="#" target="_blank" style="display: none; background: #0284c7; color: #ffffff; padding: 0.65rem 1.25rem; border-radius: 8px; font-weight: 700; font-size: 0.88rem; text-decoration: none; align-items: center; gap: 0.4rem;">
                        <i class="bi bi-file-earmark-pdf-fill"></i> Open Attached Deed Document
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- MODAL: Republic of Sri Lanka Standard Land Ownership Transfer Certificate -->
    <div id="officialCertModal" style="display: none; position: fixed; inset: 0; background: rgba(15, 23, 42, 0.85); z-index: 10500; align-items: center; justify-content: center; backdrop-filter: blur(8px); padding: 1.5rem; overflow-y: auto;">
        <div style="background: #ffffff; width: 100%; max-width: 780px; border-radius: 18px; box-shadow: 0 25px 60px rgba(0,0,0,0.5); position: relative; overflow: hidden; margin: auto;">

            <!-- Top Action Header (hidden on print) -->
            <div class="no-print" style="background: #0f172a; color: #fff; padding: 0.85rem 1.5rem; display: flex; justify-content: space-between; align-items: center;">
                <span style="font-size: 0.88rem; font-weight: 700; color: #94a3b8; display: flex; align-items: center; gap: 0.4rem;">
                    <i class="bi bi-shield-check" style="color: #10b981;"></i> Official Land Ownership Certificate
                </span>
                <div style="display: flex; gap: 0.5rem; align-items: center;">
                    <button type="button" onclick="window.print()" style="background: #16a34a; color: #fff; border: none; padding: 0.4rem 0.9rem; border-radius: 6px; font-size: 0.82rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.35rem;">
                        <i class="bi bi-printer-fill"></i> Print / Save as PDF
                    </button>
                    <button type="button" onclick="closeOfficialCertificateModal()" style="background: rgba(255,255,255,0.15); border: none; font-size: 1.4rem; color: #fff; width: 32px; height: 32px; border-radius: 50%; cursor: pointer; display: flex; align-items: center; justify-content: center;">&times;</button>
                </div>
            </div>

            <!-- Certificate Printable Sheet -->
            <div id="printableCertificate" style="padding: 2.5rem; background: #fffdf7; border: 8px double #d4af37; margin: 1rem; border-radius: 12px; position: relative;">
                <!-- Decorative Corner Accents -->
                <div style="position: absolute; top: 12px; left: 12px; width: 30px; height: 30px; border-top: 3px solid #0b5e28; border-left: 3px solid #0b5e28;"></div>
                <div style="position: absolute; top: 12px; right: 12px; width: 30px; height: 30px; border-top: 3px solid #0b5e28; border-right: 3px solid #0b5e28;"></div>
                <div style="position: absolute; bottom: 12px; left: 12px; width: 30px; height: 30px; border-bottom: 3px solid #0b5e28; border-left: 3px solid #0b5e28;"></div>
                <div style="position: absolute; bottom: 12px; right: 12px; width: 30px; height: 30px; border-bottom: 3px solid #0b5e28; border-right: 3px solid #0b5e28;"></div>

                <div style="text-align: center; margin-bottom: 1.5rem;">
                    <div style="font-size: 0.82rem; font-weight: 800; letter-spacing: 2px; color: #0b5e28; text-transform: uppercase;">
                        Ceylon Lands Real Estate & Conveyancing Management
                    </div>
                    <div style="font-size: 0.75rem; color: #64748b; letter-spacing: 1px; margin-top: 0.15rem;">
                        DEMOCRATIC SOCIALIST REPUBLIC OF SRI LANKA &bull; LAND REGISTRATION DIVISION
                    </div>
                    <div style="width: 80px; height: 3px; background: #d4af37; margin: 0.75rem auto;"></div>
                    <h1 style="font-family: 'Outfit', serif; font-size: 1.75rem; font-weight: 800; color: #0f172a; margin: 0.5rem 0; text-transform: uppercase; letter-spacing: 1px;">
                        Certificate of Land Ownership Transfer
                    </h1>
                    <p style="font-size: 0.82rem; color: #64748b; font-style: italic;">
                        Official Confirmation of Title Conveyance, Day Book Registration & Deed Attestation
                    </p>
                </div>

                <div style="margin: 1.75rem 0; font-size: 0.95rem; line-height: 1.8; color: #1e293b; text-align: justify;">
                    This is to solemnly certify that in accordance with the Title Registration & Conveyancing laws of Sri Lanka, full freehold title and lawful ownership of the property detailed hereunder has been officially conveyed and transferred:
                </div>

                <!-- Details Table -->
                <div style="background: #ffffff; border: 1.5px solid #e2e8f0; border-radius: 10px; padding: 1.25rem; margin-bottom: 1.5rem;">
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.9rem;">
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b; width: 38%;">Registered Buyer / Lawful Owner:</td>
                            <td style="padding: 0.6rem 0; font-weight: 800; color: #0b5e28; font-size: 1.05rem;" id="certBuyerName">-</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">Owner NIC / Passport Number:</td>
                            <td style="padding: 0.6rem 0; font-weight: 700; font-family: monospace; color: #0f172a;" id="certBuyerNic">-</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">Land Plot Name & Title:</td>
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #0f172a;" id="certPropTitle">-</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">District Location & Extent:</td>
                            <td style="padding: 0.6rem 0; color: #0f172a;"><span id="certPropLoc">-</span> &bull; <strong id="certPropSize">-</strong> Perches</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">Deed of Transfer Registration #:</td>
                            <td style="padding: 0.6rem 0; font-weight: 800; color: #0369a1; font-family: monospace;" id="certDeedNum">-</td>
                        </tr>
                        <tr style="border-bottom: 1px solid #f1f5f9;">
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">Attesting Notary Public:</td>
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #0f172a;" id="certNotary">-</td>
                        </tr>
                        <tr>
                            <td style="padding: 0.6rem 0; font-weight: 700; color: #64748b;">Certificate Issue & Seal Date:</td>
                            <td style="padding: 0.6rem 0; color: #059669; font-weight: 700;" id="certDate">-</td>
                        </tr>
                    </table>
                </div>

                <!-- Signatures & Seals -->
                <div style="display: flex; justify-content: space-between; align-items: flex-end; margin-top: 2rem; padding-top: 1rem;">
                    <div style="text-align: center; width: 200px;">
                        <div style="font-family: 'Brush Script MT', cursive, serif; font-size: 1.4rem; color: #0b5e28; margin-bottom: 0.25rem;">K. S. Fernando</div>
                        <div style="border-top: 1.5px solid #64748b; padding-top: 0.35rem; font-size: 0.78rem; font-weight: 700; color: #334155;">
                            Attesting Notary Public
                        </div>
                    </div>

                    <!-- Seal Badge -->
                    <div style="width: 90px; height: 90px; border-radius: 50%; border: 3px double #d4af37; background: #fdfbf5; display: flex; flex-direction: column; align-items: center; justify-content: center; box-shadow: 0 4px 10px rgba(212, 175, 55, 0.25); text-align: center;">
                        <i class="bi bi-patch-check-fill" style="color: #d4af37; font-size: 1.6rem;"></i>
                        <span style="font-size: 0.55rem; font-weight: 900; color: #0b5e28; text-transform: uppercase; letter-spacing: 0.5px; margin-top: 0.15rem;">OFFICIAL SEAL</span>
                    </div>

                    <div style="text-align: center; width: 200px;">
                        <div style="font-family: 'Brush Script MT', cursive, serif; font-size: 1.4rem; color: #0369a1; margin-bottom: 0.25rem;">R. M. Jayawardena</div>
                        <div style="border-top: 1.5px solid #64748b; padding-top: 0.35rem; font-size: 0.78rem; font-weight: 700; color: #334155;">
                            Registrar of Land Titles
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        var currentActiveSaleId = null;

        function openReservationById(saleId) {
            var dataEl = document.getElementById('res-data-' + saleId);
            if (!dataEl) return;

            currentActiveSaleId = saleId;
            var title = dataEl.querySelector('.res-title') ? dataEl.querySelector('.res-title').innerText : '';
            var location = dataEl.querySelector('.res-location') ? dataEl.querySelector('.res-location').innerText : '';
            var size = dataEl.querySelector('.res-size') ? dataEl.querySelector('.res-size').innerText : '';
            var price = dataEl.querySelector('.res-price') ? dataEl.querySelector('.res-price').innerText : '0';
            var advance = dataEl.querySelector('.res-advance') ? dataEl.querySelector('.res-advance').innerText : '0';
            var balance = dataEl.querySelector('.res-balance') ? dataEl.querySelector('.res-balance').innerText : '0';
            var paymentStatus = dataEl.querySelector('.res-payment-status') ? dataEl.querySelector('.res-payment-status').innerText.trim() : '';
            var bankDetails = dataEl.querySelector('.res-bank-details') ? dataEl.querySelector('.res-bank-details').innerText.trim() : '';
            var payRef = dataEl.querySelector('.res-pay-ref') ? dataEl.querySelector('.res-pay-ref').innerText.trim() : '';
            var paySlip = dataEl.querySelector('.res-pay-slip') ? dataEl.querySelector('.res-pay-slip').innerText.trim() : '';
            var legalStatus = dataEl.querySelector('.res-legal-status') ? dataEl.querySelector('.res-legal-status').innerText.trim() : '';
            var legalNotes = dataEl.querySelector('.res-legal-notes') ? dataEl.querySelector('.res-legal-notes').innerText.trim() : '';
            var deedNo = dataEl.querySelector('.res-deed-no') ? dataEl.querySelector('.res-deed-no').innerText.trim() : '';
            var notaryName = dataEl.querySelector('.res-notary') ? dataEl.querySelector('.res-notary').innerText.trim() : '';
            var transferCert = dataEl.querySelector('.res-transfer-cert') ? dataEl.querySelector('.res-transfer-cert').innerText.trim() : '';
            var buyerName = dataEl.querySelector('.res-buyer-name') ? dataEl.querySelector('.res-buyer-name').innerText.trim() : '';
            var buyerNic = dataEl.querySelector('.res-buyer-nic') ? dataEl.querySelector('.res-buyer-nic').innerText.trim() : '';
            var nicImg = dataEl.querySelector('.res-nic-img') ? dataEl.querySelector('.res-nic-img').innerText.trim() : '';
            var addrProof = dataEl.querySelector('.res-addr-proof') ? dataEl.querySelector('.res-addr-proof').innerText.trim() : '';

            document.getElementById('resModalSaleId').value = saleId;
            document.getElementById('payModalSaleId').value = saleId;
            document.getElementById('resModalTitle').innerText = title;
            document.getElementById('resModalLocation').innerText = location;
            document.getElementById('resModalSize').innerText = size;
            document.getElementById('resModalPrice').innerText = 'Rs. ' + Number(price).toLocaleString();
            document.getElementById('resModalAdvance').innerText = 'Rs. ' + Number(advance).toLocaleString();
            document.getElementById('resModalBalance').innerText = 'Rs. ' + Number(balance).toLocaleString();

            var displayPayStatus = 'Pending Payment';
            if (paymentStatus === 'PAYMENT_SUBMITTED') {
                displayPayStatus = 'Slip Submitted (Awaiting Approval)';
            } else if (paymentStatus === 'PAYMENT_VERIFIED' || paymentStatus === 'FULLY_PAID' || paymentStatus === 'PAID') {
                displayPayStatus = 'Payment Verified & Approved';
            }
            document.getElementById('resModalPaymentStatus').innerText = displayPayStatus;

            document.getElementById('resModalBankDetails').innerText = bankDetails && bankDetails !== '' ? bankDetails : 'Commercial Bank PLC - Ceylon Lands (Pvt) Ltd - A/C 1000849201 - Colombo Corporate Branch';
            document.getElementById('payModalReference').value = payRef || '';
            document.getElementById('payModalSlipUrl').value = paySlip || '';

            var isPaymentSubmitted = (paymentStatus === 'PAYMENT_SUBMITTED');
            var isPaymentVerified = (paymentStatus === 'PAYMENT_VERIFIED' || paymentStatus === 'FULLY_PAID' || paymentStatus === 'PAID');

            if (isPaymentVerified) {
                document.getElementById('paymentSubmissionFormBox').style.display = 'none';
                document.getElementById('paymentSubmittedNoticeBox').style.display = 'none';
                document.getElementById('paymentVerifiedNoticeBox').style.display = 'block';
                document.getElementById('docsLockedBanner').style.display = 'none';
                document.getElementById('docsUnlockedForm').style.display = 'block';

                // Check if docs rejected vs submitted vs milestones
                if (legalStatus === 'DOCS_REJECTED') {
                    document.getElementById('docsRejectedNoticeBox').style.display = 'block';
                    document.getElementById('modalLegalRejectNoteText').innerText = legalNotes || 'Documents require correction. Please re-upload clear details.';
                    document.getElementById('docsSubmittedNoticeBox').style.display = 'none';
                } else if (legalStatus === 'DOCS_SUBMITTED') {
                    document.getElementById('docsRejectedNoticeBox').style.display = 'none';
                    document.getElementById('docsSubmittedNoticeBox').style.display = 'block';
                } else if (legalStatus === 'TITLE_CLEARED' || legalStatus === 'DEED_DRAFTED' || legalStatus === 'READY_TO_SIGN' || legalStatus === 'OWNERSHIP_TRANSFERRED') {
                    document.getElementById('docsRejectedNoticeBox').style.display = 'none';
                    document.getElementById('docsSubmittedNoticeBox').style.display = 'none';
                } else {
                    document.getElementById('docsRejectedNoticeBox').style.display = 'none';
                    document.getElementById('docsSubmittedNoticeBox').style.display = (buyerNic && buyerNic.trim() !== '') ? 'block' : 'none';
                }
            } else if (isPaymentSubmitted) {
                document.getElementById('paymentSubmissionFormBox').style.display = 'block';
                document.getElementById('paymentSubmittedNoticeBox').style.display = 'block';
                document.getElementById('modalSubmittedRefBadge').innerText = 'Ref: ' + (payRef || 'Submitted');
                document.getElementById('paymentVerifiedNoticeBox').style.display = 'none';
                document.getElementById('docsLockedBanner').style.display = 'block';
                document.getElementById('docsLockedBannerText').innerText = 'Payment is under verification by Sales Manager. Step 2 will unlock once verified.';
                document.getElementById('docsUnlockedForm').style.display = 'none';
            } else {
                document.getElementById('paymentSubmissionFormBox').style.display = 'block';
                document.getElementById('paymentSubmittedNoticeBox').style.display = 'none';
                document.getElementById('paymentVerifiedNoticeBox').style.display = 'none';
                document.getElementById('docsLockedBanner').style.display = 'block';
                document.getElementById('docsLockedBannerText').innerText = 'This section will automatically unlock once your bank payment is verified by the Sales Manager.';
                document.getElementById('docsUnlockedForm').style.display = 'none';
            }

            document.getElementById('resModalBuyerName').value = buyerName || '';
            document.getElementById('resModalBuyerNic').value = buyerNic || '';
            document.getElementById('resModalNicImg').value = nicImg || '';
            document.getElementById('resModalAddrProof').value = addrProof || '';

            // Section 3 Legal Conveyancing status banner & details
            var statusBanner = document.getElementById('modalLegalStatusBanner');
            var statusTitle = document.getElementById('modalLegalStatusTitle');
            var statusBadge = document.getElementById('modalLegalStatusBadge');
            var statusDesc = document.getElementById('modalLegalStatusDesc');

            document.getElementById('modalDeedNumText').innerText = deedNo && deedNo !== '' ? deedNo : 'Pending Deed Preparation';
            document.getElementById('modalNotaryNameText').innerText = notaryName && notaryName !== '' ? notaryName : 'Attorney-at-Law / Notary Public';
            document.getElementById('modalLegalNotesText').innerText = legalNotes && legalNotes !== '' ? legalNotes : 'Land Registry title search in progress. Awaiting conveyance milestones.';

            var certBtn = document.getElementById('modalViewCertBtn');
            var docLink = document.getElementById('modalViewDocLink');

            if (legalStatus === 'OWNERSHIP_TRANSFERRED') {
                statusBanner.style.background = 'linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%)';
                statusBanner.style.border = '1.5px solid #16a34a';
                statusTitle.style.color = '#14532d';
                statusTitle.innerHTML = '<i class="bi bi-award-fill" style="color: #16a34a;"></i> Ownership Transferred & Deed Registered';
                statusBadge.style.background = '#15803d';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = '<i class="bi bi-patch-check-fill"></i> Completed';
                statusDesc.style.color = '#166534';
                statusDesc.innerText = 'The Deed of Transfer has been registered at the Land Registry. Full freehold ownership has been officially transferred to ' + (buyerName || 'Purchaser') + '.';

                certBtn.style.display = 'inline-flex';
                if (transferCert && transferCert.trim() !== '') {
                    docLink.href = transferCert;
                    docLink.style.display = 'inline-flex';
                } else {
                    docLink.style.display = 'none';
                }
            } else if (legalStatus === 'READY_TO_SIGN') {
                statusBanner.style.background = 'linear-gradient(135deg, #faf5ff 0%, #f3e8ff 100%)';
                statusBanner.style.border = '1.5px solid #9333ea';
                statusTitle.style.color = '#6b21a8';
                statusTitle.innerHTML = '<i class="bi bi-pen-fill" style="color: #9333ea;"></i> Ready for Notary Signing';
                statusBadge.style.background = '#9333ea';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = '<i class="bi bi-calendar-check"></i> Ready to Sign';
                statusDesc.style.color = '#581c87';
                statusDesc.innerText = 'The Deed of Transfer (' + (deedNo || 'Ref: Assigned') + ') is ready for signing before Notary Public ' + (notaryName || 'Attorney') + '. Please contact legal support or attend the scheduled appointment.';
                certBtn.style.display = 'none';
                if (transferCert && transferCert.trim() !== '') {
                    docLink.href = transferCert;
                    docLink.style.display = 'inline-flex';
                } else {
                    docLink.style.display = 'none';
                }
            } else if (legalStatus === 'DEED_DRAFTED') {
                statusBanner.style.background = 'linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%)';
                statusBanner.style.border = '1.5px solid #0284c7';
                statusTitle.style.color = '#075985';
                statusTitle.innerHTML = '<i class="bi bi-file-earmark-text-fill" style="color: #0284c7;"></i> Deed of Transfer Drafted';
                statusBadge.style.background = '#0284c7';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = '<i class="bi bi-file-earmark-check"></i> Deed Drafted';
                statusDesc.style.color = '#0c4a6e';
                statusDesc.innerText = 'Official Deed of Transfer ' + (deedNo ? '(' + deedNo + ')' : '') + ' has been prepared by ' + (notaryName || 'Notary Public') + '. Stamp duty calculations & execution preparations are in progress.';
                certBtn.style.display = 'none';
                if (transferCert && transferCert.trim() !== '') {
                    docLink.href = transferCert;
                    docLink.style.display = 'inline-flex';
                } else {
                    docLink.style.display = 'none';
                }
            } else if (legalStatus === 'TITLE_CLEARED') {
                statusBanner.style.background = 'linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%)';
                statusBanner.style.border = '1.5px solid #22c55e';
                statusTitle.style.color = '#166534';
                statusTitle.innerHTML = '<i class="bi bi-shield-check" style="color: #16a34a;"></i> Title Search 100% Cleared';
                statusBadge.style.background = '#16a34a';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = '<i class="bi bi-check-lg"></i> Title OK';
                statusDesc.style.color = '#14532d';
                statusDesc.innerText = 'The Land Registry title search for this plot has passed with 100% clean, unencumbered freehold title. The legal team is drafting your Deed of Transfer.';
                certBtn.style.display = 'none';
                docLink.style.display = 'none';
            } else if (legalStatus === 'DOCS_REJECTED') {
                statusBanner.style.background = 'linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%)';
                statusBanner.style.border = '1.5px solid #ef4444';
                statusTitle.style.color = '#991b1b';
                statusTitle.innerHTML = '<i class="bi bi-exclamation-triangle-fill" style="color: #dc2626;"></i> Document Correction Required';
                statusBadge.style.background = '#dc2626';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = 'Correction Needed';
                statusDesc.style.color = '#7f1d1d';
                statusDesc.innerText = 'Legal officer requested document correction: "' + (legalNotes || 'Please re-upload clear documents.') + '"';
                certBtn.style.display = 'none';
                docLink.style.display = 'none';
            } else if (legalStatus === 'DOCS_SUBMITTED' || (buyerNic && buyerNic.trim() !== '')) {
                statusBanner.style.background = 'linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%)';
                statusBanner.style.border = '1.5px solid #f59e0b';
                statusTitle.style.color = '#92400e';
                statusTitle.innerHTML = '<i class="bi bi-hourglass-split" style="color: #d97706;"></i> In Legal Conveyancing Processing';
                statusBadge.style.background = '#d97706';
                statusBadge.style.color = '#ffffff';
                statusBadge.innerHTML = 'Under Review';
                statusDesc.style.color = '#78350f';
                statusDesc.innerText = 'Buyer documents received. The Legal Officer is conducting the title search at the Land Registry and preparing preliminary conveyancing documents.';
                certBtn.style.display = 'none';
                docLink.style.display = 'none';
            } else {
                statusBanner.style.background = '#f8fafc';
                statusBanner.style.border = '1px solid #e2e8f0';
                statusTitle.style.color = '#475569';
                statusTitle.innerHTML = '<i class="bi bi-lock-fill"></i> Awaiting Step 1 & 2 Completion';
                statusBadge.style.background = '#e2e8f0';
                statusBadge.style.color = '#475569';
                statusBadge.innerHTML = 'Pending';
                statusDesc.style.color = '#64748b';
                statusDesc.innerText = 'Please verify payment and submit your Buyer NIC and details in Step 2 to initiate legal title deed processing.';
                certBtn.style.display = 'none';
                docLink.style.display = 'none';
            }

            document.getElementById('reservationDossierModal').style.display = 'flex';
        }

        function closeReservationDossierModal() {
            document.getElementById('reservationDossierModal').style.display = 'none';
        }

        function showOfficialCertificateModal(saleId) {
            var dataEl = document.getElementById('res-data-' + saleId);
            if (!dataEl) return;

            currentActiveSaleId = saleId;
            var title = dataEl.querySelector('.res-title') ? dataEl.querySelector('.res-title').innerText : 'Prime Land Plot';
            var location = dataEl.querySelector('.res-location') ? dataEl.querySelector('.res-location').innerText : 'Colombo, Sri Lanka';
            var size = dataEl.querySelector('.res-size') ? dataEl.querySelector('.res-size').innerText : '-';
            var buyerName = dataEl.querySelector('.res-buyer-name') ? dataEl.querySelector('.res-buyer-name').innerText : 'Lawful Purchaser';
            var buyerNic = dataEl.querySelector('.res-buyer-nic') ? dataEl.querySelector('.res-buyer-nic').innerText : '-';
            var deedNo = dataEl.querySelector('.res-deed-no') ? dataEl.querySelector('.res-deed-no').innerText : 'TS-DEED-' + saleId;
            var notaryName = dataEl.querySelector('.res-notary') ? dataEl.querySelector('.res-notary').innerText : 'Attorney K. S. Fernando, N.P.';

            document.getElementById('certBuyerName').innerText = buyerName;
            document.getElementById('certBuyerNic').innerText = buyerNic;
            document.getElementById('certPropTitle').innerText = title;
            document.getElementById('certPropLoc').innerText = location;
            document.getElementById('certPropSize').innerText = size;
            document.getElementById('certDeedNum').innerText = deedNo && deedNo.trim() !== '' ? deedNo : ('TS-DEED-2026/' + saleId);
            document.getElementById('certNotary').innerText = notaryName && notaryName.trim() !== '' ? notaryName : 'Attorney K. S. Fernando, N.P.';

            var today = new Date();
            var dateStr = today.toLocaleDateString('en-GB', { day: 'numeric', month: 'long', year: 'numeric' });
            document.getElementById('certDate').innerText = dateStr;

            document.getElementById('officialCertModal').style.display = 'flex';
        }

        function showOfficialCertificateModalFromResModal() {
            var saleId = document.getElementById('resModalSaleId').value;
            if (saleId) {
                showOfficialCertificateModal(saleId);
            }
        }

        function closeOfficialCertificateModal() {
            document.getElementById('officialCertModal').style.display = 'none';
        }

        function switchTab(tabName) {
            // Hide all tab panels
            document.querySelectorAll('.tab-panel').forEach(function(panel) {
                panel.style.display = 'none';
            });
            // Remove active class from buttons
            document.querySelectorAll('.tab-btn').forEach(function(btn) {
                btn.classList.remove('active');
            });

            // Show selected panel
            var activePanel = document.getElementById('tab-' + tabName);
            if (activePanel) {
                activePanel.style.display = 'block';
            }

            // Highlight button
            var buttons = document.querySelectorAll('.tab-btn');
            buttons.forEach(function(btn) {
                if (btn.getAttribute('onclick').includes(tabName)) {
                    btn.classList.add('active');
                }
            });
        }

        // Handle URL ?tab= parameter
        window.addEventListener('DOMContentLoaded', function() {
            var urlParams = new URLSearchParams(window.location.search);
            var tab = urlParams.get('tab');
            if (tab) {
                switchTab(tab);
            }
        });
    </script>
</body>
</html>
