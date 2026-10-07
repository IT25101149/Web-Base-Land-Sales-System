<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Property - Land Sales System</title>
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
            background-color: #0b1120;
            color: #fff;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 2rem;
            position: fixed;
            height: 100vh;
        }

        .logo {
            font-size: 1.45rem;
            font-weight: 800;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            text-decoration: none;
        }

        .logo i {
            color: #4f46e5;
            font-size: 1.5rem;
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
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 600;
            font-size: 0.95rem;
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

        /* Main Content */
        .main-container {
            margin-left: 260px;
            flex: 1;
            padding: 2.5rem 3rem;
            max-width: 900px;
        }

        .breadcrumb-back {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 700;
            margin-bottom: 1.25rem;
            transition: all 0.2s;
        }

        .breadcrumb-back:hover {
            transform: translateX(-3px);
            color: var(--primary-hover);
        }

        header {
            margin-bottom: 2rem;
        }

        header h1 {
            font-size: 1.85rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 0.35rem;
        }

        /* Form Container */
        .form-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.45rem;
        }

        label {
            font-size: 0.92rem;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        input[type="number"], select {
            padding: 0.85rem 1rem;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 0.95rem;
            outline: none;
            transition: all 0.2s ease;
            background: #fff;
            color: #0f172a;
        }

        input[type="number"]:focus, select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.12);
        }

        .helper-text {
            color: var(--text-muted);
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            gap: 0.35rem;
        }

        .btn-submit {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: white;
            border: none;
            padding: 0.9rem 1.5rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: 0 4px 14px rgba(79, 70, 229, 0.3);
            margin-top: 1rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
        }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/" class="logo" style="display: flex; align-items: center; gap: 0.65rem; text-decoration: none;">
        <img src="${pageContext.request.contextPath}/uploads/ceylon-lands-logo.jpg" alt="Ceylon Lands" style="height: 38px; width: 38px; border-radius: 8px; object-fit: cover; border: 1.5px solid #d4af37;">
        <span>Ceylon<span style="color: #d4af37;">Lands</span></span>
    </a>
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
    <a href="${pageContext.request.contextPath}/sales" class="breadcrumb-back">
        <i class="bi bi-arrow-left"></i> Back to Sales & Reservation Management
    </a>

    <header>
        <h1>Reserve Property Plot</h1>
        <p style="color: var(--text-muted); font-size: 0.95rem;">Link an available property plot to a registered customer reservation profile.</p>
    </header>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/sales/reserve/save" method="post">
            <div class="form-group">
                <label for="propertyId"><i class="bi bi-geo-alt-fill" style="color: #0b5e28;"></i> Select Property / Land Plot</label>
                <select id="propertyId" name="propertyId" required>
                    <option value="">-- Choose a property --</option>
                    <c:forEach var="prop" items="${properties}">
                        <c:if test="${prop.status == 'AVAILABLE'}">
                            <option value="${prop.id}">${prop.title} (${prop.location}) - LKR <fmt:formatNumber value="${prop.price}" type="number" maxFractionDigits="2"/></option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="customerId"><i class="bi bi-person-check-fill" style="color: #4f46e5;"></i> Select Customer</label>
                <select id="customerId" name="customerId" required>
                    <option value="">-- Choose a customer --</option>
                    <c:forEach var="cust" items="${customers}">
                        <option value="${cust.id}">
                                ${cust.name} (${cust.email}${not empty cust.phone ? ' &bull; ' += cust.phone : ''})
                        </option>
                    </c:forEach>
                </select>
                <div class="helper-text">
                    <i class="bi bi-shield-check" style="color: #10b981;"></i> Only registered customer accounts are listed. System staff (admin, sales, legal) are excluded.
                </div>
            </div>

            <div class="form-group">
                <label for="salePrice"><i class="bi bi-cash-stack" style="color: #b45309;"></i> Agreed Sale Price (LKR) <span style="font-size: 0.8rem; font-weight: 500; color: #64748b;">(Leave blank to use default property value)</span></label>
                <input type="number" id="salePrice" name="salePrice" step="0.01" placeholder="e.g. 4500000">
            </div>

            <button type="submit" class="btn-submit">
                <i class="bi bi-calendar2-check-fill"></i> Confirm Reservation
            </button>
        </form>
    </div>
</div>

</body>
</html>
