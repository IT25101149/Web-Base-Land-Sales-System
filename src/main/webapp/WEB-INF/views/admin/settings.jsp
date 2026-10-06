<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Settings & Business Policies - Ceylon Lands</title>
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

        /* Grid */
        .settings-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.8rem;
        }

        @media (max-width: 1024px) {
            .settings-grid { grid-template-columns: 1fr; }
        }

        .card {
            background-color: var(--card-bg);
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.03), 0 2px 4px -2px rgba(0, 0, 0, 0.03);
            padding: 1.8rem;
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid var(--border);
            padding-bottom: 1rem;
        }

        .card-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .form-section {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .section-heading {
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            font-weight: 800;
            color: #6366f1;
            padding-bottom: 0.4rem;
            border-bottom: 2px solid #e0e7ff;
            margin-top: 0.5rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
        }

        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.45rem;
        }

        .form-group label {
            font-size: 0.88rem;
            font-weight: 600;
            color: #334155;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .form-group input, .form-group textarea {
            padding: 0.75rem 1rem;
            border: 1.5px solid var(--border);
            border-radius: 10px;
            font-size: 0.95rem;
            color: var(--text-dark);
            transition: all 0.2s ease;
        }

        .form-group input:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .form-hint {
            font-size: 0.78rem;
            color: var(--text-muted);
        }

        .switch-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.9rem 1.1rem;
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 12px;
        }

        .switch-row label {
            font-weight: 600;
            font-size: 0.92rem;
            color: #1e293b;
            cursor: pointer;
        }

        .switch-row input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: var(--primary);
        }

        .btn-save {
            background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%);
            color: #fff;
            border: none;
            padding: 0.85rem 1.8rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
            transition: all 0.2s ease;
        }

        .btn-save:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(79, 70, 229, 0.35);
        }

        .btn-reset {
            background: #ffffff;
            color: var(--danger);
            border: 1.5px solid rgba(239, 68, 68, 0.3);
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            transition: all 0.2s ease;
        }

        .btn-reset:hover {
            background: rgba(239, 68, 68, 0.08);
            border-color: var(--danger);
        }

        /* Policy Simulation Preview */
        .simulation-box {
            background: linear-gradient(135deg, #1e1b4b 0%, #0f172a 100%);
            color: #f8fafc;
            border-radius: 14px;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            box-shadow: 0 10px 25px -5px rgba(30, 27, 75, 0.4);
        }

        .sim-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.9rem;
        }

        .sim-val {
            font-weight: 700;
            color: #a5b4fc;
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
        <li><a href="${pageContext.request.contextPath}/admin/users"><i class="bi bi-people-fill"></i> User Management</a></li>
        <li class="active"><a href="${pageContext.request.contextPath}/admin/settings"><i class="bi bi-gear-fill"></i> System Settings</a></li>
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
            <h1>System Settings & Business Policies</h1>
            <p style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.2rem;">
                Configure enterprise legal identity, minimum advance deposit rates, reservation periods, and platform flags.
            </p>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </header>

    <!-- Alerts -->
    <c:if test="${not empty successMessage}">
        <div style="background-color: #d1fae5; border-left: 4px solid #10b981; color: #065f46; padding: 0.95rem 1.25rem; border-radius: 10px; display: flex; align-items: center; gap: 0.7rem; font-weight: 600;">
            <i class="bi bi-check-circle-fill" style="color: #10b981; font-size: 1.2rem;"></i>
            <span>${successMessage}</span>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div style="background-color: #fee2e2; border-left: 4px solid #ef4444; color: #991b1b; padding: 0.95rem 1.25rem; border-radius: 10px; display: flex; align-items: center; gap: 0.7rem; font-weight: 600;">
            <i class="bi bi-exclamation-triangle-fill" style="color: #ef4444; font-size: 1.2rem;"></i>
            <span>${errorMessage}</span>
        </div>
    </c:if>

    <div class="settings-grid">
        <!-- Left Form Panel -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">
                    <i class="bi bi-sliders2" style="color: var(--primary);"></i> Enterprise Configuration Form
                </div>
                <span style="font-size: 0.8rem; color: var(--text-muted);">
                        Last saved: <strong>${settings.updatedBy}</strong> (${settings.updatedAt})
                    </span>
            </div>

            <form action="${pageContext.request.contextPath}/admin/settings/update" method="POST" class="form-section">

                <!-- Section 1: Company Legal Identity -->
                <div class="section-heading"><i class="bi bi-building"></i> 1. Corporate Identity & Legal Profile</div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="companyName">Registered Company Name</label>
                        <input type="text" id="companyName" name="companyName" value="${settings.companyName}" required>
                        <span class="form-hint">Displayed on buyer deeds, receipts, and legal verification certificates.</span>
                    </div>
                    <div class="form-group">
                        <label for="companyEmail">Official Support Email</label>
                        <input type="email" id="companyEmail" name="companyEmail" value="${settings.companyEmail}" required>
                        <span class="form-hint">Receives booking notifications and system alerts.</span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="companyPhone">Official Inquiries Hotline</label>
                        <input type="text" id="companyPhone" name="companyPhone" value="${settings.companyPhone}">
                    </div>
                    <div class="form-group">
                        <label for="companyAddress">Headquarters Legal Address</label>
                        <input type="text" id="companyAddress" name="companyAddress" value="${settings.companyAddress}">
                    </div>
                </div>

                <!-- Section 2: Real Estate Business Policies -->
                <div class="section-heading"><i class="bi bi-cash-stack"></i> 2. Financial & Sales Policies</div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="minAdvanceDepositPercentage">Min. Advance Deposit (%)</label>
                        <input type="number" id="minAdvanceDepositPercentage" name="minAdvanceDepositPercentage" value="${settings.minAdvanceDepositPercentage}" min="1" max="100" step="0.5" required oninput="recalculateSimulation()">
                        <span class="form-hint">Minimum payment percentage required from client to lock parcel reservation.</span>
                    </div>
                    <div class="form-group">
                        <label for="reservationValidityDays">Reservation Validity Window (Days)</label>
                        <input type="number" id="reservationValidityDays" name="reservationValidityDays" value="${settings.reservationValidityDays}" min="1" max="90" required oninput="recalculateSimulation()">
                        <span class="form-hint">Days allowed before an unpaid reservation automatically lapses.</span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="defaultStampDutyPercentage">Default Sri Lanka Stamp Duty (%)</label>
                        <input type="number" id="defaultStampDutyPercentage" name="defaultStampDutyPercentage" value="${settings.defaultStampDutyPercentage}" min="0" max="20" step="0.1" required oninput="recalculateSimulation()">
                        <span class="form-hint">Statutory government stamp duty percentage applied during deed clearance.</span>
                    </div>
                </div>

                <!-- Section 3: Platform Operational Controls -->
                <div class="section-heading"><i class="bi bi-toggles"></i> 3. Platform Operational Switches</div>

                <div class="switch-row">
                    <div>
                        <label for="onlineBookingEnabled">Online Customer Portal Booking</label>
                        <p style="font-size: 0.8rem; color: var(--text-muted); margin-top: 2px;">
                            When enabled, verified clients can submit online booking requests directly from the catalog.
                        </p>
                    </div>
                    <input type="checkbox" id="onlineBookingEnabled" name="onlineBookingEnabled" value="true" ${settings.onlineBookingEnabled ? 'checked' : ''}>
                </div>

                <div class="switch-row">
                    <div>
                        <label for="maintenanceMode" style="color: var(--danger);">Booking Maintenance Lock</label>
                        <p style="font-size: 0.8rem; color: var(--text-muted); margin-top: 2px;">
                            Freezes new sales and reservations for year-end inventory audits or price adjustments.
                        </p>
                    </div>
                    <input type="checkbox" id="maintenanceMode" name="maintenanceMode" value="true" ${settings.maintenanceMode ? 'checked' : ''}>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 1rem;">
                    <button type="submit" class="btn-save">
                        <i class="bi bi-check2-circle"></i> Save Business Policies
                    </button>
                </div>
            </form>
        </div>

        <!-- Right Simulation & Management Panel -->
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            <!-- Policy Simulation Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title">
                        <i class="bi bi-calculator" style="color: #6366f1;"></i> Live Policy Impact
                    </div>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted);">
                    Real-time calculation preview applied to a benchmark land lot valued at <strong>LKR 10,000,000</strong>:
                </p>

                <div class="simulation-box">
                    <div class="sim-item">
                        <span>Benchmark Parcel Value</span>
                        <span class="sim-val">LKR 10,000,000</span>
                    </div>
                    <div class="sim-item">
                        <span>Min. Required Deposit</span>
                        <span class="sim-val" id="simDeposit">LKR 1,000,000 (10%)</span>
                    </div>
                    <div class="sim-item">
                        <span>Estimated Stamp Duty</span>
                        <span class="sim-val" id="simDuty">LKR 400,000 (4%)</span>
                    </div>
                    <div class="sim-item" style="border-bottom: none;">
                        <span>Reservation Hold Period</span>
                        <span class="sim-val" id="simHold">14 Calendar Days</span>
                    </div>
                </div>
            </div>

            <!-- Reset to Defaults Card -->
            <div class="card">
                <div class="card-header">
                    <div class="card-title" style="color: var(--danger);">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset Policy Defaults
                    </div>
                </div>
                <p style="font-size: 0.85rem; color: var(--text-muted);">
                    Restore company legal defaults (10% deposit, 14 days hold, 4% stamp duty). This action will be recorded in the security audit trail.
                </p>
                <form action="${pageContext.request.contextPath}/admin/settings/reset" method="POST" onsubmit="return confirm('Are you sure you want to reset all business policy settings to enterprise defaults?');">
                    <button type="submit" class="btn-reset" style="width: 100%;">
                        <i class="bi bi-arrow-clockwise"></i> Reset to Enterprise Defaults
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function recalculateSimulation() {
        const depositPct = parseFloat(document.getElementById('minAdvanceDepositPercentage').value) || 10;
        const days = parseInt(document.getElementById('reservationValidityDays').value) || 14;
        const dutyPct = parseFloat(document.getElementById('defaultStampDutyPercentage').value) || 4;

        const benchmarkPrice = 10000000;
        const depositAmount = (benchmarkPrice * depositPct) / 100;
        const dutyAmount = (benchmarkPrice * dutyPct) / 100;

        document.getElementById('simDeposit').textContent = 'LKR ' + depositAmount.toLocaleString() + ' (' + depositPct + '%)';
        document.getElementById('simDuty').textContent = 'LKR ' + dutyAmount.toLocaleString() + ' (' + dutyPct + '%)';
        document.getElementById('simHold').textContent = days + ' Calendar Days';
    }

    // Initialize simulation on load
    document.addEventListener('DOMContentLoaded', recalculateSimulation);
</script>
</body>
</html>
