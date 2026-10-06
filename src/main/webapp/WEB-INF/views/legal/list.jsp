<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Legal & Conveyancing Management | Ceylon Lands</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Outfit:wght@500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #0b5e28;
            --primary-dark: #07401b;
            --secondary: #d4af37;
            --bg-light: #f8fafc;
            --card-bg: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border: #e2e8f0;
            --sidebar-width: 260px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background-color: var(--bg-light);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        .sidebar {
            width: var(--sidebar-width);
            background-color: #061c10;
            color: #ffffff;
            padding: 1.5rem;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
            border-right: 1px solid rgba(255, 255, 255, 0.05);
        }

        .sidebar .logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-family: 'Outfit', sans-serif;
            font-size: 1.5rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 2rem;
            text-decoration: none;
        }

        .sidebar .logo i {
            color: var(--secondary);
            font-size: 1.75rem;
        }

        .nav-links {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .nav-links li a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1rem;
            color: #94a3b8;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .nav-links li.active a, .nav-links li a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffffff;
        }

        .nav-links li.active a {
            background-color: var(--primary);
            color: #ffffff;
            font-weight: 600;
        }

        /* Main Container */
        .main-container {
            margin-left: var(--sidebar-width);
            flex: 1;
            padding: 2.5rem;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        header h1 {
            font-family: 'Outfit', sans-serif;
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--text-dark);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.25rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 1.25rem 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }

        .stat-card h4 {
            font-size: 0.82rem;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.35rem;
        }

        .stat-card .stat-val {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text-dark);
        }

        .stat-icon-box {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }

        /* Table Card */
        .table-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            overflow-x: auto;
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
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 1.1rem 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.92rem;
            vertical-align: middle;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            padding: 0.3rem 0.75rem;
            border-radius: 20px;
            font-size: 0.78rem;
            font-weight: 700;
        }

        .btn-action {
            background: linear-gradient(135deg, #0b5e28 0%, #07401b 100%);
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.82rem;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
            transition: all 0.2s ease;
        }

        .btn-action:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(11, 94, 40, 0.25);
        }

        .alert-success {
            background: #ecfdf5;
            border: 1px solid #10b981;
            color: #065f46;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 600;
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
            <li class="active"><a href="${pageContext.request.contextPath}/legal"><i class="bi bi-file-earmark-text-fill"></i> Legal & Deeds</a></li>
            <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                <li><a href="${pageContext.request.contextPath}/"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>
                <li><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>
                <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
                <li><a href="${pageContext.request.contextPath}/survey"><i class="bi bi-geo-alt-fill"></i> Surveys</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-person-gear"></i> System Users</a></li>
            </c:if>
            <li><a href="${pageContext.request.contextPath}/properties" target="_blank"><i class="bi bi-compass-fill"></i> Public Land Catalog</a></li>
            <li><a href="${pageContext.request.contextPath}/home" target="_blank"><i class="bi bi-globe"></i> Public Site</a></li>
        </ul>
    </div>

    <!-- Main Content Area -->
    <div class="main-container">
        <header style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
            <div>
                <h1>Legal & Conveyancing Management</h1>
                <p style="color: var(--text-muted); font-size: 0.9rem;">
                    Inspect buyer KYC/NIC documents, verify title deeds, draft Deed of Transfer, and register official land ownership.
                </p>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem;">
                <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
                <div style="text-align: right;">
                    <div style="font-weight: 700; font-size: 0.95rem; color: #0f172a;">${pageContext.request.userPrincipal.name}</div>
                    <div style="font-size: 0.8rem; color: #059669; font-weight: 600;">Legal Officer</div>
                    <form action="${pageContext.request.contextPath}/logout" method="POST" style="display: inline; margin-top: 0.2rem;">
                        <button type="submit" style="background: none; border: none; color: #ef4444; font-size: 0.78rem; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 0.2rem; padding: 0;">
                            <i class="bi bi-box-arrow-right"></i> Log Out
                        </button>
                    </form>
                </div>
                <div style="width: 42px; height: 42px; border-radius: 50%; background: #dcfce7; color: #0b5e28; display: flex; align-items: center; justify-content: center; font-size: 1.25rem; font-weight: 700;">
                    <i class="bi bi-shield-check"></i>
                </div>
            </div>
        </header>

        <!-- Flash alerts -->
        <c:if test="${not empty legalSuccess}">
            <div class="alert-success">
                <i class="bi bi-check-circle-fill" style="font-size: 1.2rem; color: #10b981;"></i>
                <span>${legalSuccess}</span>
            </div>
        </c:if>

        <!-- Stats Overview -->
        <div class="stats-grid">
            <div class="stat-card">
                <div>
                    <h4>Total Active Cases</h4>
                    <div class="stat-val">${cases.size()}</div>
                </div>
                <div class="stat-icon-box" style="background: rgba(11, 94, 40, 0.1); color: var(--primary);">
                    <i class="bi bi-folder2-open"></i>
                </div>
            </div>
            <div class="stat-card">
                <div>
                    <h4>Awaiting Buyer NIC</h4>
                    <div class="stat-val">
                        <c:set var="pendingDocsCount" value="0"/>
                        <c:forEach var="c" items="${cases}">
                            <c:if test="${empty c.legalStatus or c.legalStatus == 'PENDING_DOCS'}">
                                <c:set var="pendingDocsCount" value="${pendingDocsCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${pendingDocsCount}
                    </div>
                </div>
                <div class="stat-icon-box" style="background: rgba(245, 158, 11, 0.1); color: #d97706;">
                    <i class="bi bi-person-exclamation"></i>
                </div>
            </div>
            <div class="stat-card">
                <div>
                    <h4>Buyer Docs Uploaded</h4>
                    <div class="stat-val">
                        <c:set var="docsSubmittedCount" value="0"/>
                        <c:forEach var="c" items="${cases}">
                            <c:if test="${c.legalStatus == 'DOCS_SUBMITTED'}">
                                <c:set var="docsSubmittedCount" value="${docsSubmittedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${docsSubmittedCount}
                    </div>
                </div>
                <div class="stat-icon-box" style="background: rgba(59, 130, 246, 0.1); color: #2563eb;">
                    <i class="bi bi-file-earmark-check"></i>
                </div>
            </div>
            <div class="stat-card">
                <div>
                    <h4>Deeds Registered & Transferred</h4>
                    <div class="stat-val">
                        <c:set var="completedCount" value="0"/>
                        <c:forEach var="c" items="${cases}">
                            <c:if test="${c.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                <c:set var="completedCount" value="${completedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${completedCount}
                    </div>
                </div>
                <div class="stat-icon-box" style="background: rgba(16, 185, 129, 0.1); color: #059669;">
                    <i class="bi bi-patch-check-fill"></i>
                </div>
            </div>
        </div>

        <!-- Cases Table -->
        <div class="table-card">
            <h2 style="font-size: 1.25rem; font-weight: 800; margin-bottom: 1.25rem; display: flex; align-items: center; gap: 0.5rem;">
                <i class="bi bi-journal-text" style="color: var(--primary);"></i> Title Conveyancing & Deed Processing Dossiers
            </h2>

            <table>
                <thead>
                    <tr>
                        <th>Case #</th>
                        <th>Land Plot & Location</th>
                        <th>Registered Buyer / Owner</th>
                        <th>Buyer NIC / Documents</th>
                        <th>Financials</th>
                        <th>Legal Progress</th>
                        <th>Legal Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="c" items="${cases}">
                        <tr>
                            <td><strong>#CASE-${c.id}</strong></td>
                            <td>
                                <strong style="color: var(--text-dark);">${c.property.title}</strong>
                                <div style="font-size: 0.8rem; color: var(--text-muted);"><i class="bi bi-geo-alt-fill"></i> ${c.property.location} (${c.property.size} Perches)</div>
                            </td>
                            <td>
                                <div style="font-weight: 700; color: #0f172a;">${not empty c.buyerFullName ? c.buyerFullName : c.customer.name}</div>
                                <div style="font-size: 0.8rem; color: var(--text-muted);"><i class="bi bi-telephone-fill"></i> ${c.customer.phone}</div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty c.buyerNic or not empty c.nicImageUrl or not empty c.addressProofUrl}">
                                        <div style="font-weight: 800; color: #047857; font-size: 0.88rem;">
                                            <i class="bi bi-person-vcard-fill"></i> ${not empty c.buyerNic ? c.buyerNic : 'NIC Attached'}
                                        </div>
                                        <button type="button"
                                                style="margin-top: 0.35rem; padding: 0.35rem 0.75rem; background: #eff6ff; border: 1px solid #bfdbfe; color: #1d4ed8; border-radius: 6px; font-size: 0.78rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.35rem; transition: all 0.2s;"
                                                onclick="openBuyerDossierById('${c.id}')">
                                            <i class="bi bi-eye-fill"></i> View Submitted Docs
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #d97706; font-size: 0.82rem; font-weight: 700; background: #fef3c7; padding: 0.25rem 0.5rem; border-radius: 6px; display: inline-flex; align-items: center; gap: 0.25rem;">
                                            <i class="bi bi-hourglass-split"></i> Awaiting Buyer Docs
                                        </span>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Hidden safe container for case data -->
                                <div id="legal-case-data-${c.id}" style="display: none;">
                                    <span class="lcd-id">${c.id}</span>
                                    <span class="lcd-title"><c:out value="${c.property.title}"/></span>
                                    <span class="lcd-location"><c:out value="${c.property.location}"/></span>
                                    <span class="lcd-size"><c:out value="${c.property.size}"/></span>
                                    <span class="lcd-buyer"><c:out value="${not empty c.buyerFullName ? c.buyerFullName : c.customer.name}"/></span>
                                    <span class="lcd-cust-name"><c:out value="${c.customer.name}"/></span>
                                    <span class="lcd-phone"><c:out value="${c.customer.phone}"/></span>
                                    <span class="lcd-email"><c:out value="${c.customer.email}"/></span>
                                    <span class="lcd-addr"><c:out value="${c.customer.address}"/></span>
                                    <span class="lcd-nic"><c:out value="${c.buyerNic}"/></span>
                                    <span class="lcd-nic-img"><c:out value="${c.nicImageUrl}"/></span>
                                    <span class="lcd-addr-proof"><c:out value="${c.addressProofUrl}"/></span>
                                    <span class="lcd-pay-ref"><c:out value="${c.paymentReference}"/></span>
                                    <span class="lcd-pay-slip"><c:out value="${c.paymentSlipUrl}"/></span>
                                    <span class="lcd-price"><c:out value="${c.salePrice}"/></span>
                                    <span class="lcd-adv"><c:out value="${c.advancePaid}"/></span>
                                    <span class="lcd-status"><c:out value="${c.legalStatus}"/></span>
                                    <span class="lcd-deed"><c:out value="${c.deedNumber}"/></span>
                                    <span class="lcd-notary"><c:out value="${c.notaryName}"/></span>
                                    <span class="lcd-cert"><c:out value="${c.transferCertificateUrl}"/></span>
                                    <div class="lcd-notes"><c:out value="${c.salesNotes}"/></div>
                                    <div class="lcd-legal-notes"><c:out value="${c.legalNotes}"/></div>
                                </div>
                            </td>
                            <td>
                                <div style="font-size: 0.88rem; font-weight: 700;">Rs. <fmt:formatNumber value="${c.salePrice}" type="number" maxFractionDigits="2"/></div>
                                <div style="font-size: 0.8rem; color: #059669; font-weight: 600;">Adv: Rs. <fmt:formatNumber value="${c.advancePaid != null ? c.advancePaid : 0}" type="number" maxFractionDigits="2"/></div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${c.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                        <span class="status-pill" style="background: #dcfce7; color: #15803d;"><i class="bi bi-award-fill"></i> Deed Transferred</span>
                                    </c:when>
                                    <c:when test="${c.legalStatus == 'READY_TO_SIGN'}">
                                        <span class="status-pill" style="background: #ede9fe; color: #6d28d9;"><i class="bi bi-pen-fill"></i> Ready for Signing</span>
                                    </c:when>
                                    <c:when test="${c.legalStatus == 'DEED_DRAFTED'}">
                                        <span class="status-pill" style="background: #e0f2fe; color: #0369a1;"><i class="bi bi-file-earmark-text"></i> Deed Drafted</span>
                                    </c:when>
                                    <c:when test="${c.legalStatus == 'TITLE_CLEARED'}">
                                        <span class="status-pill" style="background: #dcfce7; color: #047857;"><i class="bi bi-shield-check"></i> Title Cleared</span>
                                    </c:when>
                                    <c:when test="${c.legalStatus == 'DOCS_REJECTED'}">
                                        <span class="status-pill" style="background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; font-weight: 800;"><i class="bi bi-exclamation-triangle-fill"></i> Correction Requested</span>
                                        <div style="font-size: 0.75rem; color: #b91c1c; margin-top: 0.25rem; font-weight: 600; max-width: 180px;">${c.legalNotes}</div>
                                    </c:when>
                                    <c:when test="${c.legalStatus == 'DOCS_SUBMITTED'}">
                                        <span class="status-pill" style="background: #fef3c7; color: #b45309;"><i class="bi bi-file-earmark-person"></i> Docs Submitted</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-pill" style="background: #f1f5f9; color: #475569;"><i class="bi bi-clock-history"></i> Pending Docs</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty c.deedNumber}">
                                    <div style="font-size: 0.78rem; color: #475569; margin-top: 0.2rem; font-weight: 600;">Deed: ${c.deedNumber}</div>
                                </c:if>
                                <c:if test="${not empty c.transferCertificateUrl}">
                                    <div style="margin-top: 0.35rem;">
                                        <a href="${c.transferCertificateUrl}" target="_blank" style="padding: 0.2rem 0.5rem; background: #ecfdf5; border: 1px solid #a7f3d0; color: #047857; border-radius: 6px; font-size: 0.72rem; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 0.25rem;">
                                            <i class="bi bi-file-earmark-check-fill"></i> Certificate Attached
                                        </a>
                                    </div>
                                </c:if>
                            </td>
                            <td>
                                <div style="display: flex; flex-direction: column; gap: 0.4rem;">
                                    <button type="button" class="btn-action"
                                            data-id="${c.id}"
                                            data-title="${c.property.title}"
                                            data-buyer="${c.buyerFullName != null ? c.buyerFullName : c.customer.name}"
                                            data-nic="${c.buyerNic}"
                                            data-status="${c.legalStatus}"
                                            data-deed="${c.deedNumber}"
                                            data-notary="${c.notaryName}"
                                            data-nic-img="${c.nicImageUrl}"
                                            data-addr-proof="${c.addressProofUrl}"
                                            onclick="openLegalModalFromBtn(this)">
                                        <i class="bi bi-pencil-square"></i> Process Deed
                                    </button>
                                    <c:if test="${not empty c.buyerNic or not empty c.nicImageUrl or not empty c.addressProofUrl or c.legalStatus == 'DOCS_SUBMITTED' or c.legalStatus == 'DOCS_REJECTED'}">
                                        <button type="button"
                                                style="padding: 0.35rem 0.65rem; background: #fee2e2; border: 1px solid #fca5a5; color: #991b1b; border-radius: 6px; font-size: 0.78rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; justify-content: center; gap: 0.25rem;"
                                                onclick="openRejectModal('${c.id}', '${c.property.title}', '${not empty c.buyerFullName ? c.buyerFullName : c.customer.name}')">
                                            <i class="bi bi-x-circle-fill"></i> Reject Docs / Issue
                                        </button>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty cases}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: var(--text-muted); padding: 3rem;">
                                No active legal conveyancing cases. Approved sales reservations will appear here automatically.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- MODAL 1: Comprehensive Buyer Submitted Documents & Info Inspection Dossier -->
    <div id="buyerDossierModal" style="display: none; position: fixed; inset: 0; background: rgba(15, 23, 42, 0.75); z-index: 9999; align-items: center; justify-content: center; backdrop-filter: blur(6px); padding: 1.5rem;">
        <div style="background: #ffffff; width: 100%; max-width: 820px; border-radius: 18px; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.35); position: relative; max-height: 90vh; display: flex; flex-direction: column; overflow: hidden;">

            <!-- Modal Header -->
            <div style="padding: 1.5rem 2rem; background: linear-gradient(135deg, #0b5e28 0%, #06401b 100%); color: #fff; display: flex; justify-content: space-between; align-items: center;">
                <div style="display: flex; align-items: center; gap: 0.85rem;">
                    <div style="width: 44px; height: 44px; border-radius: 12px; background: rgba(255, 255, 255, 0.15); display: flex; align-items: center; justify-content: center; font-size: 1.35rem;">
                        <i class="bi bi-folder-check"></i>
                    </div>
                    <div>
                        <h3 style="margin: 0; font-size: 1.25rem; font-weight: 800; color: #fff;">Buyer KYC & Legal Conveyancing Dossier</h3>
                        <p style="margin: 0; font-size: 0.82rem; color: #cbd5e1;">Case #<span id="dossierCaseId">-</span> &bull; Verified Documentation</p>
                    </div>
                </div>
                <button onclick="closeBuyerDossier()" style="background: rgba(255,255,255,0.15); border: none; font-size: 1.4rem; color: #fff; width: 36px; height: 36px; border-radius: 50%; cursor: pointer; display: flex; align-items: center; justify-content: center;">&times;</button>
            </div>

            <!-- Modal Body (Scrollable) -->
            <div style="padding: 2rem; overflow-y: auto; flex: 1; display: flex; flex-direction: column; gap: 1.5rem;">

                <!-- Land & Buyer Quick Info Bar -->
                <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 1.25rem; display: grid; grid-template-columns: 1.2fr 1fr; gap: 1.5rem;">
                    <div>
                        <span style="font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px;">Land Plot Under Conveyancing</span>
                        <h4 id="dossierPropTitle" style="margin: 0.25rem 0; font-size: 1.1rem; color: #0b5e28; font-weight: 800;">-</h4>
                        <div id="dossierPropLocation" style="font-size: 0.82rem; color: #64748b;"><i class="bi bi-geo-alt-fill"></i> -</div>
                    </div>
                    <div>
                        <span style="font-size: 0.75rem; font-weight: 800; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px;">Financial Summary</span>
                        <div style="margin-top: 0.25rem; font-size: 1.05rem; font-weight: 800; color: #0f172a;" id="dossierPrice">-</div>
                        <div style="font-size: 0.82rem; color: #059669; font-weight: 700;" id="dossierAdvance">-</div>
                    </div>
                </div>

                <!-- 2-Column Grid: Buyer Legal Details & Submitted Documents -->
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">

                    <!-- Left Column: Legal Buyer Details -->
                    <div style="border: 1px solid #e2e8f0; border-radius: 14px; padding: 1.25rem; background: #fff;">
                        <h4 style="font-size: 0.95rem; font-weight: 800; color: #0f172a; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.4rem;">
                            <i class="bi bi-person-lines-fill" style="color: #0b5e28;"></i> Registered Buyer Details
                        </h4>

                        <div style="display: flex; flex-direction: column; gap: 0.85rem; font-size: 0.88rem;">
                            <div>
                                <span style="display: block; font-size: 0.75rem; color: #64748b; font-weight: 700; text-transform: uppercase;">Full Legal Name for Deed:</span>
                                <strong id="dossierLegalBuyerName" style="color: #0f172a; font-size: 0.95rem;">-</strong>
                            </div>
                            <div>
                                <span style="display: block; font-size: 0.75rem; color: #64748b; font-weight: 700; text-transform: uppercase;">NIC / Passport Number:</span>
                                <strong id="dossierBuyerNic" style="color: #047857; font-size: 1rem; font-family: monospace;">-</strong>
                            </div>
                            <div>
                                <span style="display: block; font-size: 0.75rem; color: #64748b; font-weight: 700; text-transform: uppercase;">Contact Phone:</span>
                                <span id="dossierPhone" style="color: #334155; font-weight: 600;">-</span>
                            </div>
                            <div>
                                <span style="display: block; font-size: 0.75rem; color: #64748b; font-weight: 700; text-transform: uppercase;">Email Address:</span>
                                <span id="dossierEmail" style="color: #334155; font-weight: 600;">-</span>
                            </div>
                            <div>
                                <span style="display: block; font-size: 0.75rem; color: #64748b; font-weight: 700; text-transform: uppercase;">Residential Address:</span>
                                <span id="dossierAddr" style="color: #334155;">-</span>
                            </div>
                            <div id="dossierNotesBox" style="display: none; background: #fffbeb; border: 1px solid #fef3c7; border-radius: 8px; padding: 0.75rem; margin-top: 0.5rem;">
                                <span style="display: block; font-size: 0.75rem; color: #b45309; font-weight: 800; text-transform: uppercase;">Buyer Special Instructions:</span>
                                <span id="dossierNotes" style="font-size: 0.82rem; color: #92400e;">-</span>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Uploaded Documents Inspection -->
                    <div style="border: 1px solid #e2e8f0; border-radius: 14px; padding: 1.25rem; background: #fff; display: flex; flex-direction: column; gap: 1rem;">
                        <h4 style="font-size: 0.95rem; font-weight: 800; color: #0f172a; margin-bottom: 0.25rem; display: flex; align-items: center; gap: 0.4rem;">
                            <i class="bi bi-file-earmark-check-fill" style="color: #2563eb;"></i> Uploaded Documents
                        </h4>

                        <!-- 1. NIC / Passport Document Preview Card -->
                        <div style="border: 1px solid #cbd5e1; border-radius: 10px; padding: 0.85rem; background: #f8fafc;">
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
                                <span style="font-size: 0.82rem; font-weight: 800; color: #1e293b;"><i class="bi bi-image"></i> Scanned Buyer NIC / Passport</span>
                                <span id="dossierNicStatus" style="font-size: 0.75rem; font-weight: 700; padding: 0.15rem 0.5rem; border-radius: 10px; background: #dcfce7; color: #15803d;">Available</span>
                            </div>
                            <div id="dossierNicImgContainer" style="text-align: center; margin-top: 0.5rem;">
                                <img id="dossierNicImg" src="" alt="Buyer NIC Scanned Copy" style="max-width: 100%; max-height: 160px; object-fit: contain; border-radius: 6px; border: 1px solid #e2e8f0; display: block; margin: 0 auto; cursor: pointer; transition: transform 0.2s;" title="Click to open image preview" onclick="previewDocument(this.src, 'Scanned Buyer NIC / Passport')">
                                <div style="display: flex; gap: 0.5rem; justify-content: center; margin-top: 0.5rem; flex-wrap: wrap;">
                                    <button type="button" onclick="previewDocument(currentDossierData.nicImg, 'Buyer NIC / Passport')" style="padding: 0.35rem 0.7rem; background: #2563eb; color: #fff; border: none; border-radius: 6px; font-size: 0.78rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.25rem;">
                                        <i class="bi bi-eye-fill"></i> Preview NIC Lightbox
                                    </button>
                                    <a id="dossierNicLink" href="#" target="_blank" style="padding: 0.35rem 0.7rem; background: #f1f5f9; border: 1px solid #cbd5e1; color: #1e293b; border-radius: 6px; font-size: 0.78rem; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 0.25rem;">
                                        <i class="bi bi-box-arrow-up-right"></i> Open New Tab
                                    </a>
                                </div>
                            </div>
                            <div id="dossierNoNic" style="display: none; padding: 1rem; text-align: center; color: #94a3b8; font-size: 0.82rem;">
                                <i class="bi bi-file-earmark-x" style="font-size: 1.5rem; display: block; margin-bottom: 0.25rem;"></i>
                                No NIC image attached
                            </div>
                        </div>

                        <!-- 2. Address Proof / Utility Bill Card -->
                        <div style="border: 1px solid #cbd5e1; border-radius: 10px; padding: 0.85rem; background: #f8fafc;">
                            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.5rem;">
                                <span style="font-size: 0.82rem; font-weight: 800; color: #1e293b;"><i class="bi bi-file-earmark-pdf"></i> Proof of Address Document</span>
                                <div style="display: flex; gap: 0.4rem; align-items: center;">
                                    <button type="button" id="dossierAddrProofPreviewBtn" onclick="previewDocument(currentDossierData.addrProof, 'Proof of Address / Utility Bill')" style="padding: 0.3rem 0.6rem; background: #2563eb; color: #fff; border: none; border-radius: 6px; font-size: 0.75rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.2rem;">
                                        <i class="bi bi-eye-fill"></i> Preview
                                    </button>
                                    <a id="dossierAddrProofLink" href="#" target="_blank" style="padding: 0.3rem 0.6rem; background: #f1f5f9; border: 1px solid #cbd5e1; color: #1e293b; border-radius: 6px; font-size: 0.75rem; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 0.2rem;">
                                        <i class="bi bi-box-arrow-up-right"></i> Open Tab
                                    </a>
                                </div>
                                <span id="dossierNoAddrProof" style="display: none; font-size: 0.75rem; color: #94a3b8;">Not provided</span>
                            </div>
                        </div>

                        <!-- 3. Payment Reference & Slip -->
                        <div style="border: 1px solid #cbd5e1; border-radius: 10px; padding: 0.85rem; background: #f8fafc;">
                            <div style="font-size: 0.82rem; font-weight: 800; color: #1e293b; margin-bottom: 0.25rem;"><i class="bi bi-receipt"></i> Bank Transaction Ref</div>
                            <div id="dossierPayRef" style="font-size: 0.85rem; color: #047857; font-family: monospace; font-weight: 700;">-</div>
                            <div style="display: flex; gap: 0.4rem; align-items: center; margin-top: 0.4rem;">
                                <button type="button" id="dossierPaySlipPreviewBtn" onclick="previewDocument(currentDossierData.paySlip, 'Bank Transfer Slip')" style="padding: 0.3rem 0.6rem; background: #059669; color: #fff; border: none; border-radius: 6px; font-size: 0.75rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.2rem;">
                                    <i class="bi bi-file-earmark-image"></i> Preview Slip
                                </button>
                                <a id="dossierPaySlipLink" href="#" target="_blank" style="padding: 0.3rem 0.6rem; background: #f1f5f9; border: 1px solid #cbd5e1; color: #1e293b; border-radius: 6px; font-size: 0.75rem; font-weight: 700; text-decoration: none; display: inline-flex; align-items: center; gap: 0.2rem;">
                                    <i class="bi bi-box-arrow-up-right"></i> Open Tab
                                </a>
                            </div>
                        </div>

                    </div>
                </div>

            </div>

            <!-- Modal Footer -->
            <div style="padding: 1.25rem 2rem; background: #f8fafc; border-top: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.75rem;">
                <button type="button" onclick="closeBuyerDossier()" style="padding: 0.65rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 8px; font-weight: 700; cursor: pointer; color: #475569;">
                    Close Dossier
                </button>
                <div style="display: flex; gap: 0.75rem;">
                    <button type="button" onclick="openRejectModalFromDossier()" style="padding: 0.65rem 1.25rem; background: #fee2e2; border: 1.5px solid #f87171; color: #991b1b; border-radius: 8px; font-weight: 700; cursor: pointer; display: flex; align-items: center; gap: 0.4rem;">
                        <i class="bi bi-x-circle-fill"></i> Reject Docs / Request Correction
                    </button>
                    <button type="button" class="btn-action" onclick="openDeedFromDossier()" style="padding: 0.65rem 1.5rem; font-size: 0.92rem;">
                        <i class="bi bi-pencil-square"></i> Proceed to Process Deed & Title
                    </button>
                </div>
            </div>

        </div>
    </div>

    <!-- MODAL 2: Process Deed, Notary Info, and Legal Milestones -->
    <div id="legalModal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6); z-index: 9999; align-items: center; justify-content: center; backdrop-filter: blur(4px);">
        <div style="background: #fff; width: 90%; max-width: 580px; border-radius: 16px; padding: 2rem; box-shadow: 0 20px 40px rgba(0,0,0,0.25); position: relative; max-height: 90vh; overflow-y: auto;">
            <button onclick="closeLegalModal()" style="position: absolute; top: 1.25rem; right: 1.25rem; background: none; border: none; font-size: 1.5rem; color: #64748b; cursor: pointer;">&times;</button>

            <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.25rem;">
                <div style="width: 44px; height: 44px; border-radius: 50%; background: rgba(11, 94, 40, 0.15); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                    <i class="bi bi-file-earmark-text-fill"></i>
                </div>
                <div>
                    <h3 style="margin: 0; font-size: 1.25rem; color: #0f172a;">Legal Conveyancing & Title Registration</h3>
                    <p style="margin: 0; color: #64748b; font-size: 0.85rem;">Update Deed Status, Notary Info, and Title Clearance</p>
                </div>
            </div>

            <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 1rem; margin-bottom: 1.25rem;">
                <div style="font-size: 0.9rem; margin-bottom: 0.35rem;">Land Plot: <strong id="modalPropTitle" style="color: var(--primary);">-</strong></div>
                <div style="font-size: 0.9rem; margin-bottom: 0.35rem;">Buyer Legal Name: <strong id="modalBuyerName" style="color: #0f172a;">-</strong></div>
                <div style="font-size: 0.9rem; margin-bottom: 0.35rem;">Buyer NIC / Passport: <strong id="modalBuyerNic" style="color: #059669;">-</strong></div>
                <div id="modalNicImgLink" style="font-size: 0.85rem; margin-top: 0.5rem; display: none;">
                    <a id="modalNicAnchor" href="#" target="_blank" style="color: #2563eb; font-weight: 700; text-decoration: underline;">
                        <i class="bi bi-image"></i> Click to Open / Inspect Uploaded Buyer NIC Document
                    </a>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/legal/update-status" method="POST">
                <input type="hidden" id="modalSaleId" name="saleId">

                <div style="margin-bottom: 1rem;">
                    <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Conveyancing & Legal Milestone Status</label>
                    <select id="modalLegalStatus" name="legalStatus" style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 0.95rem;" required>
                        <option value="PENDING_DOCS">1. Awaiting Buyer Documents (NIC / Address Proof)</option>
                        <option value="DOCS_SUBMITTED">2. Buyer Documents Submitted - Under Verification</option>
                        <option value="TITLE_CLEARED">3. Title Search 100% Cleared (Land Registry OK)</option>
                        <option value="DEED_DRAFTED">4. Deed of Transfer Drafted</option>
                        <option value="READY_TO_SIGN">5. Ready for Signing & Notary Execution</option>
                        <option value="OWNERSHIP_TRANSFERRED">6. Deed Registered - Ownership Transferred (Close Sale)</option>
                    </select>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                    <div>
                        <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Deed of Transfer Number</label>
                        <input type="text" id="modalDeedNumber" name="deedNumber" placeholder="e.g. DEED-2026/894" style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px;">
                    </div>
                    <div>
                        <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Attesting Notary Public Name</label>
                        <input type="text" id="modalNotaryName" name="notaryName" placeholder="e.g. Attorney K. S. Fernando, N.P." style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px;">
                    </div>
                </div>

                <div style="margin-bottom: 1.25rem;">
                    <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Legal Conveyancing Notes / Land Registry Folio</label>
                    <textarea id="modalLegalNotes" name="legalNotes" rows="2" placeholder="e.g. Title clear at Colombo Land Registry. Day Book Entry 459/2026." style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px;"></textarea>
                </div>

                <div style="margin-bottom: 1.5rem; background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 10px; padding: 1rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.4rem;">
                        <label style="font-weight: 700; font-size: 0.88rem; color: #166534; margin: 0; display: flex; align-items: center; gap: 0.35rem;">
                            <i class="bi bi-file-earmark-check-fill" style="color: #15803d;"></i> Official Ownership Transfer Certificate URL / Document
                        </label>
                        <button type="button" onclick="autoGenerateTransferCert()" style="background: #15803d; border: none; color: #fff; padding: 0.25rem 0.65rem; border-radius: 6px; font-size: 0.75rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.25rem; box-shadow: 0 2px 4px rgba(21, 128, 61, 0.2);">
                            <i class="bi bi-magic"></i> Auto-Generate Certificate #
                        </button>
                    </div>
                    <input type="text" id="modalTransferCert" name="transferCertificateUrl" placeholder="e.g. https://ceylonlands.lk/certificates/CERT-LK-2026-0001.pdf" style="width: 100%; padding: 0.75rem; border: 1px solid #86efac; border-radius: 8px; font-size: 0.9rem; background: #fff;">
                    <small style="color: #166534; font-size: 0.75rem; display: block; margin-top: 0.35rem;">
                        Attach the official scanned Deed / Transfer Certificate link. The buyer will be able to inspect, download, and print this certificate from their portal.
                    </small>
                </div>

                <div style="display: flex; gap: 0.75rem; justify-content: flex-end;">
                    <button type="button" onclick="closeLegalModal()" style="padding: 0.75rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 8px; font-weight: 700; cursor: pointer; color: #475569;">Cancel</button>
                    <button type="submit" class="btn-action" style="padding: 0.75rem 1.5rem; font-size: 0.95rem;">
                        <i class="bi bi-check2-circle"></i> Save Legal Status
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- MODAL 3: Reject Customer Documents / Request Correction -->
    <div id="rejectDocsModal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.65); z-index: 10000; align-items: center; justify-content: center; backdrop-filter: blur(4px); padding: 1rem;">
        <div style="background: #fff; width: 100%; max-width: 540px; border-radius: 16px; padding: 2rem; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.3); position: relative;">
            <button onclick="closeRejectModal()" style="position: absolute; top: 1.25rem; right: 1.25rem; background: none; border: none; font-size: 1.5rem; color: #64748b; cursor: pointer;">&times;</button>

            <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.25rem;">
                <div style="width: 44px; height: 44px; border-radius: 50%; background: #fee2e2; color: #dc2626; display: flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                    <i class="bi bi-shield-x"></i>
                </div>
                <div>
                    <h3 style="margin: 0; font-size: 1.25rem; color: #991b1b;">Document Issue & Correction Request</h3>
                    <p style="margin: 0; color: #64748b; font-size: 0.85rem;">Send rejection notice & feedback to customer for re-submission</p>
                </div>
            </div>

            <div style="background: #fef2f2; border: 1px solid #fecaca; border-radius: 10px; padding: 0.85rem 1rem; margin-bottom: 1.25rem; font-size: 0.88rem; color: #991b1b;">
                <div>Land Plot: <strong id="rejectPropTitle">-</strong></div>
                <div>Buyer: <strong id="rejectBuyerName">-</strong></div>
            </div>

            <form action="${pageContext.request.contextPath}/legal/reject-docs" method="POST">
                <input type="hidden" id="rejectSaleId" name="saleId">

                <div style="margin-bottom: 1rem;">
                    <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">
                        Correction Feedback Message (Customer will see this):
                    </label>
                    <textarea id="rejectionMessage" name="rejectionMessage" rows="3" style="width: 100%; border: 1.5px solid #cbd5e1; border-radius: 8px; padding: 0.75rem; font-size: 0.9rem;" required placeholder="e.g. NIC image is blurry. Please upload a clear photo of both front and back sides."></textarea>
                </div>

                <!-- Quick reason chips -->
                <div style="margin-bottom: 1.5rem;">
                    <span style="font-size: 0.75rem; font-weight: 700; color: #64748b; text-transform: uppercase; display: block; margin-bottom: 0.4rem;">Quick Issue Templates:</span>
                    <div style="display: flex; flex-wrap: wrap; gap: 0.35rem;">
                        <button type="button" onclick="setQuickRejectReason('NIC image is blurry and unreadable. Please upload a clear photo of front and back sides.')" style="background: #f1f5f9; border: 1px solid #cbd5e1; padding: 0.25rem 0.6rem; border-radius: 15px; font-size: 0.75rem; cursor: pointer; color: #334155;">📷 Blurry NIC</button>
                        <button type="button" onclick="setQuickRejectReason('Buyer legal name provided does not match National Identity Card (NIC). Please correct legal name.')" style="background: #f1f5f9; border: 1px solid #cbd5e1; padding: 0.25rem 0.6rem; border-radius: 15px; font-size: 0.75rem; cursor: pointer; color: #334155;">👤 Name Mismatch</button>
                        <button type="button" onclick="setQuickRejectReason('Proof of address document is expired or invalid. Please attach a recent utility bill.')" style="background: #f1f5f9; border: 1px solid #cbd5e1; padding: 0.25rem 0.6rem; border-radius: 15px; font-size: 0.75rem; cursor: pointer; color: #334155;">📄 Invalid Address Proof</button>
                        <button type="button" onclick="setQuickRejectReason('Joint ownership documents or co-buyer identity details are missing. Please re-upload.')" style="background: #f1f5f9; border: 1px solid #cbd5e1; padding: 0.25rem 0.6rem; border-radius: 15px; font-size: 0.75rem; cursor: pointer; color: #334155;">👥 Co-Owner Docs Missing</button>
                    </div>
                </div>

                <div style="display: flex; gap: 0.75rem; justify-content: flex-end;">
                    <button type="button" onclick="closeRejectModal()" style="padding: 0.65rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 8px; font-weight: 700; cursor: pointer; color: #475569;">Cancel</button>
                    <button type="submit" style="padding: 0.65rem 1.5rem; background: #dc2626; border: none; color: #fff; border-radius: 8px; font-weight: 700; font-size: 0.92rem; cursor: pointer; display: flex; align-items: center; gap: 0.4rem; box-shadow: 0 4px 10px rgba(220, 38, 38, 0.3);">
                        <i class="bi bi-send-fill"></i> Send Correction Notice to Customer
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Universal High-Resolution In-App Document Lightbox Preview Modal -->
    <div id="universalDocViewerModal" style="display: none; position: fixed; inset: 0; background: rgba(15, 23, 42, 0.88); z-index: 11000; align-items: center; justify-content: center; backdrop-filter: blur(8px); padding: 1.5rem;">
        <div style="background: #1e293b; width: 100%; max-width: 920px; border-radius: 20px; box-shadow: 0 25px 60px rgba(0,0,0,0.6); overflow: hidden; display: flex; flex-direction: column; max-height: 94vh; border: 1px solid rgba(255,255,255,0.15);">

            <!-- Modal Header -->
            <div style="padding: 1rem 1.5rem; background: #0f172a; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid rgba(255,255,255,0.1);">
                <div style="display: flex; align-items: center; gap: 0.65rem;">
                    <div style="width: 36px; height: 36px; border-radius: 50%; background: rgba(56, 189, 248, 0.15); color: #38bdf8; display: flex; align-items: center; justify-content: center; font-size: 1.1rem;">
                        <i class="bi bi-file-earmark-image-fill"></i>
                    </div>
                    <div>
                        <h4 id="docViewerTitle" style="margin: 0; font-weight: 800; font-size: 1.05rem; color: #f8fafc;">Document Preview</h4>
                        <span style="font-size: 0.78rem; color: #94a3b8;">Official Verification Inspection</span>
                    </div>
                </div>
                <div style="display: flex; align-items: center; gap: 0.75rem;">
                    <a id="docViewerExternalLink" href="#" target="_blank" style="background: rgba(255,255,255,0.1); color: #38bdf8; text-decoration: none; padding: 0.45rem 0.9rem; border-radius: 8px; font-size: 0.82rem; font-weight: 700; display: inline-flex; align-items: center; gap: 0.35rem; border: 1px solid rgba(56, 189, 248, 0.3);">
                        <i class="bi bi-box-arrow-up-right"></i> Open Full Resolution in New Tab
                    </a>
                    <button type="button" onclick="closeDocViewer()" style="background: rgba(255,255,255,0.15); border: none; font-size: 1.5rem; color: #fff; width: 36px; height: 36px; border-radius: 50%; cursor: pointer; display: flex; align-items: center; justify-content: center;">&times;</button>
                </div>
            </div>

            <!-- Modal Content (Preview Area) -->
            <div style="padding: 1.5rem; background: #0b1329; overflow-y: auto; display: flex; align-items: center; justify-content: center; flex: 1; min-height: 380px; position: relative;">
                <img id="docViewerImg" src="" alt="Document Copy" style="display: none; max-width: 100%; max-height: 72vh; object-fit: contain; border-radius: 10px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);">
                <iframe id="docViewerFrame" src="" style="display: none; width: 100%; height: 72vh; border: none; border-radius: 10px; background: #fff;"></iframe>
                <div id="docViewerFallback" style="display: none; text-align: center; color: #94a3b8; padding: 2.5rem 1.5rem;">
                    <i class="bi bi-file-earmark-arrow-down-fill" style="font-size: 3.5rem; color: #38bdf8; display: block; margin-bottom: 0.75rem;"></i>
                    <p style="font-size: 1.05rem; color: #f8fafc; margin-bottom: 0.5rem; font-weight: 700;">Document Link Available</p>
                    <p style="font-size: 0.85rem; color: #94a3b8; margin-bottom: 1.25rem;">Direct embedded display is restricted for this document format or security policy.</p>
                    <a id="docViewerDownloadBtn" href="#" target="_blank" style="background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%); color: #fff; text-decoration: none; padding: 0.65rem 1.5rem; border-radius: 10px; font-weight: 700; font-size: 0.92rem; display: inline-flex; align-items: center; gap: 0.4rem; box-shadow: 0 4px 14px rgba(2, 132, 199, 0.4);">
                        <i class="bi bi-box-arrow-up-right"></i> Open / Download Full Document
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        var currentDossierData = {};

        function openBuyerDossierById(saleId) {
            var dataEl = document.getElementById('legal-case-data-' + saleId);
            if (!dataEl) {
                console.error('Case data container not found for ID: ' + saleId);
                return;
            }
            var id = dataEl.querySelector('.lcd-id') ? dataEl.querySelector('.lcd-id').innerText : saleId;
            var title = dataEl.querySelector('.lcd-title') ? dataEl.querySelector('.lcd-title').innerText : '';
            var location = dataEl.querySelector('.lcd-location') ? dataEl.querySelector('.lcd-location').innerText : '';
            var size = dataEl.querySelector('.lcd-size') ? dataEl.querySelector('.lcd-size').innerText : '';
            var buyer = dataEl.querySelector('.lcd-buyer') ? dataEl.querySelector('.lcd-buyer').innerText : '';
            var custName = dataEl.querySelector('.lcd-cust-name') ? dataEl.querySelector('.lcd-cust-name').innerText : '';
            var phone = dataEl.querySelector('.lcd-phone') ? dataEl.querySelector('.lcd-phone').innerText : '';
            var email = dataEl.querySelector('.lcd-email') ? dataEl.querySelector('.lcd-email').innerText : '';
            var addr = dataEl.querySelector('.lcd-addr') ? dataEl.querySelector('.lcd-addr').innerText : '';
            var nic = dataEl.querySelector('.lcd-nic') ? dataEl.querySelector('.lcd-nic').innerText : '';
            var nicImg = dataEl.querySelector('.lcd-nic-img') ? dataEl.querySelector('.lcd-nic-img').innerText.trim() : '';
            var addrProof = dataEl.querySelector('.lcd-addr-proof') ? dataEl.querySelector('.lcd-addr-proof').innerText.trim() : '';
            var payRef = dataEl.querySelector('.lcd-pay-ref') ? dataEl.querySelector('.lcd-pay-ref').innerText.trim() : '';
            var paySlip = dataEl.querySelector('.lcd-pay-slip') ? dataEl.querySelector('.lcd-pay-slip').innerText.trim() : '';
            var price = dataEl.querySelector('.lcd-price') ? dataEl.querySelector('.lcd-price').innerText : '0';
            var adv = dataEl.querySelector('.lcd-adv') ? dataEl.querySelector('.lcd-adv').innerText : '0';
            var status = dataEl.querySelector('.lcd-status') ? dataEl.querySelector('.lcd-status').innerText : '';
            var deed = dataEl.querySelector('.lcd-deed') ? dataEl.querySelector('.lcd-deed').innerText : '';
            var notary = dataEl.querySelector('.lcd-notary') ? dataEl.querySelector('.lcd-notary').innerText : '';
            var notes = dataEl.querySelector('.lcd-notes') ? dataEl.querySelector('.lcd-notes').innerText : '';
            var legalNotes = dataEl.querySelector('.lcd-legal-notes') ? dataEl.querySelector('.lcd-legal-notes').innerText : '';
            var certUrl = dataEl.querySelector('.lcd-cert') ? dataEl.querySelector('.lcd-cert').innerText.trim() : '';

            currentDossierData = {
                id: id, title: title, location: location, size: size,
                buyer: buyer, custName: custName, phone: phone, email: email,
                addr: addr, nic: nic, nicImg: nicImg, addrProof: addrProof,
                payRef: payRef, paySlip: paySlip, price: price, adv: adv,
                status: status, deed: deed, notary: notary, notes: notes,
                legalNotes: legalNotes, certUrl: certUrl
            };

            var caseIdEl = document.getElementById('dossierCaseId'); if (caseIdEl) caseIdEl.innerText = id;
            var propTitleEl = document.getElementById('dossierPropTitle'); if (propTitleEl) propTitleEl.innerText = title;
            var propLocEl = document.getElementById('dossierPropLocation'); if (propLocEl) propLocEl.innerHTML = '<i class="bi bi-geo-alt-fill"></i> ' + location + ' &bull; ' + size + ' Perches';
            var priceEl = document.getElementById('dossierPrice'); if (priceEl) priceEl.innerText = 'Rs. ' + Number(price || 0).toLocaleString();
            var advEl = document.getElementById('dossierAdvance'); if (advEl) advEl.innerText = 'Advance: Rs. ' + Number(adv || 0).toLocaleString();

            var buyerNameEl = document.getElementById('dossierLegalBuyerName') || document.getElementById('dossierBuyerName');
            if (buyerNameEl) buyerNameEl.innerText = buyer || custName || 'Not specified';

            var buyerNicEl = document.getElementById('dossierBuyerNic'); if (buyerNicEl) buyerNicEl.innerText = nic || 'Not yet submitted';
            var phoneEl = document.getElementById('dossierPhone'); if (phoneEl) phoneEl.innerText = phone || '-';
            var emailEl = document.getElementById('dossierEmail'); if (emailEl) emailEl.innerText = email || '-';
            var addrEl = document.getElementById('dossierAddr'); if (addrEl) addrEl.innerText = addr || 'Not specified';

            if (notes && notes.trim() !== '') {
                var notesEl = document.getElementById('dossierNotes'); if (notesEl) notesEl.innerText = notes;
                var notesBox = document.getElementById('dossierNotesBox'); if (notesBox) notesBox.style.display = 'block';
            } else {
                var notesBox = document.getElementById('dossierNotesBox'); if (notesBox) notesBox.style.display = 'none';
            }

            // NIC Preview
            if (nicImg && nicImg.trim() !== '') {
                var imgEl = document.getElementById('dossierNicImg'); if (imgEl) imgEl.src = nicImg;
                var linkEl = document.getElementById('dossierNicLink'); if (linkEl) linkEl.href = nicImg;
                var containerEl = document.getElementById('dossierNicImgContainer'); if (containerEl) containerEl.style.display = 'block';
                var noNicEl = document.getElementById('dossierNoNic'); if (noNicEl) noNicEl.style.display = 'none';
                var nicStatusEl = document.getElementById('dossierNicStatus');
                if (nicStatusEl) {
                    nicStatusEl.innerText = 'Uploaded';
                    nicStatusEl.style.background = '#dcfce7';
                    nicStatusEl.style.color = '#15803d';
                }
            } else {
                var containerEl = document.getElementById('dossierNicImgContainer'); if (containerEl) containerEl.style.display = 'none';
                var noNicEl = document.getElementById('dossierNoNic'); if (noNicEl) noNicEl.style.display = 'block';
                var nicStatusEl = document.getElementById('dossierNicStatus');
                if (nicStatusEl) {
                    nicStatusEl.innerText = 'Missing';
                    nicStatusEl.style.background = '#fee2e2';
                    nicStatusEl.style.color = '#b91c1c';
                }
            }

            // Address proof
            var addrLinkEl = document.getElementById('dossierAddrProofLink');
            var addrPreviewBtn = document.getElementById('dossierAddrProofPreviewBtn');
            var noAddrEl = document.getElementById('dossierNoAddrProof');
            if (addrProof && addrProof.trim() !== '') {
                if (addrLinkEl) { addrLinkEl.href = addrProof; addrLinkEl.style.display = 'inline-flex'; }
                if (addrPreviewBtn) addrPreviewBtn.style.display = 'inline-flex';
                if (noAddrEl) noAddrEl.style.display = 'none';
            } else {
                if (addrLinkEl) addrLinkEl.style.display = 'none';
                if (addrPreviewBtn) addrPreviewBtn.style.display = 'none';
                if (noAddrEl) noAddrEl.style.display = 'inline';
            }

            // Payment reference & slip
            var payRefEl = document.getElementById('dossierPayRef'); if (payRefEl) payRefEl.innerText = payRef || 'VERIFIED';
            var paySlipLinkEl = document.getElementById('dossierPaySlipLink');
            var paySlipPreviewBtn = document.getElementById('dossierPaySlipPreviewBtn');
            if (paySlip && paySlip.trim() !== '') {
                if (paySlipLinkEl) { paySlipLinkEl.href = paySlip; paySlipLinkEl.style.display = 'inline-flex'; }
                if (paySlipPreviewBtn) paySlipPreviewBtn.style.display = 'inline-flex';
            } else {
                if (paySlipLinkEl) paySlipLinkEl.style.display = 'none';
                if (paySlipPreviewBtn) paySlipPreviewBtn.style.display = 'none';
            }

            var dossierModal = document.getElementById('buyerDossierModal');
            if (dossierModal) dossierModal.style.display = 'flex';
        }

        function openBuyerDossier(btn) {
            var saleId = btn.getAttribute('data-id');
            if (saleId) {
                openBuyerDossierById(saleId);
            }
        }

        function closeBuyerDossier() {
            var dossierModal = document.getElementById('buyerDossierModal');
            if (dossierModal) dossierModal.style.display = 'none';
        }

        function autoGenerateTransferCert() {
            var saleId = document.getElementById('modalSaleId').value || '1';
            var deedNum = document.getElementById('modalDeedNumber').value || ('DEED-2026/' + saleId);
            var certNo = 'CERT-LK-' + new Date().getFullYear() + '-' + String(saleId).padStart(4, '0');
            document.getElementById('modalTransferCert').value = 'https://ceylonlands.lk/certificates/' + certNo + '.pdf';
            if (!document.getElementById('modalDeedNumber').value) {
                document.getElementById('modalDeedNumber').value = deedNum;
            }
            if (!document.getElementById('modalNotaryName').value) {
                document.getElementById('modalNotaryName').value = 'Attorney K. S. Fernando, N.P.';
            }
            if (!document.getElementById('modalLegalNotes').value) {
                document.getElementById('modalLegalNotes').value = 'Deed registered at Colombo Land Registry. Day Book Entry 459/' + new Date().getFullYear() + '. Title 100% cleared and ownership officially transferred to buyer.';
            }
        }

        function openDeedFromDossier() {
            closeBuyerDossier();
            openLegalModal(
                currentDossierData.id,
                currentDossierData.title,
                currentDossierData.buyer,
                currentDossierData.nic,
                currentDossierData.status,
                currentDossierData.deed,
                currentDossierData.notary,
                currentDossierData.nicImg,
                currentDossierData.legalNotes,
                currentDossierData.certUrl
            );
        }

        function openRejectModalFromDossier() {
            closeBuyerDossier();
            openRejectModal(currentDossierData.id, currentDossierData.title, currentDossierData.buyer);
        }

        function openRejectModal(saleId, propTitle, buyerName) {
            document.getElementById('rejectSaleId').value = saleId;
            document.getElementById('rejectPropTitle').innerText = propTitle;
            document.getElementById('rejectBuyerName').innerText = buyerName;
            document.getElementById('rejectionMessage').value = '';
            document.getElementById('rejectDocsModal').style.display = 'flex';
        }

        function closeRejectModal() {
            document.getElementById('rejectDocsModal').style.display = 'none';
        }

        function setQuickRejectReason(text) {
            document.getElementById('rejectionMessage').value = text;
        }

        function openLegalModalFromBtn(btn) {
            var saleId = btn.getAttribute('data-id');
            var dataEl = document.getElementById('legal-case-data-' + saleId);
            if (dataEl) {
                var propTitle = dataEl.querySelector('.lcd-title') ? dataEl.querySelector('.lcd-title').innerText : '';
                var buyerName = dataEl.querySelector('.lcd-buyer') ? dataEl.querySelector('.lcd-buyer').innerText : '';
                var buyerNic = dataEl.querySelector('.lcd-nic') ? dataEl.querySelector('.lcd-nic').innerText : '';
                var legalStatus = dataEl.querySelector('.lcd-status') ? dataEl.querySelector('.lcd-status').innerText : '';
                var deedNum = dataEl.querySelector('.lcd-deed') ? dataEl.querySelector('.lcd-deed').innerText : '';
                var notaryName = dataEl.querySelector('.lcd-notary') ? dataEl.querySelector('.lcd-notary').innerText : '';
                var nicImg = dataEl.querySelector('.lcd-nic-img') ? dataEl.querySelector('.lcd-nic-img').innerText.trim() : '';
                var legalNotes = dataEl.querySelector('.lcd-legal-notes') ? dataEl.querySelector('.lcd-legal-notes').innerText.trim() : '';
                var certUrl = dataEl.querySelector('.lcd-cert') ? dataEl.querySelector('.lcd-cert').innerText.trim() : '';
                openLegalModal(saleId, propTitle, buyerName, buyerNic, legalStatus, deedNum, notaryName, nicImg, legalNotes, certUrl);
            } else {
                var propTitle = btn.getAttribute('data-title');
                var buyerName = btn.getAttribute('data-buyer');
                var buyerNic = btn.getAttribute('data-nic');
                var legalStatus = btn.getAttribute('data-status');
                var deedNum = btn.getAttribute('data-deed');
                var notaryName = btn.getAttribute('data-notary');
                var nicImg = btn.getAttribute('data-nic-img');
                openLegalModal(saleId, propTitle, buyerName, buyerNic, legalStatus, deedNum, notaryName, nicImg, '', '');
            }
        }

        function openLegalModal(saleId, propTitle, buyerName, buyerNic, legalStatus, deedNum, notaryName, nicImg, legalNotes, certUrl) {
            document.getElementById('modalSaleId').value = saleId;
            document.getElementById('modalPropTitle').innerText = propTitle;
            document.getElementById('modalBuyerName').innerText = buyerName;
            document.getElementById('modalBuyerNic').innerText = buyerNic ? buyerNic : 'Not yet uploaded';

            if (legalStatus) {
                document.getElementById('modalLegalStatus').value = legalStatus;
            }
            document.getElementById('modalDeedNumber').value = deedNum || '';
            document.getElementById('modalNotaryName').value = notaryName || '';
            document.getElementById('modalLegalNotes').value = legalNotes || '';
            document.getElementById('modalTransferCert').value = certUrl || '';

            var linkDiv = document.getElementById('modalNicImgLink');
            var anchor = document.getElementById('modalNicAnchor');
            if (nicImg && nicImg.trim() !== '') {
                anchor.href = nicImg;
                linkDiv.style.display = 'block';
            } else {
                linkDiv.style.display = 'none';
            }

            document.getElementById('legalModal').style.display = 'flex';
        }

        function closeLegalModal() {
            document.getElementById('legalModal').style.display = 'none';
        }

        function previewDocument(url, title) {
            if (!url || url.trim() === '') {
                alert('No document link or image attached.');
                return;
            }
            var titleEl = document.getElementById('docViewerTitle');
            if (titleEl) titleEl.innerText = title || 'Document Inspection Preview';

            var extLink = document.getElementById('docViewerExternalLink');
            if (extLink) extLink.href = url;

            var downloadBtn = document.getElementById('docViewerDownloadBtn');
            if (downloadBtn) downloadBtn.href = url;

            var imgEl = document.getElementById('docViewerImg');
            var frameEl = document.getElementById('docViewerFrame');
            var fallbackEl = document.getElementById('docViewerFallback');

            var cleanUrl = url.trim().toLowerCase();
            var isImage = cleanUrl.match(/\.(jpeg|jpg|png|gif|webp|bmp|svg)($|\?)/i) || cleanUrl.startsWith('data:image/');

            if (isImage) {
                if (imgEl) { imgEl.src = url; imgEl.style.display = 'block'; }
                if (frameEl) { frameEl.src = ''; frameEl.style.display = 'none'; }
                if (fallbackEl) fallbackEl.style.display = 'none';
            } else if (cleanUrl.match(/\.pdf($|\?)/i)) {
                if (imgEl) { imgEl.src = ''; imgEl.style.display = 'none'; }
                if (frameEl) { frameEl.src = url; frameEl.style.display = 'block'; }
                if (fallbackEl) fallbackEl.style.display = 'none';
            } else {
                if (imgEl) { imgEl.src = ''; imgEl.style.display = 'none'; }
                if (frameEl) { frameEl.src = ''; frameEl.style.display = 'none'; }
                if (fallbackEl) fallbackEl.style.display = 'block';
            }

            var viewerModal = document.getElementById('universalDocViewerModal');
            if (viewerModal) viewerModal.style.display = 'flex';
        }

        function closeDocViewer() {
            var viewerModal = document.getElementById('universalDocViewerModal');
            if (viewerModal) viewerModal.style.display = 'none';
            var imgEl = document.getElementById('docViewerImg'); if (imgEl) imgEl.src = '';
            var frameEl = document.getElementById('docViewerFrame'); if (frameEl) frameEl.src = '';
        }

        document.addEventListener('DOMContentLoaded', function() {
            var statusSelect = document.getElementById('modalLegalStatus');
            if (statusSelect) {
                statusSelect.addEventListener('change', function() {
                    if (this.value === 'OWNERSHIP_TRANSFERRED') {
                        if (!document.getElementById('modalTransferCert').value) {
                            autoGenerateTransferCert();
                        }
                    }
                });
            }
        });
    </script>

</body>
</html>