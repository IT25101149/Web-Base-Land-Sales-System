<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Inquiries - Land Sales System</title>
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
            text-decoration: none;
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
            <li class="active"><a href="${pageContext.request.contextPath}/crm"><i class="bi bi-people-fill"></i> Customers</a></li>
            <li><a href="${pageContext.request.contextPath}/sales"><i class="bi bi-currency-dollar"></i> Sales & Reserves</a></li>
        </ul>
    </div>

    <!-- Main Content Area -->
    <div class="main-container">
        <header>
            <div>
                <h1>Customer Inquiries</h1>
                <p style="color: var(--text-muted); font-size: 0.9rem;">View incoming inquiries sent by portal visitors.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/crm" class="btn-primary" style="background-color: #0f172a;">
                    <i class="bi bi-arrow-left-circle-fill"></i> Back to CRM
                </a>
            </div>
        </header>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Sender Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Property</th>
                        <th>Status / State</th>
                        <th>Inquiry Message</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="inq" items="${inquiries}">
                        <tr>
                            <td>${inq.inquiryDate}</td>
                            <td style="font-weight: 600;">${inq.customerName}</td>
                            <td>${inq.email}</td>
                            <td>${inq.phone}</td>
                            <td style="font-weight: 600;">
                                <c:choose>
                                    <c:when test="${inq.property != null}">${inq.property.title}</c:when>
                                    <c:otherwise>General Inquiry</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${inq.status == 'COMPLETED'}">
                                        <span style="background: #ecfdf5; color: #047857; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.8rem;"><i class="bi bi-award-fill"></i> Sale Completed</span>
                                    </c:when>
                                    <c:when test="${inq.status == 'FULL_APPROVED' || inq.status == 'PAYMENT_VERIFIED'}">
                                        <span style="background: #dcfce7; color: #15803d; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.8rem;"><i class="bi bi-patch-check-fill"></i> Payment Confirmed</span>
                                    </c:when>
                                    <c:when test="${inq.status == 'PAYMENT_SUBMITTED'}">
                                        <span style="background: #fef9c3; color: #854d0e; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.8rem;"><i class="bi bi-receipt-cutoff"></i> Slip Submitted</span>
                                    </c:when>
                                    <c:when test="${inq.status == 'PENDING_PAYMENT'}">
                                        <span style="background: #e0f2fe; color: #0369a1; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.8rem;"><i class="bi bi-calendar2-check-fill"></i> Reserved (Awaiting Pay)</span>
                                    </c:when>
                                    <c:when test="${inq.status == 'CANCELLED'}">
                                        <span style="background: #fee2e2; color: #991b1b; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 600; font-size: 0.8rem;"><i class="bi bi-x-circle-fill"></i> Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="background: #fef3c7; color: #b45309; padding: 0.25rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.8rem;"><i class="bi bi-clock-history"></i> Pending Review</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="color: var(--text-muted); font-size: 0.9rem;">${inq.message}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty inquiries}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: var(--text-muted); padding: 2rem;">No inquiries received yet.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
