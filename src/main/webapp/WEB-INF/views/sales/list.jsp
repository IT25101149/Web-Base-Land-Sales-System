<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales & Reservations - Ceylon Lands</title>
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
            --success: #10b981;
            --warning: #f59e0b;
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

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
            text-transform: uppercase;
        }

        .status-badge.pending_reservation { background: rgba(245, 158, 11, 0.1); color: var(--warning); }
        .status-badge.completed { background: rgba(16, 185, 129, 0.1); color: var(--success); }

        .btn-confirm {
            background-color: var(--success);
            color: white;
            border: none;
            padding: 0.4rem 0.85rem;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            font-size: 0.85rem;
            display: inline-flex;
            .notif-card {
                background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                border: 1px solid #f59e0b;
                border-radius: 12px;
                padding: 1.25rem 1.75rem;
                margin-bottom: 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 1.5rem;
                box-shadow: 0 4px 12px rgba(245, 158, 11, 0.15);
            }

            .notif-left {
                display: flex;
                align-items: center;
                gap: 1.25rem;
            }

            .notif-icon {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                background: #f59e0b;
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.4rem;
                flex-shrink: 0;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(245, 158, 11, 0.7); }
                70% { transform: scale(1.05); box-shadow: 0 0 0 10px rgba(245, 158, 11, 0); }
                100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(245, 158, 11, 0); }
            }

            .alert-banner-success {
                background-color: #ecfdf5;
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

            .btn-approve {
                background: linear-gradient(135deg, #059669 0%, #047857 100%);
                color: #ffffff;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-weight: 700;
                text-decoration: none;
                cursor: pointer;
                font-size: 0.85rem;
                display: inline-flex;
                align-items: center;
                gap: 0.35rem;
                transition: all 0.2s ease;
                box-shadow: 0 2px 6px rgba(5, 150, 105, 0.25);
            }

            .btn-approve:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(5, 150, 105, 0.35);
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
        <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>
        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
            <li><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>
        </c:if>
        <li class="active"><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
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
            <h1>Sales & Reservation Management</h1>
            <p style="color: var(--text-muted); font-size: 0.9rem;">Review customer reservation inquiries, record property bookings, and track deed transfers.</p>
        </div>
        <div style="display: flex; align-items: center; gap: 1rem;">
            <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
            <a href="${pageContext.request.contextPath}/sales/reserve" class="btn-primary">
                <i class="bi bi-journal-check"></i> Book / Reserve Plot
            </a>
        </div>
    </header>

    <!-- Flash messages -->
    <c:if test="${not empty reservationSuccess}">
        <div class="alert-banner-success">
            <i class="bi bi-check-circle-fill" style="font-size: 1.2rem; color: #10b981;"></i>
            <span>${reservationSuccess}</span>
        </div>
    </c:if>
    <c:if test="${not empty reservationError}">
        <div class="alert-banner-error" style="background: #fee2e2; border: 1.5px solid #f87171; color: #991b1b; padding: 1rem 1.25rem; border-radius: 12px; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; font-weight: 600;">
            <i class="bi bi-exclamation-triangle-fill" style="font-size: 1.2rem; color: #ef4444;"></i>
            <span>${reservationError}</span>
        </div>
    </c:if>

    <!-- Sales Manager Notification Banner for Pending Inquiries -->
    <c:set var="pendingActionCount" value="0"/>
    <c:forEach var="item" items="${inquiries}">
        <c:if test="${item.status == 'PENDING' or item.status == 'PAYMENT_SUBMITTED'}">
            <c:set var="pendingActionCount" value="${pendingActionCount + 1}"/>
        </c:if>
    </c:forEach>

    <c:if test="${pendingActionCount > 0}">
        <div class="notif-card">
            <div class="notif-left">
                <div class="notif-icon">
                    <i class="bi bi-bell-fill"></i>
                </div>
                <div>
                    <h4 style="margin: 0; color: #92400e; font-size: 1.1rem; font-weight: 800;">
                            ${pendingActionCount} Customer Reservation Request(s) Require Your Action!
                    </h4>
                    <p style="margin: 0.25rem 0 0 0; color: #78350f; font-size: 0.9rem;">
                        Registered customers have submitted requests for land plot reservations or uploaded payment slips. Review below to approve and dispatch bank info or forward to legal.
                    </p>
                </div>
            </div>
        </div>
    </c:if>

    <!-- 1. Customer Online Reservation Requests Section -->
    <div style="margin-bottom: 2.5rem;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
            <h2 style="font-size: 1.25rem; font-weight: 800; color: var(--text-dark); margin: 0; display: flex; align-items: center; gap: 0.5rem;">
                <i class="bi bi-inbox-fill" style="color: var(--primary);"></i> Online Land Reservation Requests (Customer Inquiries)
            </h2>
            <span style="background: #e2e8f0; color: #475569; padding: 0.35rem 0.85rem; border-radius: 20px; font-size: 0.85rem; font-weight: 700;">
                    ${inquiries.size()} Total Inquiries
                </span>
        </div>

        <div class="table-card">
            <table>
                <thead>
                <tr>
                    <th>Inquiry Date</th>
                    <th>Customer Details</th>
                    <th>Requested Land Plot</th>
                    <th>Status / State</th>
                    <th>Contact & Message</th>
                    <th>Sales Manager Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="inq" items="${inquiries}">
                    <tr>
                        <td style="font-size: 0.88rem; color: var(--text-muted);">${inq.inquiryDate}</td>
                        <td>
                            <strong style="color: var(--text-dark); font-size: 0.95rem;">${inq.customerName}</strong>
                            <div style="font-size: 0.78rem; color: var(--text-muted);">${inq.email}</div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${inq.property != null}">
                                    <span style="font-weight: 700; color: var(--primary);">${inq.property.title}</span>
                                    <div style="font-size: 0.82rem; color: var(--text-muted);"><i class="bi bi-geo-alt-fill"></i> ${inq.property.location} (Rs. <fmt:formatNumber value="${inq.property.price}" type="number" maxFractionDigits="2"/>)</div>
                                </c:when>
                                <c:otherwise>
                                            <span style="background: #f1f5f9; color: #64748b; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 600; font-size: 0.82rem;">
                                                <i class="bi bi-chat-dots-fill"></i> General Inquiry
                                            </span>
                                    <div style="font-size: 0.78rem; color: #94a3b8; margin-top: 0.2rem;">Direct Contact Form</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${inq.status == 'COMPLETED'}">
                                            <span class="status-pill" style="background: #ecfdf5; color: #047857; border: 1.5px solid #6ee7b7; font-weight: 700;">
                                                <i class="bi bi-award-fill"></i> Sale Completed
                                            </span>
                                    <div style="font-size: 0.75rem; color: #065f46; margin-top: 0.25rem; font-weight: 700;">Deed Transferred & Registered</div>
                                </c:when>
                                <c:when test="${inq.status == 'FULL_APPROVED' || inq.status == 'PAYMENT_VERIFIED'}">
                                            <span class="status-pill" style="background: #dcfce7; color: #15803d; border: 1.5px solid #86efac; font-weight: 700;">
                                                <i class="bi bi-patch-check-fill"></i> Payment Confirmed
                                            </span>
                                    <div style="font-size: 0.75rem; color: #166534; margin-top: 0.25rem; font-weight: 600;">In Legal Conveyancing</div>
                                </c:when>
                                <c:when test="${inq.status == 'PAYMENT_SUBMITTED'}">
                                            <span class="status-pill" style="background: #fef9c3; color: #854d0e; border: 1.5px solid #fde047; font-weight: 700;">
                                                <i class="bi bi-receipt-cutoff"></i> Slip Submitted
                                            </span>
                                    <div style="font-size: 0.75rem; color: #b45309; margin-top: 0.25rem; font-weight: 800;">Needs Payment Approval!</div>
                                </c:when>
                                <c:when test="${inq.status == 'PENDING_PAYMENT'}">
                                            <span class="status-pill" style="background: #e0f2fe; color: #0369a1; border: 1.5px solid #7dd3fc; font-weight: 700;">
                                                <i class="bi bi-calendar2-check-fill"></i> Reservation Confirmed
                                            </span>
                                    <div style="font-size: 0.75rem; color: #0284c7; margin-top: 0.25rem; font-weight: 600;">Awaiting Advance Deposit</div>
                                </c:when>
                                <c:when test="${inq.status == 'CANCELLED'}">
                                            <span class="status-pill" style="background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; font-weight: 600;">
                                                <i class="bi bi-x-circle-fill"></i> Cancelled
                                            </span>
                                    <div style="font-size: 0.75rem; color: #b91c1c; margin-top: 0.25rem;">Plot Restored to Available</div>
                                </c:when>
                                <c:otherwise>
                                            <span class="status-pill" style="background: #fef3c7; color: #b45309; border: 1.5px solid #fcd34d; font-weight: 700;">
                                                <i class="bi bi-clock-history"></i> Pending Sales Review
                                            </span>
                                    <div style="font-size: 0.75rem; color: #d97706; margin-top: 0.25rem; font-weight: 600;">New Customer Request</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="font-size: 0.85rem; color: #334155; max-width: 200px;">
                            <div style="font-weight: 600; color: #059669; margin-bottom: 0.2rem;"><i class="bi bi-telephone-fill"></i> ${inq.phone}</div>
                            <div style="font-style: italic; color: #64748b; font-size: 0.8rem;">"${inq.message}"</div>
                        </td>
                        <td>
                            <div style="display: flex; flex-direction: column; gap: 0.4rem;">
                                <c:choose>
                                    <c:when test="${inq.status == 'COMPLETED'}">
                                        <div style="background: #ecfdf5; border: 1.5px solid #a7f3d0; padding: 0.5rem 0.85rem; border-radius: 8px; text-align: center;">
                                                    <span style="color: #065f46; font-weight: 800; font-size: 0.82rem; display: flex; align-items: center; justify-content: center; gap: 0.35rem;">
                                                        <i class="bi bi-check2-all" style="color: #059669; font-size: 1.1rem;"></i> Closed & Sold
                                                    </span>
                                            <div style="font-size: 0.72rem; color: #047857; margin-top: 0.15rem; font-weight: 600;">Ownership Officially Transferred</div>
                                        </div>
                                    </c:when>
                                    <c:when test="${inq.status == 'FULL_APPROVED' || inq.status == 'PAYMENT_VERIFIED'}">
                                        <div style="background: #f0fdf4; border: 1.5px solid #bbf7d0; padding: 0.5rem 0.85rem; border-radius: 8px; text-align: center;">
                                                    <span style="color: #15803d; font-weight: 800; font-size: 0.82rem; display: flex; align-items: center; justify-content: center; gap: 0.35rem;">
                                                        <i class="bi bi-patch-check-fill" style="color: #10b981;"></i> Payment Confirmed & Unlocked
                                                    </span>
                                            <div style="font-size: 0.72rem; color: #166534; margin-top: 0.15rem; font-weight: 600;">Handed over to Legal Department</div>
                                            <a href="${pageContext.request.contextPath}/legal" style="font-size: 0.72rem; color: #0284c7; text-decoration: underline; display: inline-block; margin-top: 0.25rem;">
                                                <i class="bi bi-journal-text"></i> View Legal Docket
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:when test="${inq.status == 'PAYMENT_SUBMITTED'}">
                                        <div style="display: flex; gap: 0.35rem; align-items: center; flex-wrap: wrap;">
                                            <button type="button" style="background: #2563eb; color: #fff; border: none; padding: 0.45rem 0.8rem; border-radius: 8px; font-size: 0.82rem; font-weight: 700; cursor: pointer; display: inline-flex; align-items: center; gap: 0.25rem;" onclick="openInspectPaymentModal('${inq.saleId}')">
                                                <i class="bi bi-eye-fill"></i> Inspect Slip
                                            </button>
                                            <a href="${pageContext.request.contextPath}/sales/confirm-payment/${inq.saleId}" class="btn-action" style="background: linear-gradient(135deg, #0b5e28 0%, #07401b 100%); color: #fff; padding: 0.45rem 0.8rem; border-radius: 8px; text-decoration: none; font-weight: 800; font-size: 0.82rem; display: inline-flex; align-items: center; justify-content: center; gap: 0.3rem; box-shadow: 0 4px 10px rgba(11, 94, 40, 0.25);" onclick="return confirm('Confirm this payment and unlock legal docs?');">
                                                <i class="bi bi-patch-check-fill"></i> Confirm Payment
                                            </a>
                                        </div>
                                    </c:when>
                                    <c:when test="${inq.status == 'PENDING_PAYMENT'}">
                                        <div style="display: flex; flex-direction: column; gap: 0.35rem;">
                                            <div style="display: flex; gap: 0.35rem; align-items: center;">
                                                <c:if test="${inq.property != null}">
                                                    <button type="button" class="btn-approve" style="padding: 0.4rem 0.8rem; font-size: 0.8rem; background: #e0f2fe; color: #0369a1; border: 1px solid #7dd3fc; border-radius: 6px; font-weight: 600; cursor: pointer;"
                                                            data-id="${inq.id}"
                                                            data-customer="${inq.customerName}"
                                                            data-title="${inq.property.title}"
                                                            data-price="${inq.property.price}"
                                                            onclick="openApprovalFromBtn(this)">
                                                        <i class="bi bi-arrow-repeat"></i> Re-send Bank Info
                                                    </button>
                                                </c:if>
                                                <a href="${pageContext.request.contextPath}/sales/cancel-inquiry/${inq.id}" class="btn-cancel" style="padding: 0.4rem 0.7rem; font-size: 0.78rem; background: #fee2e2; color: #b91c1c; border-radius: 6px; text-decoration: none; font-weight: 700; text-align: center;" onclick="return confirm('Cancel this reservation?');">
                                                    Cancel
                                                </a>
                                            </div>
                                            <c:if test="${inq.saleId != null}">
                                                <button type="button" style="background: #f8fafc; border: 1px solid #cbd5e1; color: #475569; padding: 0.3rem 0.6rem; border-radius: 6px; font-size: 0.75rem; font-weight: 600; cursor: pointer; text-align: left;" onclick="openInspectPaymentModal('${inq.saleId}')">
                                                    <i class="bi bi-receipt"></i> Inspect Dossier #${inq.saleId}
                                                </button>
                                            </c:if>
                                        </div>
                                    </c:when>
                                    <c:when test="${inq.status == 'CANCELLED'}">
                                        <span style="color: #94a3b8; font-size: 0.82rem; font-style: italic;">No actions (Closed)</span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${inq.property != null}">
                                                <div style="display: flex; gap: 0.4rem; align-items: center; flex-wrap: wrap;">
                                                    <a href="${pageContext.request.contextPath}/sales/approve-inquiry/${inq.id}" class="btn-approve" style="padding: 0.5rem 0.85rem; font-size: 0.85rem; text-decoration: none; display: inline-flex; align-items: center; gap: 0.35rem; box-shadow: 0 4px 12px rgba(11, 94, 40, 0.25); border-radius: 8px;">
                                                        <i class="bi bi-send-check-fill"></i> Approve & Send Bank Info
                                                    </a>
                                                    <button type="button" class="btn-approve" style="padding: 0.5rem 0.7rem; font-size: 0.88rem; background: #047857; border-radius: 8px;"
                                                            data-id="${inq.id}"
                                                            data-customer="${inq.customerName}"
                                                            data-title="${inq.property.title}"
                                                            data-price="${inq.property.price}"
                                                            onclick="openApprovalFromBtn(this)"
                                                            title="Custom Advance or Bank Details">
                                                        <i class="bi bi-sliders"></i>
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/sales/cancel-inquiry/${inq.id}" class="btn-cancel" style="padding: 0.5rem 0.8rem; font-size: 0.85rem; background: #fee2e2; color: #b91c1c; border-radius: 8px; text-decoration: none; font-weight: 700; display: inline-flex; align-items: center; gap: 0.25rem;">
                                                        <i class="bi bi-x-circle-fill"></i> Cancel
                                                    </a>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div style="display: flex; gap: 0.4rem; align-items: center;">
                                                            <span style="font-size: 0.8rem; color: #64748b; font-weight: 600; background: #f8fafc; padding: 0.4rem 0.7rem; border-radius: 6px; border: 1px dashed #cbd5e1;">
                                                                <i class="bi bi-telephone-outbound"></i> Contact Customer directly
                                                            </span>
                                                    <a href="${pageContext.request.contextPath}/sales/cancel-inquiry/${inq.id}" class="btn-cancel" style="padding: 0.4rem 0.7rem; font-size: 0.8rem; background: #fee2e2; color: #b91c1c; border-radius: 6px; text-decoration: none; font-weight: 700;">
                                                        Close
                                                    </a>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty inquiries}">
                    <tr>
                        <td colspan="6" style="text-align: center; color: var(--text-muted); padding: 2.5rem;">
                            <i class="bi bi-check2-circle" style="font-size: 2rem; color: #10b981; display: block; margin-bottom: 0.5rem;"></i>
                            No pending customer reservation requests. All clear!
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 2. Active Bookings & Sales Records Section -->
    <div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
            <h2 style="font-size: 1.25rem; font-weight: 800; color: var(--text-dark); margin: 0; display: flex; align-items: center; gap: 0.5rem;">
                <i class="bi bi-journal-bookmark-fill" style="color: var(--primary);"></i> Active Bookings & Conveyancing Dossiers
            </h2>
            <span style="background: #e2e8f0; color: #475569; padding: 0.35rem 0.85rem; border-radius: 20px; font-size: 0.85rem; font-weight: 700;">
                    ${sales.size()} Total Records
                </span>
        </div>

        <div class="table-card">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Property</th>
                    <th>Customer / Buyer</th>
                    <th>Total (LKR)</th>
                    <th>Payment & Slip Status</th>
                    <th>Legal Conveyancing</th>
                    <th>Sales Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="sale" items="${sales}">
                    <tr>
                        <td>#${sale.id}</td>
                        <td style="font-weight: 600;">
                                ${sale.property.title}
                            <div style="font-size: 0.8rem; color: var(--text-muted);">${sale.property.location}</div>
                        </td>
                        <td>
                            <strong>${sale.customer.name}</strong>
                            <c:if test="${not empty sale.buyerNic}">
                                <div style="font-size: 0.8rem; color: #0b5e28;"><i class="bi bi-person-vcard"></i> NIC: ${sale.buyerNic}</div>
                            </c:if>
                        </td>
                        <td>
                            <div style="font-weight: 700;">Rs. <fmt:formatNumber value="${sale.salePrice}" type="number" maxFractionDigits="2"/></div>
                            <div style="font-size: 0.82rem; color: #047857;">Adv: Rs. <fmt:formatNumber value="${sale.advancePaid != null ? sale.advancePaid : 0}" type="number" maxFractionDigits="2"/></div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${sale.paymentStatus == 'PAYMENT_VERIFIED' || sale.paymentStatus == 'FULLY_PAID' || sale.paymentStatus == 'PAID'}">
                                    <span class="status-badge" style="background: #dcfce7; color: #15803d; font-weight: 700;"><i class="bi bi-check-circle-fill"></i> Payment Verified</span>
                                    <c:if test="${not empty sale.paymentApprovedBy}">
                                        <div style="font-size: 0.76rem; color: #166534; font-weight: 600; margin-top: 0.3rem; display: flex; align-items: center; gap: 0.3rem;">
                                            <i class="bi bi-person-check-fill" style="color: #10b981;"></i> Approved by: <strong>${sale.paymentApprovedBy}</strong>
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:when test="${sale.paymentStatus == 'PAYMENT_SUBMITTED'}">
                                    <div style="background: #eff6ff; border: 1px solid #bfdbfe; color: #1e40af; padding: 0.5rem 0.75rem; border-radius: 10px; font-size: 0.82rem;">
                                        <div style="font-weight: 800; display: flex; align-items: center; gap: 0.3rem; margin-bottom: 0.2rem;">
                                            <i class="bi bi-receipt"></i> Slip Uploaded
                                        </div>
                                        <div style="font-size: 0.78rem; color: #1e3a8a; font-weight: 700;">Ref: ${not empty sale.paymentReference ? sale.paymentReference : 'Submitted'}</div>
                                        <button type="button" style="background: #2563eb; color: #fff; border: none; padding: 0.25rem 0.65rem; border-radius: 6px; font-size: 0.75rem; font-weight: 700; margin-top: 0.35rem; cursor: pointer; display: inline-flex; align-items: center; gap: 0.25rem;" onclick="openInspectPaymentModal('${sale.id}')">
                                            <i class="bi bi-search"></i> Inspect Slip
                                        </button>
                                    </div>
                                </c:when>
                                <c:when test="${sale.status == 'CANCELLED'}">
                                    <span class="status-badge" style="background: #fee2e2; color: #991b1b;"><i class="bi bi-x-circle"></i> Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge" style="background: #fef3c7; color: #b45309; font-weight: 700;"><i class="bi bi-hourglass-split"></i> Awaiting Bank Transfer</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${sale.legalStatus == 'OWNERSHIP_TRANSFERRED'}">
                                    <span class="status-badge" style="background: #dcfce7; color: #15803d; font-weight: 700;"><i class="bi bi-award-fill"></i> Deed Transferred</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'READY_TO_SIGN'}">
                                    <span class="status-badge" style="background: #ede9fe; color: #6d28d9; font-weight: 700;"><i class="bi bi-pen-fill"></i> Ready for Signing</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'DEED_DRAFTED'}">
                                    <span class="status-badge" style="background: #e0f2fe; color: #0369a1; font-weight: 700;"><i class="bi bi-file-earmark-text"></i> Deed Drafted</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'TITLE_CLEARED'}">
                                    <span class="status-badge" style="background: #ecfdf5; color: #047857; font-weight: 700;"><i class="bi bi-shield-check"></i> Title Cleared</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'DOCS_REJECTED'}">
                                    <span class="status-badge" style="background: #fee2e2; color: #b91c1c; font-weight: 700;"><i class="bi bi-exclamation-octagon-fill"></i> Docs Rejected</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'DOCS_SUBMITTED'}">
                                    <span class="status-badge" style="background: #fef3c7; color: #b45309; font-weight: 700;"><i class="bi bi-person-check-fill"></i> Buyer NIC Uploaded</span>
                                </c:when>
                                <c:when test="${sale.legalStatus == 'PENDING_DOCS'}">
                                    <span class="status-badge" style="background: #f1f5f9; color: #475569; font-weight: 700;"><i class="bi bi-clock-history"></i> Awaiting Buyer NIC</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge" style="background: #f1f5f9; color: #94a3b8; font-weight: 600;"><i class="bi bi-lock-fill"></i> Locked (Pending Payment)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <!-- Hidden metadata for inspection modal -->
                            <div id="sale-inspect-data-${sale.id}" style="display: none;">
                                <span class="sid-id">${sale.id}</span>
                                <span class="sid-prop-title"><c:out value="${sale.property.title}"/></span>
                                <span class="sid-prop-location"><c:out value="${sale.property.location}"/></span>
                                <span class="sid-prop-size"><c:out value="${sale.property.size}"/></span>
                                <span class="sid-cust-name"><c:out value="${sale.customer.name}"/></span>
                                <span class="sid-cust-email"><c:out value="${sale.customer.email}"/></span>
                                <span class="sid-cust-phone"><c:out value="${sale.customer.phone}"/></span>
                                <span class="sid-price"><c:out value="${sale.salePrice}"/></span>
                                <span class="sid-advance"><c:out value="${sale.advancePaid != null ? sale.advancePaid : 0}"/></span>
                                <span class="sid-balance"><c:out value="${sale.balanceAmount != null ? sale.balanceAmount : sale.salePrice}"/></span>
                                <span class="sid-pay-status"><c:out value="${sale.paymentStatus}"/></span>
                                <span class="sid-pay-ref"><c:out value="${sale.paymentReference}"/></span>
                                <span class="sid-pay-slip"><c:out value="${sale.paymentSlipUrl}"/></span>
                                <div class="sid-bank-details"><c:out value="${sale.bankDetails}"/></div>
                                <div class="sid-sales-notes"><c:out value="${sale.salesNotes}"/></div>
                            </div>

                            <c:choose>
                                <c:when test="${sale.paymentStatus == 'PAYMENT_SUBMITTED'}">
                                    <div style="display: flex; flex-direction: column; gap: 0.35rem;">
                                        <button type="button" class="btn-action" style="background: #2563eb; color: #fff; padding: 0.45rem 0.85rem; border-radius: 8px; font-weight: 700; font-size: 0.82rem; display: inline-flex; align-items: center; justify-content: center; gap: 0.3rem; border: none; cursor: pointer; box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);"
                                                onclick="openInspectPaymentModal('${sale.id}')">
                                            <i class="bi bi-eye-fill"></i> Inspect & Approve
                                        </button>
                                        <a href="${pageContext.request.contextPath}/sales/confirm-payment/${sale.id}" class="btn-confirm" onclick="return confirm('Approve this customer payment and unlock Legal Document Submission?');" style="display: inline-flex; align-items: center; justify-content: center; gap: 0.3rem; padding: 0.4rem 0.8rem; font-size: 0.82rem;">
                                            <i class="bi bi-patch-check-fill"></i> Quick Approve
                                        </a>
                                        <a href="${pageContext.request.contextPath}/sales/cancel-reservation/${sale.id}" style="color: #dc2626; font-size: 0.78rem; text-decoration: underline; text-align: center; margin-top: 0.15rem;" onclick="return confirm('Cancel this reservation?');">Cancel Reservation</a>
                                    </div>
                                </c:when>
                                <c:when test="${sale.paymentStatus == 'PENDING_PAYMENT' && sale.status != 'CANCELLED'}">
                                    <div style="display: flex; flex-direction: column; gap: 0.3rem;">
                                        <button type="button" style="background: #f8fafc; border: 1px solid #cbd5e1; color: #334155; padding: 0.35rem 0.65rem; border-radius: 6px; font-size: 0.78rem; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; justify-content: center; gap: 0.25rem;" onclick="openInspectPaymentModal('${sale.id}')">
                                            <i class="bi bi-info-circle"></i> View Details
                                        </button>
                                        <a href="${pageContext.request.contextPath}/sales/confirm-payment/${sale.id}" class="btn-confirm" style="padding: 0.35rem 0.75rem; font-size: 0.8rem; text-align: center;" onclick="return confirm('Mark payment as verified directly?');">
                                            <i class="bi bi-check2"></i> Mark Paid
                                        </a>
                                        <a href="${pageContext.request.contextPath}/sales/cancel-reservation/${sale.id}" style="color: #dc2626; font-size: 0.78rem; text-align: center;" onclick="return confirm('Cancel reservation?');">Cancel</a>
                                    </div>
                                </c:when>
                                <c:when test="${sale.status == 'COMPLETED'}">
                                    <span style="color: #059669; font-weight: 700; font-size: 0.88rem;"><i class="bi bi-patch-check-fill"></i> Closed & Sold</span>
                                </c:when>
                                <c:when test="${sale.status == 'CANCELLED'}">
                                    <span style="color: #94a3b8; font-size: 0.85rem;">Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    <div style="background: #f0fdf4; border: 1px solid #bbf7d0; padding: 0.5rem 0.75rem; border-radius: 8px; text-align: center;">
                                                <span style="color: #15803d; font-weight: 800; font-size: 0.8rem; display: flex; align-items: center; justify-content: center; gap: 0.3rem;">
                                                    <i class="bi bi-shield-shaded" style="color: #059669;"></i> Handed Over to Legal
                                                </span>
                                        <div style="font-size: 0.72rem; color: #166534; margin-top: 0.15rem; font-weight: 600;">Managed by Legal Officer</div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty sales}">
                    <tr>
                        <td colspan="7" style="text-align: center; color: var(--text-muted); padding: 2rem;">No reservations or sales recorded yet.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal 1: Approve Reservation & Dispatch Bank Info -->
<div id="approvalModal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.6); z-index: 9999; align-items: center; justify-content: center; backdrop-filter: blur(4px);">
    <div style="background: #fff; width: 90%; max-width: 540px; border-radius: 16px; padding: 2rem; box-shadow: 0 20px 40px rgba(0,0,0,0.25); position: relative; max-height: 90vh; overflow-y: auto;">
        <button onclick="closeApprovalModal()" style="position: absolute; top: 1.25rem; right: 1.25rem; background: none; border: none; font-size: 1.5rem; color: #64748b; cursor: pointer;">&times;</button>

        <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.25rem;">
            <div style="width: 44px; height: 44px; border-radius: 50%; background: rgba(5, 150, 105, 0.15); color: #059669; display: flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                <i class="bi bi-bank2"></i>
            </div>
            <div>
                <h3 style="margin: 0; font-size: 1.2rem; color: #0f172a;">Approve Reservation & Dispatch Bank Info</h3>
                <p style="margin: 0; color: #64748b; font-size: 0.85rem;">Send official bank payment details to customer</p>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/sales/approve-inquiry" method="POST">
            <input type="hidden" id="modalInquiryId" name="inquiryId">

            <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 1rem; margin-bottom: 1.25rem;">
                <div style="font-size: 0.9rem; margin-bottom: 0.35rem;">Customer: <strong id="modalCustomerName" style="color: #0f172a;">-</strong></div>
                <div style="font-size: 0.9rem; margin-bottom: 0.35rem;">Land Plot: <strong id="modalPropertyTitle" style="color: #0b5e28;">-</strong></div>
                <div style="font-size: 0.9rem;">Total Price: <strong id="modalPropertyPrice" style="color: #b45309;">-</strong></div>
            </div>

            <div class="form-group" style="margin-bottom: 1rem;">
                <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Required Advance / Reservation Deposit (LKR)</label>
                <input type="number" id="modalAdvanceInput" name="advanceAmount" placeholder="e.g. 500000" style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 0.95rem; box-sizing: border-box;" required>
            </div>

            <div class="form-group" style="margin-bottom: 1rem;">
                <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">
                    <i class="bi bi-bank" style="color: #0b5e28;"></i> Company Bank Account Transfer Details
                </label>
                <textarea name="bankDetails" rows="3" style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 0.88rem; box-sizing: border-box;" required>Commercial Bank of Ceylon PLC
Account Name: Ceylon Lands (Pvt) Ltd
Account Number: 1000849201
Branch: Colombo Corporate Branch (03)
Swift: CCBLKLK</textarea>
                <small style="color: #64748b; font-size: 0.78rem; display: block; margin-top: 0.25rem;">These bank details will be shown to the customer in their portal for payment transfer.</small>
            </div>

            <div class="form-group" style="margin-bottom: 1.5rem;">
                <label style="display: block; font-weight: 700; font-size: 0.88rem; color: #334155; margin-bottom: 0.4rem;">Sales Notes & Terms</label>
                <textarea name="salesNotes" rows="2" placeholder="Customer confirmed plot reservation. Advance receipt will be issued on bank confirmation." style="width: 100%; padding: 0.75rem; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 0.88rem; box-sizing: border-box;">Customer confirmed plot reservation. Please transfer advance deposit to lock plot and unlock deed registration.</textarea>
            </div>

            <div style="display: flex; gap: 0.75rem; justify-content: flex-end;">
                <button type="button" onclick="closeApprovalModal()" style="padding: 0.75rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 8px; font-weight: 700; cursor: pointer; color: #475569;">Cancel</button>
                <button type="submit" class="btn-approve" style="padding: 0.75rem 1.5rem; font-size: 0.95rem;">
                    <i class="bi bi-send-fill"></i> Send Approval & Bank Info
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal 2: Sales Manager Inspect Customer Payment Slip & Approve -->
<div id="inspectPaymentModal" style="display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.65); z-index: 9999; align-items: center; justify-content: center; backdrop-filter: blur(4px); padding: 1rem;">
    <div style="background: #fff; width: 100%; max-width: 680px; border-radius: 18px; padding: 2rem; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25); position: relative; max-height: 90vh; overflow-y: auto;">
        <button onclick="closeInspectPaymentModal()" style="position: absolute; top: 1.25rem; right: 1.25rem; background: none; border: none; font-size: 1.5rem; color: #64748b; cursor: pointer;">&times;</button>

        <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1.25rem;">
            <div style="width: 46px; height: 46px; border-radius: 50%; background: #eff6ff; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 1.4rem;">
                <i class="bi bi-receipt-cutoff"></i>
            </div>
            <div>
                <h3 style="margin: 0; font-size: 1.25rem; color: #0f172a;">Customer Payment Slip & Transfer Verification</h3>
                <p style="margin: 0; color: #64748b; font-size: 0.85rem;">Review submitted bank slip and approve to unlock legal conveyancing</p>
            </div>
        </div>

        <!-- Summary Box -->
        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 1.25rem; margin-bottom: 1.25rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.65rem; font-size: 0.88rem;">
                <div>Customer: <strong id="inspCustomerName" style="color: #0f172a;">-</strong></div>
                <div>Contact: <strong id="inspCustomerContact" style="color: #047857;">-</strong></div>
                <div>Land Plot: <strong id="inspPropertyTitle" style="color: #0b5e28;">-</strong></div>
                <div>Location: <strong id="inspPropertyLocation" style="color: #475569;">-</strong></div>
                <div>Total Price: <strong id="inspTotalPrice" style="color: #0f172a;">-</strong></div>
                <div>Required Advance: <strong id="inspAdvance" style="color: #059669;">-</strong></div>
            </div>
        </div>

        <!-- Submitted Reference & Slip Preview -->
        <div style="background: #ffffff; border: 1.5px solid #93c5fd; border-radius: 14px; padding: 1.25rem; margin-bottom: 1.5rem;">
            <div style="font-size: 0.85rem; font-weight: 700; color: #1e40af; margin-bottom: 0.5rem;">
                <i class="bi bi-hash"></i> Bank Transaction Reference / ID:
            </div>
            <div id="inspPaymentRefBox" style="font-size: 1.15rem; font-weight: 800; color: #1e3a8a; background: #eff6ff; padding: 0.75rem 1rem; border-radius: 8px; border: 1px dashed #3b82f6; margin-bottom: 1rem; word-break: break-all;">
                -
            </div>

            <div style="font-size: 0.85rem; font-weight: 700; color: #334155; margin-bottom: 0.5rem;">
                <i class="bi bi-image"></i> Payment Slip / Receipt Photo:
            </div>

            <div id="inspSlipImageContainer" style="text-align: center; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 1rem; min-height: 120px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                <img id="inspSlipImg" src="" alt="Payment Slip" style="display: none; max-width: 100%; max-height: 280px; object-fit: contain; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 0.75rem;">
                <div id="inspSlipLinkBox" style="display: none;">
                    <a id="inspSlipLink" href="#" target="_blank" class="btn-action" style="padding: 0.4rem 0.85rem; font-size: 0.82rem; background: #2563eb; color: #fff; text-decoration: none; display: inline-flex; align-items: center; gap: 0.3rem;">
                        <i class="bi bi-box-arrow-up-right"></i> Open Fullsize Slip in New Tab
                    </a>
                </div>
                <div id="inspNoSlipText" style="color: #64748b; font-size: 0.85rem;">
                    <i class="bi bi-file-earmark-text" style="font-size: 1.5rem; display: block; margin-bottom: 0.25rem; color: #94a3b8;"></i>
                    Customer provided transaction reference number without an image URL. Verify through official bank statement.
                </div>
            </div>
        </div>

        <!-- Modal Action Buttons -->
        <div style="display: flex; gap: 0.75rem; justify-content: flex-end; align-items: center; flex-wrap: wrap;">
            <button type="button" onclick="closeInspectPaymentModal()" style="padding: 0.75rem 1.25rem; border: 1px solid #cbd5e1; background: #fff; border-radius: 8px; font-weight: 700; cursor: pointer; color: #475569;">Close</button>
            <a id="inspApproveBtn" href="#" class="btn-confirm" style="padding: 0.75rem 1.5rem; font-size: 0.92rem; background: linear-gradient(135deg, #0b5e28 0%, #06401b 100%); text-decoration: none; display: inline-flex; align-items: center; gap: 0.35rem; box-shadow: 0 4px 12px rgba(11, 94, 40, 0.3);" onclick="return confirm('Verify this customer payment and unlock Legal Document Submission?');">
                <i class="bi bi-patch-check-fill"></i> Approve Payment & Unlock Legal Conveyancing
            </a>
        </div>
    </div>
</div>

<script>
    function openApprovalFromBtn(btn) {
        var inqId = btn.getAttribute('data-id');
        var custName = btn.getAttribute('data-customer');
        var propTitle = btn.getAttribute('data-title');
        var propPrice = btn.getAttribute('data-price');
        openApprovalModal(inqId, custName, propTitle, propPrice);
    }

    function openApprovalModal(inqId, custName, propTitle, propPrice) {
        document.getElementById('modalInquiryId').value = inqId;
        document.getElementById('modalCustomerName').innerText = custName;
        document.getElementById('modalPropertyTitle').innerText = propTitle;
        document.getElementById('modalPropertyPrice').innerText = 'Rs. ' + Number(propPrice).toLocaleString();

        // Set default 10% or 500,000 as advance
        var priceNum = Number(propPrice);
        var defaultAdv = Math.min(500000, priceNum > 0 ? Math.round(priceNum * 0.1) : 500000);
        document.getElementById('modalAdvanceInput').value = defaultAdv;

        var modal = document.getElementById('approvalModal');
        modal.style.display = 'flex';
    }

    function closeApprovalModal() {
        document.getElementById('approvalModal').style.display = 'none';
    }

    function openInspectPaymentModal(saleId) {
        var dataEl = document.getElementById('sale-inspect-data-' + saleId);
        if (!dataEl) {
            alert('Reservation record not found: #' + saleId);
            return;
        }

        var propTitle = dataEl.querySelector('.sid-prop-title') ? dataEl.querySelector('.sid-prop-title').innerText : '';
        var propLocation = dataEl.querySelector('.sid-prop-location') ? dataEl.querySelector('.sid-prop-location').innerText : '';
        var custName = dataEl.querySelector('.sid-cust-name') ? dataEl.querySelector('.sid-cust-name').innerText : '';
        var custEmail = dataEl.querySelector('.sid-cust-email') ? dataEl.querySelector('.sid-cust-email').innerText : '';
        var custPhone = dataEl.querySelector('.sid-cust-phone') ? dataEl.querySelector('.sid-cust-phone').innerText : '';
        var price = dataEl.querySelector('.sid-price') ? dataEl.querySelector('.sid-price').innerText : '0';
        var advance = dataEl.querySelector('.sid-advance') ? dataEl.querySelector('.sid-advance').innerText : '0';
        var payRef = dataEl.querySelector('.sid-pay-ref') ? dataEl.querySelector('.sid-pay-ref').innerText.trim() : '';
        var paySlip = dataEl.querySelector('.sid-pay-slip') ? dataEl.querySelector('.sid-pay-slip').innerText.trim() : '';

        document.getElementById('inspCustomerName').innerText = custName;
        document.getElementById('inspCustomerContact').innerText = (custPhone ? custPhone + ' ' : '') + (custEmail ? '(' + custEmail + ')' : '');
        document.getElementById('inspPropertyTitle').innerText = propTitle;
        document.getElementById('inspPropertyLocation').innerText = propLocation;
        document.getElementById('inspTotalPrice').innerText = 'Rs. ' + Number(price).toLocaleString();
        document.getElementById('inspAdvance').innerText = 'Rs. ' + Number(advance).toLocaleString();
        document.getElementById('inspPaymentRefBox').innerText = payRef && payRef !== '' ? payRef : 'No reference provided';

        var slipImg = document.getElementById('inspSlipImg');
        var slipLinkBox = document.getElementById('inspSlipLinkBox');
        var slipLink = document.getElementById('inspSlipLink');
        var noSlipText = document.getElementById('inspNoSlipText');

        if (paySlip && paySlip !== '') {
            slipImg.src = paySlip;
            slipImg.style.display = 'block';
            slipLink.href = paySlip;
            slipLinkBox.style.display = 'block';
            noSlipText.style.display = 'none';
        } else {
            slipImg.style.display = 'none';
            slipLinkBox.style.display = 'none';
            noSlipText.style.display = 'block';
        }

        document.getElementById('inspApproveBtn').href = '${pageContext.request.contextPath}/sales/confirm-payment/' + saleId;

        document.getElementById('inspectPaymentModal').style.display = 'flex';
    }

    function closeInspectPaymentModal() {
        document.getElementById('inspectPaymentModal').style.display = 'none';
    }
</script>

</body>
</html>