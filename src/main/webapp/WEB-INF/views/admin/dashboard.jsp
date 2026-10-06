<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Executive Admin Command Center - Ceylon Lands</title>
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
            --purple: #8b5cf6;
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

        .logo i {
            color: #818cf8;
            font-size: 1.6rem;
        }

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

        .nav-badge {
            margin-left: auto;
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            padding: 0.15rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.72rem;
            font-weight: 700;
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

        /* Executive Header */
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

        .system-pill {
            display: inline-flex;
            align-items: center;
            gap: 0.45rem;
            padding: 0.35rem 0.85rem;
            background: rgba(16, 185, 129, 0.1);
            color: #065f46;
            border: 1px solid rgba(16, 185, 129, 0.25);
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
        }

        .pulse-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: var(--success);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.5); }
            70% { box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
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

        /* KPI Cards Grid */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }

        .kpi-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.6rem;
            display: flex;
            flex-direction: column;
            gap: 1rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
            position: relative;
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 24px rgba(0,0,0,0.05);
        }

        .kpi-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .kpi-title {
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .kpi-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }

        .icon-indigo { background: rgba(99, 102, 241, 0.12); color: #4f46e5; }
        .icon-emerald { background: rgba(16, 185, 129, 0.12); color: #059669; }
        .icon-amber { background: rgba(245, 158, 11, 0.12); color: #d97706; }
        .icon-blue { background: rgba(2, 132, 199, 0.12); color: #0284c7; }

        .kpi-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-dark);
            letter-spacing: -0.03em;
            line-height: 1;
        }

        .kpi-breakdown {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.82rem;
            color: var(--text-muted);
            padding-top: 0.6rem;
            border-top: 1px dashed var(--border);
        }

        .kpi-chip {
            padding: 0.2rem 0.5rem;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.75rem;
        }

        .chip-success { background: rgba(16, 185, 129, 0.12); color: #059669; }
        .chip-warning { background: rgba(245, 158, 11, 0.12); color: #b45309; }
        .chip-danger { background: rgba(239, 68, 68, 0.12); color: #dc2626; }

        /* Launchpad Grid */
        .launchpad-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.25rem;
        }

        .launchpad-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.4rem;
            display: flex;
            align-items: center;
            gap: 1.2rem;
            text-decoration: none;
            color: inherit;
            transition: all 0.2s ease;
        }

        .launchpad-card:hover {
            border-color: #cbd5e1;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.04);
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
        }

        .launchpad-icon {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            flex-shrink: 0;
        }

        .launchpad-info h3 {
            font-size: 1.05rem;
            font-weight: 700;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .launchpad-info p {
            font-size: 0.82rem;
            color: var(--text-muted);
            margin-top: 0.25rem;
        }

        .launchpad-arrow {
            margin-left: auto;
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: transform 0.2s ease;
        }

        .launchpad-card:hover .launchpad-arrow {
            transform: translateX(3px);
            color: var(--primary);
        }

        /* Section Container */
        .section-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem;
            box-shadow: 0 4px 20px -2px rgba(0,0,0,0.02);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.4rem;
        }

        .section-header h2 {
            font-size: 1.25rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            letter-spacing: -0.01em;
        }

        .badge-live {
            font-size: 0.72rem;
            padding: 0.2rem 0.6rem;
            border-radius: 9999px;
            background: rgba(239, 68, 68, 0.1);
            color: #dc2626;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            display: inline-flex;
            align-items: center;
            gap: 0.35rem;
        }

        .badge-live::before {
            content: '';
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: #dc2626;
        }

        /* Audit Table with Segregated Columns */
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
            padding: 1.05rem 1rem;
            border-bottom: 1px solid var(--border);
            font-size: 0.9rem;
            vertical-align: middle;
        }

        table.audit-table tr:last-child td {
            border-bottom: none;
        }

        table.audit-table tr:hover td {
            background-color: #f8fafc;
        }

        /* Segregated Column Badges */
        .col-date {
            white-space: nowrap;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 0.45rem;
        }

        .col-date i {
            color: #6366f1;
            font-size: 0.95rem;
        }

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
            padding: 0.2rem 0.55rem;
            border-radius: 6px;
            font-size: 0.72rem;
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
            padding: 0.28rem 0.65rem;
            border-radius: 8px;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .module-property { background: #eff6ff; color: #1d4ed8; border: 1px solid #bfdbfe; }
        .module-survey { background: #f0fdfa; color: #0f766e; border: 1px solid #99f6e4; }
        .module-sales { background: #fffbeb; color: #b45309; border: 1px solid #fde68a; }
        .module-legal { background: #faf5ff; color: #7e22ce; border: 1px solid #e9d5ff; }
        .module-security { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .module-users { background: #f3e8ff; color: #6b21a8; border: 1px solid #d8b4fe; }

        .action-tag {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-size: 0.8rem;
            font-weight: 700;
            padding: 0.25rem 0.55rem;
            background: #f1f5f9;
            color: #334155;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            display: inline-block;
        }

        .desc-text {
            color: #334155;
            line-height: 1.45;
            max-width: 480px;
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

        /* -----------------------------------------------------------
           Monthly Revenue Analytics & MoM Comparison Center Styles
        ----------------------------------------------------------- */
        .analytics-container {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .analytics-hero-card {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 60%, #1e293b 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 1.8rem 2.2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 10px 25px -5px rgba(30, 27, 75, 0.3);
            position: relative;
            overflow: hidden;
        }

        .analytics-hero-card::after {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 380px;
            height: 380px;
            background: radial-gradient(circle, rgba(129, 140, 248, 0.25) 0%, rgba(30, 27, 75, 0) 70%);
            pointer-events: none;
        }

        .analytics-hero-title h2 {
            font-size: 1.5rem;
            font-weight: 800;
            letter-spacing: -0.02em;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .analytics-hero-title p {
            color: #c7d2fe;
            font-size: 0.92rem;
            margin-top: 0.35rem;
            max-width: 650px;
        }

        .analytics-hero-badge {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 0.4rem 0.9rem;
            border-radius: 9999px;
            font-size: 0.8rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #ffffff;
        }

        /* MoM Executive Metrics Cards */
        .mom-metrics-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }

        .mom-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            position: relative;
        }

        .mom-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
        }

        .mom-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .mom-card-title {
            font-size: 0.8rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .mom-card-pill {
            font-size: 0.72rem;
            font-weight: 700;
            padding: 0.18rem 0.5rem;
            border-radius: 6px;
        }

        .mom-val-primary {
            font-size: 1.65rem;
            font-weight: 800;
            color: var(--text-dark);
            letter-spacing: -0.02em;
            line-height: 1.15;
        }

        .mom-subtext {
            font-size: 0.82rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.4rem;
        }

        .growth-badge-large {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.35rem 0.75rem;
            border-radius: 10px;
            font-weight: 800;
            font-size: 1.35rem;
            letter-spacing: -0.02em;
        }

        .growth-badge-large.up {
            background: #ecfdf5;
            color: #059669;
            border: 1px solid #a7f3d0;
        }

        .growth-badge-large.down {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .growth-badge-large.flat {
            background: #f1f5f9;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

        /* Two-Column Chart & Strategic Insights Grid */
        .analytics-grid-two {
            display: grid;
            grid-template-columns: 2.1fr 1fr;
            gap: 1.5rem;
        }

        .chart-container-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem;
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chart-header h3 {
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .chart-legend-pills {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .legend-dot-revenue {
            width: 10px;
            height: 10px;
            border-radius: 3px;
            background: #4f46e5;
            display: inline-block;
        }

        .legend-dot-deals {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #f59e0b;
            display: inline-block;
        }

        .canvas-wrapper {
            position: relative;
            height: 310px;
            width: 100%;
        }

        /* Insights Card */
        .insights-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem;
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
        }

        .insights-card h3 {
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .insight-stat-box {
            background: #f8fafc;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 1.1rem;
            display: flex;
            flex-direction: column;
            gap: 0.4rem;
        }

        .insight-stat-label {
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .insight-stat-val {
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--text-dark);
        }

        .insight-bullet-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            margin-top: 0.2rem;
        }

        .insight-bullet-list li {
            font-size: 0.84rem;
            color: #334155;
            display: flex;
            align-items: flex-start;
            gap: 0.6rem;
            line-height: 1.4;
        }

        .insight-bullet-list li i {
            font-size: 1rem;
            flex-shrink: 0;
            margin-top: 0.1rem;
        }

        /* MoM Breakdown Table */
        .table-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 1.8rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.02);
        }

        .badge-growth {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            padding: 0.25rem 0.6rem;
            border-radius: 6px;
            font-weight: 700;
            font-size: 0.8rem;
        }

        .badge-growth.up { background: rgba(16, 185, 129, 0.12); color: #059669; }
        .badge-growth.down { background: rgba(239, 68, 68, 0.12); color: #dc2626; }
        .badge-growth.flat { background: rgba(100, 116, 139, 0.12); color: #475569; }
        .badge-growth.baseline { background: rgba(99, 102, 241, 0.1); color: #4f46e5; }

        .perf-badge {
            display: inline-block;
            padding: 0.25rem 0.65rem;
            border-radius: 8px;
            font-size: 0.76rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .perf-peak { background: #fef3c7; color: #92400e; border: 1px solid #fde68a; }
        .perf-strong { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .perf-positive { background: #e0e7ff; color: #3730a3; border: 1px solid #c7d2fe; }
        .perf-decline { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
        .perf-baseline { background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; }
        .perf-stable { background: #f8fafc; color: #334155; border: 1px solid #cbd5e1; }

        /* Export & Telemetry Widgets */
        .export-telemetry-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        @media (max-width: 900px) {
            .export-telemetry-grid { grid-template-columns: 1fr; }
        }

        .export-card, .telemetry-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.6rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.03);
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
        }

        .export-card-title, .telemetry-card-title {
            font-size: 1.1rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .export-actions-list {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .btn-export-csv {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0.8rem 1.1rem;
            border-radius: 10px;
            background: #f8fafc;
            border: 1.5px solid var(--border);
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .btn-export-csv:hover {
            border-color: #6366f1;
            background: rgba(99, 102, 241, 0.05);
            color: #4f46e5;
            transform: translateX(3px);
        }

        .telemetry-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 0.65rem;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.88rem;
        }

        .telemetry-label {
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.45rem;
        }

        .telemetry-val {
            font-weight: 700;
            color: var(--text-dark);
        }

        .progress-bar-bg {
            background: #e2e8f0;
            border-radius: 9999px;
            height: 10px;
            width: 100%;
            overflow: hidden;
            margin-top: 0.4rem;
        }

        .progress-bar-fill {
            background: linear-gradient(90deg, #10b981 0%, #6366f1 100%);
            height: 100%;
            border-radius: 9999px;
            transition: width 0.4s ease;
        }

        /* Print Media Styles */
        @media print {
            .sidebar, .header-actions, .launchpad-grid, .btn-action, .nav-links, .export-telemetry-grid, .section-header a {
                display: none !important;
            }
            body, .main-container {
                margin: 0 !important;
                padding: 0.8cm !important;
                background: #fff !important;
                color: #000 !important;
            }
            .kpi-grid {
                grid-template-columns: repeat(4, 1fr) !important;
            }
            .kpi-card, .section-card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
        }
    </style>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        <li class="active">
            <a href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-grid-1x2-fill"></i>
                <span>Executive Hub</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/audit">
                <i class="bi bi-clock-history"></i>
                <span>Audit Trail Log</span>
                <span class="nav-badge">${totalAuditLogsCount}</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/users">
                <i class="bi bi-people-fill"></i>
                <span>User Management</span>
                <span class="nav-badge">${totalUsers}</span>
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

    <!-- Executive Header -->
    <div class="header-section">
        <div class="header-title">
            <h1>
                <span>Executive Command Center</span>
                <span class="system-pill">
                        <span class="pulse-dot"></span>
                        <span>MySQL Database Active & Operational</span>
                    </span>
            </h1>
            <p>Enterprise Oversight, Real-Time Audit Telemetry, and Cross-Department Governance.</p>
        </div>
        <div class="header-actions" style="display: flex; align-items: center; gap: 0.75rem;">
            <jsp:include page="/WEB-INF/views/common/notification-bell.jsp" />
            <button type="button" onclick="window.print()" class="btn-action btn-action-outline" title="Print Executive Briefing or Save as PDF">
                <i class="bi bi-printer-fill"></i>
                <span>Print Briefing</span>
            </button>
            <a href="${pageContext.request.contextPath}/admin/audit" class="btn-action btn-action-primary">
                <i class="bi bi-clock-history"></i>
                <span>Audit Explorer</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn-action btn-action-outline">
                <i class="bi bi-person-plus-fill"></i>
                <span>Manage Users</span>
            </a>
        </div>
    </div>

    <!-- KPI Cards Grid -->
    <div class="kpi-grid">
        <!-- 1. Audit Trail Total -->
        <div class="kpi-card">
            <div class="kpi-top">
                <span class="kpi-title">Audit Trail Events</span>
                <div class="kpi-icon icon-indigo">
                    <i class="bi bi-journal-text"></i>
                </div>
            </div>
            <div class="kpi-value">${totalAuditLogsCount}</div>
            <div class="kpi-breakdown">
                <span class="kpi-chip chip-success">+${todayAuditLogsCount} Today</span>
                <span>Immutable Audit Log</span>
            </div>
        </div>

        <!-- 2. Properties Portfolio -->
        <div class="kpi-card">
            <div class="kpi-top">
                <span class="kpi-title">Land Plot Portfolio</span>
                <div class="kpi-icon icon-emerald">
                    <i class="bi bi-map-fill"></i>
                </div>
            </div>
            <div class="kpi-value">${totalProperties}</div>
            <div class="kpi-breakdown">
                <span class="kpi-chip chip-success">${availableProperties} Available</span>
                <span class="kpi-chip chip-warning">${reservedProperties} Reserved</span>
                <span class="kpi-chip chip-danger">${soldProperties} Sold</span>
            </div>
        </div>

        <!-- 3. System Accounts -->
        <div class="kpi-card">
            <div class="kpi-top">
                <span class="kpi-title">Active System Users</span>
                <div class="kpi-icon icon-blue">
                    <i class="bi bi-person-badge-fill"></i>
                </div>
            </div>
            <div class="kpi-value">${totalUsers}</div>
            <div class="kpi-breakdown">
                <span class="kpi-chip chip-success">${totalCustomers} Customers</span>
                <span>RBAC Governed</span>
            </div>
        </div>

        <!-- 4. Revenue & Valuation -->
        <div class="kpi-card">
            <div class="kpi-top">
                <span class="kpi-title">Total Sales Turnover</span>
                <div class="kpi-icon icon-amber">
                    <i class="bi bi-cash-stack"></i>
                </div>
            </div>
            <div class="kpi-value" style="font-size: 1.5rem;">
                LKR <fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0" />
            </div>
            <div class="kpi-breakdown">
                <span class="kpi-chip chip-success">${sales.size()} Transactions</span>
                <span>Completed / Active</span>
            </div>
        </div>
    </div>

    <!-- ========================================================= -->
    <!-- EXECUTIVE REVENUE INTELLIGENCE & MoM COMPARISON CENTER    -->
    <!-- ========================================================= -->
    <div class="analytics-container">

        <!-- Hero Header Bar -->
        <div class="analytics-hero-card">
            <div class="analytics-hero-title">
                <h2>
                    <i class="bi bi-graph-up-arrow" style="color: #a5b4fc;"></i>
                    <span>Monthly Revenue & Month-over-Month (MoM) Analytics</span>
                </h2>
                <p>Track multi-month turnover trajectories, compare recent volume shifts, and evaluate transaction ticket sizes to power executive capital decisions.</p>
            </div>
            <div class="analytics-hero-badge">
                <span class="pulse-dot" style="background-color: #34d399; box-shadow: 0 0 0 3px rgba(52, 211, 153, 0.3);"></span>
                <span>Tracking Period: ${currentMonthLabel}</span>
            </div>
        </div>

        <!-- MoM Executive Metric Cards -->
        <div class="mom-metrics-grid">

            <!-- 1. Current Month Revenue -->
            <div class="mom-card">
                <div class="mom-card-header">
                    <span class="mom-card-title">This Month (${currentMonthLabel})</span>
                    <span class="mom-card-pill chip-success">Current Period</span>
                </div>
                <div class="mom-val-primary">
                    LKR <fmt:formatNumber value="${currentMonthRevenue}" type="number" maxFractionDigits="0"/>
                </div>
                <div class="mom-subtext">
                    <i class="bi bi-check2-circle" style="color: #10b981;"></i>
                    <span><strong>${currentMonthDeals}</strong> Closed Transactions</span>
                </div>
            </div>

            <!-- 2. Prior Month Benchmark -->
            <div class="mom-card">
                <div class="mom-card-header">
                    <span class="mom-card-title">Prior Month (${lastMonthLabel})</span>
                    <span class="mom-card-pill" style="background: rgba(99, 102, 241, 0.1); color: #4f46e5;">Benchmark</span>
                </div>
                <div class="mom-val-primary">
                    LKR <fmt:formatNumber value="${lastMonthRevenue}" type="number" maxFractionDigits="0"/>
                </div>
                <div class="mom-subtext">
                    <i class="bi bi-calendar-check" style="color: #6366f1;"></i>
                    <span><strong>${lastMonthDeals}</strong> Closed Transactions</span>
                </div>
            </div>

            <!-- 3. MoM Growth Velocity -->
            <div class="mom-card">
                <div class="mom-card-header">
                    <span class="mom-card-title">MoM Growth Velocity</span>
                    <span class="mom-card-pill" style="background: rgba(245, 158, 11, 0.12); color: #b45309;">Turnover Rate</span>
                </div>
                <div>
                    <c:choose>
                        <c:when test="${momGrowthDirection == 'UP'}">
                            <div class="growth-badge-large up">
                                <i class="bi bi-arrow-up-right-circle-fill"></i>
                                <span>+<fmt:formatNumber value="${momGrowthPercentage}" maxFractionDigits="1"/>%</span>
                            </div>
                        </c:when>
                        <c:when test="${momGrowthDirection == 'DOWN'}">
                            <div class="growth-badge-large down">
                                <i class="bi bi-arrow-down-right-circle-fill"></i>
                                <span><fmt:formatNumber value="${momGrowthPercentage}" maxFractionDigits="1"/>%</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="growth-badge-large flat">
                                <i class="bi bi-dash-circle-fill"></i>
                                <span>0.0%</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="mom-subtext">
                    <c:choose>
                        <c:when test="${momDifference >= 0}">
                            <span style="color: #059669; font-weight: 700;">+ LKR <fmt:formatNumber value="${momDifference}" maxFractionDigits="0"/></span> vs prior month
                        </c:when>
                        <c:otherwise>
                            <span style="color: #dc2626; font-weight: 700;">- LKR <fmt:formatNumber value="${-momDifference}" maxFractionDigits="0"/></span> vs prior month
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 4. Average Ticket Size & Peak -->
            <div class="mom-card">
                <div class="mom-card-header">
                    <span class="mom-card-title">Average Deal Ticket</span>
                    <span class="mom-card-pill" style="background: #fef3c7; color: #92400e;">Portfolio Metric</span>
                </div>
                <div class="mom-val-primary" style="font-size: 1.5rem;">
                    LKR <fmt:formatNumber value="${averageDealSizeOverall}" type="number" maxFractionDigits="0"/>
                </div>
                <div class="mom-subtext">
                    <i class="bi bi-trophy-fill" style="color: #f59e0b;"></i>
                    <span>Peak: <strong>${peakMonthLabel}</strong> (LKR <fmt:formatNumber value="${peakRevenue}" maxFractionDigits="0"/>)</span>
                </div>
            </div>

        </div>

        <!-- Two-Column Chart & Decision Insights -->
        <div class="analytics-grid-two">

            <!-- Left: Chart.js Bar & Line Graph -->
            <div class="chart-container-card">
                <div class="chart-header">
                    <h3>
                        <i class="bi bi-bar-chart-line-fill" style="color: var(--primary);"></i>
                        <span>Monthly Turnover & Deal Trajectory</span>
                    </h3>
                    <div class="chart-legend-pills">
                        <span><span class="legend-dot-revenue"></span> Revenue (LKR)</span>
                        <span><span class="legend-dot-deals"></span> Closed Deals</span>
                    </div>
                </div>
                <div class="canvas-wrapper">
                    <canvas id="monthlyRevenueChart"></canvas>
                </div>
            </div>

            <!-- Right: Decision Strategic Insights -->
            <div class="insights-card">
                <h3>
                    <i class="bi bi-lightbulb-fill" style="color: #f59e0b;"></i>
                    <span>Executive Decision Center</span>
                </h3>

                <div class="insight-stat-box">
                    <span class="insight-stat-label">Current Fiscal Velocity</span>
                    <div class="insight-stat-val">
                        LKR <fmt:formatNumber value="${currentMonthRevenue}" maxFractionDigits="0"/>
                    </div>
                    <span style="font-size: 0.78rem; color: #64748b;">
                            Across ${currentMonthDeals} active transactions in ${currentMonthLabel}
                        </span>
                </div>

                <div class="insight-stat-box">
                    <span class="insight-stat-label">Portfolio Ticket Average</span>
                    <div class="insight-stat-val">
                        LKR <fmt:formatNumber value="${averageDealSizeCurrentMonth > 0 ? averageDealSizeCurrentMonth : averageDealSizeOverall}" maxFractionDigits="0"/>
                    </div>
                    <span style="font-size: 0.78rem; color: #64748b;">
                            Average capitalization per plot agreement
                        </span>
                </div>

                <ul class="insight-bullet-list">
                    <li>
                        <i class="bi bi-shield-check" style="color: #10b981;"></i>
                        <span><strong>Capital Allocation:</strong> Compare past peak months against current run-rate to time project investments.</span>
                    </li>
                    <li>
                        <i class="bi bi-arrow-repeat" style="color: #6366f1;"></i>
                        <span><strong>Pipeline Pacing:</strong> Fast-track legal conveyancing for pending inquiries to accelerate monthly closures.</span>
                    </li>
                </ul>
            </div>

        </div>

        <!-- Performance Breakdown Decision Table -->
        <div class="table-card">
            <div class="section-header" style="margin-bottom: 1.2rem;">
                <h2>
                    <i class="bi bi-table" style="color: var(--primary);"></i>
                    <span>Month-over-Month Performance Decision Breakdown</span>
                </h2>
                <span style="font-size: 0.85rem; color: var(--text-muted); font-weight: 600;">
                        Historical Ledger: ${monthlySummaries.size()} Periods Analyzed
                    </span>
            </div>

            <div class="table-responsive">
                <table class="audit-table">
                    <thead>
                    <tr>
                        <th>Fiscal Month</th>
                        <th style="text-align: center;">Closed Deals</th>
                        <th>Monthly Revenue (LKR)</th>
                        <th>Average Ticket Size (LKR)</th>
                        <th style="text-align: center;">MoM Growth (%)</th>
                        <th>Net MoM Variance</th>
                        <th>Performance Tier</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${monthlySummaries}">
                        <tr>
                            <!-- 1. Month -->
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.6rem;">
                                    <i class="bi bi-calendar3" style="color: var(--primary); font-size: 1rem;"></i>
                                    <div>
                                        <div style="font-weight: 800; color: var(--text-dark);">${item.monthFullName}</div>
                                        <div style="font-size: 0.75rem; color: #94a3b8;">${item.monthLabel}</div>
                                    </div>
                                    <c:if test="${item.peak}">
                                        <span class="kpi-chip chip-warning" style="margin-left: 0.4rem;"><i class="bi bi-star-fill"></i> Peak</span>
                                    </c:if>
                                </div>
                            </td>

                            <!-- 2. Closed Deals -->
                            <td style="text-align: center;">
                                        <span class="kpi-chip chip-success" style="font-size: 0.85rem; padding: 0.25rem 0.65rem;">
                                            ${item.dealsCount} ${item.dealsCount == 1 ? 'Deal' : 'Deals'}
                                        </span>
                            </td>

                            <!-- 3. Revenue -->
                            <td>
                                        <span style="font-weight: 800; font-size: 0.98rem; color: #0f172a;">
                                            LKR <fmt:formatNumber value="${item.revenue}" type="number" maxFractionDigits="0"/>
                                        </span>
                            </td>

                            <!-- 4. Average Ticket Size -->
                            <td>
                                        <span style="font-weight: 600; color: #475569;">
                                            LKR <fmt:formatNumber value="${item.averageDealSize}" type="number" maxFractionDigits="0"/>
                                        </span>
                            </td>

                            <!-- 5. MoM Growth % -->
                            <td style="text-align: center;">
                                <c:choose>
                                    <c:when test="${item.growthDirection == 'UP'}">
                                                <span class="badge-growth up">
                                                    <i class="bi bi-arrow-up-right"></i>
                                                    +<fmt:formatNumber value="${item.growthPercentage}" maxFractionDigits="1"/>%
                                                </span>
                                    </c:when>
                                    <c:when test="${item.growthDirection == 'DOWN'}">
                                                <span class="badge-growth down">
                                                    <i class="bi bi-arrow-down-right"></i>
                                                    <fmt:formatNumber value="${item.growthPercentage}" maxFractionDigits="1"/>%
                                                </span>
                                    </c:when>
                                    <c:when test="${item.growthDirection == 'FLAT'}">
                                                <span class="badge-growth flat">
                                                    <i class="bi bi-dash"></i> 0.0%
                                                </span>
                                    </c:when>
                                    <c:otherwise>
                                                <span class="badge-growth baseline">
                                                    <i class="bi bi-record-circle"></i> Baseline
                                                </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- 6. Net Variance -->
                            <td>
                                <c:choose>
                                    <c:when test="${item.growthDifference != null and item.growthDifference > 0}">
                                                <span style="color: #059669; font-weight: 700;">
                                                    + LKR <fmt:formatNumber value="${item.growthDifference}" maxFractionDigits="0"/>
                                                </span>
                                    </c:when>
                                    <c:when test="${item.growthDifference != null and item.growthDifference < 0}">
                                                <span style="color: #dc2626; font-weight: 700;">
                                                    - LKR <fmt:formatNumber value="${-item.growthDifference}" maxFractionDigits="0"/>
                                                </span>
                                    </c:when>
                                    <c:when test="${item.growthDifference != null and item.growthDifference == 0}">
                                        <span style="color: #64748b; font-weight: 600;">LKR 0</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #94a3b8; font-weight: 500;">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- 7. Classification Badge -->
                            <td>
                                <c:choose>
                                    <c:when test="${item.statusBadge == 'Peak Performance'}">
                                        <span class="perf-badge perf-peak"><i class="bi bi-trophy"></i> Peak Performance</span>
                                    </c:when>
                                    <c:when test="${item.statusBadge == 'Strong Growth'}">
                                        <span class="perf-badge perf-strong"><i class="bi bi-graph-up"></i> Strong Growth</span>
                                    </c:when>
                                    <c:when test="${item.statusBadge == 'Positive'}">
                                        <span class="perf-badge perf-positive"><i class="bi bi-arrow-up"></i> Positive Growth</span>
                                    </c:when>
                                    <c:when test="${item.statusBadge == 'Volume Decline'}">
                                        <span class="perf-badge perf-decline"><i class="bi bi-arrow-down"></i> Contraction</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="perf-badge perf-baseline"><i class="bi bi-compass"></i> Baseline Period</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr style="background: #f8fafc; font-weight: 800; border-top: 2px solid var(--border);">
                        <td>Cumulative Summary</td>
                        <td style="text-align: center;">
                            <span class="kpi-chip chip-success">${sales.size()} Total Deals</span>
                        </td>
                        <td>
                            LKR <fmt:formatNumber value="${totalRevenue}" maxFractionDigits="0"/>
                        </td>
                        <td>
                            LKR <fmt:formatNumber value="${averageDealSizeOverall}" maxFractionDigits="0"/> (Overall Avg)
                        </td>
                        <td colspan="3" style="color: #64748b; font-size: 0.85rem; font-weight: 600;">
                            All active & completed transactions tracked
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>

    </div>

    <!-- Sub-System Fast Launchpad -->
    <div class="launchpad-grid">
        <a href="${pageContext.request.contextPath}/admin/audit" class="launchpad-card">
            <div class="launchpad-icon icon-indigo">
                <i class="bi bi-shield-check"></i>
            </div>
            <div class="launchpad-info">
                <h3>Audit Explorer</h3>
                <p>Track who did what, exact time, date, and module actions.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/property" class="launchpad-card">
            <div class="launchpad-icon icon-emerald">
                <i class="bi bi-building"></i>
            </div>
            <div class="launchpad-info">
                <h3>Property Management</h3>
                <p>Oversee land plots, photo uploads, specifications, and pricing.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/survey" class="launchpad-card">
            <div class="launchpad-icon icon-blue">
                <i class="bi bi-geo-alt-fill"></i>
            </div>
            <div class="launchpad-info">
                <h3>Survey & Valuation</h3>
                <p>Boundary verification, zoning compliance, and surveyor dossiers.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/sales" class="launchpad-card">
            <div class="launchpad-icon icon-amber">
                <i class="bi bi-currency-dollar"></i>
            </div>
            <div class="launchpad-info">
                <h3>Sales & Reservations</h3>
                <p>Approve inquiries, track customer advance payments, unlock legal.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/legal" class="launchpad-card">
            <div class="launchpad-icon" style="background: rgba(168, 85, 247, 0.12); color: #9333ea;">
                <i class="bi bi-file-earmark-ruled-fill"></i>
            </div>
            <div class="launchpad-info">
                <h3>Legal Conveyancing</h3>
                <p>Title search clearance, Deed of Transfer drafting, and registry certificates.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/admin/users" class="launchpad-card">
            <div class="launchpad-icon" style="background: rgba(236, 72, 153, 0.12); color: #db2777;">
                <i class="bi bi-person-gear"></i>
            </div>
            <div class="launchpad-info">
                <h3>User & Access Control</h3>
                <p>Manage operators across Admin, Property, Survey, Sales, and Legal.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>

        <a href="${pageContext.request.contextPath}/admin/settings" class="launchpad-card">
            <div class="launchpad-icon" style="background: rgba(99, 102, 241, 0.12); color: #6366f1;">
                <i class="bi bi-gear-wide-connected"></i>
            </div>
            <div class="launchpad-info">
                <h3>System Policies</h3>
                <p>Corporate profile, advance deposit %, reservation hold days, and platform switches.</p>
            </div>
            <i class="bi bi-chevron-right launchpad-arrow"></i>
        </a>
    </div>

    <!-- Executive Data Export & System Telemetry Diagnostics -->
    <div class="export-telemetry-grid">
        <!-- 1. Enterprise Data Export Center -->
        <div class="export-card">
            <div class="export-card-title">
                <i class="bi bi-file-earmark-spreadsheet-fill" style="color: #10b981;"></i>
                <span>Executive Data Export &amp; Reporting Center</span>
            </div>
            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: -0.4rem;">
                Download real-time enterprise ledgers and datasets formatted for external audits, spreadsheets, and board reviews.
            </p>

            <div class="export-actions-list">
                <a href="${pageContext.request.contextPath}/admin/export/sales.csv" class="btn-export-csv">
                    <div style="display: flex; align-items: center; gap: 0.6rem;">
                        <i class="bi bi-file-earmark-bar-graph" style="color: #4f46e5; font-size: 1.15rem;"></i>
                        <div>
                            <div>Sales &amp; Revenue Ledger</div>
                            <div style="font-size: 0.75rem; color: var(--text-muted); font-weight: 400;">All property transactions, deed numbers, and deal prices</div>
                        </div>
                    </div>
                    <span style="font-size: 0.8rem; background: #e0e7ff; color: #4338ca; padding: 0.2rem 0.5rem; border-radius: 6px; font-weight: 700;">CSV</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/export/properties.csv" class="btn-export-csv">
                    <div style="display: flex; align-items: center; gap: 0.6rem;">
                        <i class="bi bi-building" style="color: #059669; font-size: 1.15rem;"></i>
                        <div>
                            <div>Land Inventory &amp; Valuations</div>
                            <div style="font-size: 0.75rem; color: var(--text-muted); font-weight: 400;">Full catalog of parcels, sizes, pricing, and availability</div>
                        </div>
                    </div>
                    <span style="font-size: 0.8rem; background: #d1fae5; color: #065f46; padding: 0.2rem 0.5rem; border-radius: 6px; font-weight: 700;">CSV</span>
                </a>

                <a href="${pageContext.request.contextPath}/admin/export/audit-logs.csv" class="btn-export-csv">
                    <div style="display: flex; align-items: center; gap: 0.6rem;">
                        <i class="bi bi-shield-lock" style="color: #d97706; font-size: 1.15rem;"></i>
                        <div>
                            <div>Security Audit Trail Log</div>
                            <div style="font-size: 0.75rem; color: var(--text-muted); font-weight: 400;">Chronological staff activity timestamps, IPs, and events</div>
                        </div>
                    </div>
                    <span style="font-size: 0.8rem; background: #fef3c7; color: #92400e; padding: 0.2rem 0.5rem; border-radius: 6px; font-weight: 700;">CSV</span>
                </a>
            </div>
        </div>

        <!-- 2. System Health & Server Telemetry -->
        <div class="telemetry-card">
            <div class="telemetry-card-title">
                <i class="bi bi-cpu-fill" style="color: #6366f1;"></i>
                <span>System Health &amp; Server Telemetry</span>
            </div>
            <p style="font-size: 0.85rem; color: var(--text-muted); margin-top: -0.4rem;">
                Real-time runtime telemetry and database connectivity health monitoring.
            </p>

            <div style="display: flex; flex-direction: column; gap: 0.85rem;">
                <div>
                    <div style="display: flex; justify-content: space-between; font-size: 0.85rem; font-weight: 600;">
                        <span class="telemetry-label"><i class="bi bi-memory"></i> JVM Heap Allocation</span>
                        <span class="telemetry-val">${jvmUsedMemory} MB / ${jvmTotalMemory} MB (${jvmMemoryPercent}%)</span>
                    </div>
                    <div class="progress-bar-bg">
                        <div class="progress-bar-fill" style="width: ${jvmMemoryPercent}%;"></div>
                    </div>
                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.25rem;">Max Heap Allocation: ${jvmMaxMemory} MB</div>
                </div>

                <div class="telemetry-row">
                    <span class="telemetry-label"><i class="bi bi-database-check"></i> Database Engine</span>
                    <span class="telemetry-val" style="color: #059669;"><i class="bi bi-check-circle-fill"></i> MySQL 8.0 (Operational)</span>
                </div>

                <div class="telemetry-row">
                    <span class="telemetry-label"><i class="bi bi-shield-fill-check"></i> Security Architecture</span>
                    <span class="telemetry-val" style="color: #4f46e5;">Spring Security 6.x (BCrypt Enabled)</span>
                </div>

                <div class="telemetry-row">
                    <span class="telemetry-label"><i class="bi bi-terminal"></i> Host Environment</span>
                    <span class="telemetry-val" style="font-size: 0.8rem;">Java ${javaVersion} (${osName})</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Audit Log Feed with Segregated Columns -->
    <div class="section-card">
        <div class="section-header">
            <h2>
                <i class="bi bi-clock-history" style="color: var(--primary);"></i>
                <span>Real-Time Audit Activity Feed</span>
                <span class="badge-live">Live Stream</span>
            </h2>
            <a href="${pageContext.request.contextPath}/admin/audit" class="btn-action btn-action-outline" style="padding: 0.5rem 1rem; font-size: 0.85rem;">
                <span>View All (${totalAuditLogsCount})</span>
                <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <div class="table-responsive">
            <table class="audit-table">
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
                <c:forEach var="log" items="${recentAuditLogs}">
                    <tr>
                        <!-- 1. Date (Kawadda) -->
                        <td>
                            <div class="col-date">
                                <i class="bi bi-calendar3"></i>
                                <span>${log.formattedDate}</span>
                            </div>
                        </td>

                        <!-- 2. Time (Keeyatada) -->
                        <td>
                            <div class="col-time">
                                <div class="time-exact">${log.formattedTime}</div>
                                <div class="time-relative">${log.relativeTime}</div>
                            </div>
                        </td>

                        <!-- 3. Operator (Kauda) -->
                        <td>
                            <div class="operator-cell">
                                <div class="operator-avatar">${log.username.substring(0, 1).toUpperCase()}</div>
                                <div>
                                    <div class="operator-name">${log.username}</div>
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
                                    <span class="module-badge module-property"><i class="bi bi-building"></i> Property</span>
                                </c:when>
                                <c:when test="${log.module == 'Survey' or log.module == 'SURVEY'}">
                                    <span class="module-badge module-survey"><i class="bi bi-geo-alt-fill"></i> Survey</span>
                                </c:when>
                                <c:when test="${log.module == 'Sales' or log.module == 'SALES'}">
                                    <span class="module-badge module-sales"><i class="bi bi-currency-dollar"></i> Sales</span>
                                </c:when>
                                <c:when test="${log.module == 'Legal' or log.module == 'LEGAL'}">
                                    <span class="module-badge module-legal"><i class="bi bi-file-earmark-text"></i> Legal</span>
                                </c:when>
                                <c:when test="${log.module == 'USER_MANAGEMENT'}">
                                    <span class="module-badge module-users"><i class="bi bi-people-fill"></i> Users</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="module-badge module-security"><i class="bi bi-shield-fill"></i> ${log.module}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <!-- 5. Action -->
                        <td>
                            <span class="action-tag">${log.action}</span>
                        </td>

                        <!-- 6. Details -->
                        <td>
                            <div class="desc-text">${log.description}</div>
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
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Chart.js Revenue Trend Script -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const chartCanvas = document.getElementById('monthlyRevenueChart');
        if (chartCanvas) {
            const labels = ${chartLabelsJson};
            const revenueData = ${chartRevenueJson};
            const dealsData = ${chartDealsJson};

            new Chart(chartCanvas, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            type: 'bar',
                            label: 'Monthly Revenue (LKR)',
                            data: revenueData,
                            backgroundColor: 'rgba(79, 70, 229, 0.82)',
                            hoverBackgroundColor: 'rgba(67, 56, 202, 0.95)',
                            borderRadius: 8,
                            borderSkipped: false,
                            maxBarThickness: 44,
                            order: 2,
                            yAxisID: 'y'
                        },
                        {
                            type: 'line',
                            label: 'Closed Deals Count',
                            data: dealsData,
                            borderColor: '#f59e0b',
                            backgroundColor: '#f59e0b',
                            borderWidth: 3,
                            pointBackgroundColor: '#ffffff',
                            pointBorderColor: '#d97706',
                            pointBorderWidth: 2.5,
                            pointRadius: 5.5,
                            pointHoverRadius: 8,
                            tension: 0.35,
                            order: 1,
                            yAxisID: 'y1'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        mode: 'index',
                        intersect: false
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: '#0f172a',
                            titleFont: { family: "'Plus Jakarta Sans', sans-serif", weight: '700', size: 13 },
                            bodyFont: { family: "'Plus Jakarta Sans', sans-serif", size: 12 },
                            padding: 12,
                            cornerRadius: 10,
                            displayColors: true,
                            boxPadding: 6,
                            callbacks: {
                                label: function(context) {
                                    if (context.dataset.yAxisID === 'y') {
                                        return ' Turnover: LKR ' + Number(context.raw).toLocaleString('en-US', { maximumFractionDigits: 0 });
                                    } else {
                                        return ' Closed Deals: ' + context.raw + ' transactions';
                                    }
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: {
                                font: { family: "'Plus Jakarta Sans', sans-serif", weight: '600', size: 12 },
                                color: '#64748b'
                            }
                        },
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            grid: { color: '#f1f5f9' },
                            ticks: {
                                font: { family: "'Plus Jakarta Sans', sans-serif", size: 11 },
                                color: '#64748b',
                                callback: function(value) {
                                    if (value >= 1000000) {
                                        return 'LKR ' + (value / 1000000).toFixed(1) + 'M';
                                    } else if (value >= 1000) {
                                        return 'LKR ' + (value / 1000).toFixed(0) + 'K';
                                    }
                                    return 'LKR ' + value;
                                }
                            }
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            grid: { drawOnChartArea: false },
                            ticks: {
                                precision: 0,
                                font: { family: "'Plus Jakarta Sans', sans-serif", weight: '600', size: 11 },
                                color: '#d97706',
                                callback: function(value) {
                                    return value + ' deals';
                                }
                            }
                        }
                    }
                }
            });
        }
    });
</script>
</body>
</html>
