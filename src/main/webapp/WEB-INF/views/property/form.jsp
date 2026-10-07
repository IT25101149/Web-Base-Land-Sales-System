<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Property - Land Sales System</title>
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
            margin-bottom: 2rem;
        }

        header h1 {
            font-size: 1.75rem;
            font-weight: 700;
        }

        /* Form Container */
        .form-card {
            background: var(--card-bg);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 2.5rem;
            max-width: 600px;
            box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05);
        }

        .form-group {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        label {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-dark);
        }

        input[type="text"], input[type="number"], textarea, select {
            padding: 0.75rem 1rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
            outline: none;
            transition: border-color 0.2s ease;
        }

        input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
            border-color: var(--primary);
        }

        .btn-submit {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.2s ease;
        }

        .btn-submit:hover {
            background-color: var(--primary-hover);
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
        <c:choose>
            <c:when test="${pageContext.request.isUserInRole('ROLE_PROPERTY') or pageContext.request.isUserInRole('ROLE_PROPERTY_MANAGER')}">
                <li><a href="${pageContext.request.contextPath}/property"><i class="bi bi-grid-1x2-fill"></i> Property Dashboard</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${pageContext.request.contextPath}/"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a></li>
            </c:otherwise>
        </c:choose>

        <li class="active"><a href="${pageContext.request.contextPath}/property"><i class="bi bi-map-fill"></i> Properties</a></li>

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
        <h1>${property.id != null ? 'Edit Property Plot #' : 'Add New Property / Land'}${property.id != null ? property.id : ''}</h1>
        <p style="color: var(--text-muted); font-size: 0.9rem;">
            ${property.id != null ? 'Update plot details, pricing, or change status between Available, Reserved, and Sold.' : 'Register a new land plot to the system catalog.'}
        </p>
    </header>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/property/save" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${property.id}">

            <div class="form-group">
                <label for="title">Property Title / Land Project</label>
                <input type="text" id="title" name="title" required value="${property.title}" placeholder="e.g. Green Valley Estate - Plot B">
            </div>

            <div class="form-group">
                <label for="location">Location / Address</label>
                <input type="text" id="location" name="location" required value="${property.location}" placeholder="e.g. Kandy">
            </div>

            <div class="form-group">
                <label for="size">Size (Perches)</label>
                <input type="number" id="size" name="size" step="0.1" required value="${property.size}" placeholder="e.g. 15.0">
            </div>

            <div class="form-group">
                <label for="price">Price (LKR)</label>
                <input type="number" id="price" name="price" step="0.01" required value="${property.price}" placeholder="e.g. 5000000.00">
            </div>

            <!-- Property 5-Photo Upload Studio -->
            <div class="form-group" style="background: #f8fafc; border: 1px solid #cbd5e1; border-radius: 16px; padding: 1.5rem; margin-bottom: 1.5rem;">
                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 0.75rem; flex-wrap: wrap; gap: 0.5rem;">
                    <div>
                        <label style="display: flex; align-items: center; gap: 0.5rem; font-size: 1.05rem; font-weight: 800; color: var(--text-dark); margin: 0;">
                            <i class="bi bi-images" style="color: var(--primary); font-size: 1.25rem;"></i> Property Photo Gallery Studio (Up to 5 Photos)
                        </label>
                        <span style="font-size: 0.82rem; color: var(--text-muted); display: block; margin-top: 0.2rem;">
                                Upload up to 5 high-resolution photos for this land plot (Cover photo + 4 gallery angles).
                            </span>
                    </div>
                    <span style="font-size: 0.78rem; color: #4338ca; font-weight: 700; background: #e0e7ff; padding: 0.3rem 0.75rem; border-radius: 20px;">
                            <i class="bi bi-camera-fill"></i> 5 Slots Supported
                        </span>
                </div>

                <!-- Batch Multi-File Dropzone -->
                <div id="batchDropzone" onclick="triggerBatchSelect()" style="cursor: pointer; border: 2px dashed #94a3b8; border-radius: 12px; padding: 1.25rem 1rem; text-align: center; background: #ffffff; transition: all 0.2s ease; margin-bottom: 1.25rem;">
                    <input type="file" id="batchImageFiles" name="batchImageFiles" accept=".jpg,.jpeg,.png,.webp,.jfif" multiple style="display: none;" onchange="handleBatchFileSelect(event)">
                    <i class="bi bi-cloud-arrow-up-fill" style="font-size: 2rem; color: var(--primary); display: block; margin-bottom: 0.35rem;"></i>
                    <strong style="color: var(--text-dark); font-size: 0.95rem; display: block;">Click to batch-upload or drag & drop multiple photos (Up to 5)</strong>
                    <span style="color: var(--text-muted); font-size: 0.8rem; display: block; margin-top: 0.2rem;">Select up to 5 photos at once to auto-populate the slots below, or choose individual photos for each slot.</span>
                </div>

                <!-- 5 Photo Slots Grid -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <!-- Slot 1: Primary Cover Photo -->
                    <div class="photo-slot-card" style="background: #ffffff; border: 2px solid ${not empty property.imageUrl ? '#10b981' : '#cbd5e1'}; border-radius: 12px; padding: 0.85rem; display: flex; flex-direction: column; gap: 0.6rem; position: relative;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.78rem; font-weight: 800; color: #0b5e28; text-transform: uppercase;"><i class="bi bi-star-fill" style="color: #f59e0b;"></i> Photo 1 (Cover)</span>
                            <span id="slotBadge1" style="font-size: 0.7rem; font-weight: 700; color: ${not empty property.imageUrl ? '#059669' : '#94a3b8'};">
                                ${not empty property.imageUrl ? 'Active' : 'Empty'}
                            </span>
                        </div>
                        <div style="width: 100%; height: 110px; border-radius: 8px; overflow: hidden; background: #f1f5f9; position: relative;">
                            <img id="previewImg1" src="${not empty property.imageUrl ? property.imageUrl : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="Slot 1" style="width: 100%; height: 110px; object-fit: cover; opacity: ${not empty property.imageUrl ? '1' : '0.4'};">
                        </div>
                        <input type="file" id="imageFile1" name="imageFile" accept=".jpg,.jpeg,.png,.webp,.jfif" style="display: none;" onchange="handleSlotFile(event, 1)">
                        <div style="display: flex; gap: 0.35rem;">
                            <button type="button" onclick="triggerSlot(1)" style="flex: 1; background: #e0e7ff; color: #4338ca; border: none; padding: 0.4rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-upload"></i> ${not empty property.imageUrl ? 'Replace' : 'Upload'}
                            </button>
                            <button type="button" onclick="clearSlot(1)" title="Clear photo" style="background: #fee2e2; color: #dc2626; border: none; padding: 0.4rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                        <a href="javascript:void(0)" onclick="toggleSlotUrl(1)" style="font-size: 0.72rem; color: var(--primary); text-decoration: none; font-weight: 600; text-align: center;">
                            <i class="bi bi-link-45deg"></i> Custom URL
                        </a>
                        <div id="urlBox1" style="display: none; margin-top: 0.2rem;">
                            <input type="text" id="imageUrl1" name="imageUrl" value="${property.imageUrl}" placeholder="https://..." style="width: 100%; padding: 0.35rem 0.5rem; border: 1px solid var(--border); border-radius: 6px; font-size: 0.75rem;" oninput="handleSlotUrl(1, this.value)">
                        </div>
                    </div>

                    <!-- Slot 2: Plot View -->
                    <div class="photo-slot-card" style="background: #ffffff; border: 2px solid ${not empty property.imageUrl2 ? '#10b981' : '#cbd5e1'}; border-radius: 12px; padding: 0.85rem; display: flex; flex-direction: column; gap: 0.6rem; position: relative;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.78rem; font-weight: 800; color: #475569; text-transform: uppercase;">Photo 2 (Plot View)</span>
                            <span id="slotBadge2" style="font-size: 0.7rem; font-weight: 700; color: ${not empty property.imageUrl2 ? '#059669' : '#94a3b8'};">
                                ${not empty property.imageUrl2 ? 'Active' : 'Empty'}
                            </span>
                        </div>
                        <div style="width: 100%; height: 110px; border-radius: 8px; overflow: hidden; background: #f1f5f9; position: relative;">
                            <img id="previewImg2" src="${not empty property.imageUrl2 ? property.imageUrl2 : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="Slot 2" style="width: 100%; height: 110px; object-fit: cover; opacity: ${not empty property.imageUrl2 ? '1' : '0.4'};">
                        </div>
                        <input type="file" id="imageFile2" name="imageFile2" accept=".jpg,.jpeg,.png,.webp,.jfif" style="display: none;" onchange="handleSlotFile(event, 2)">
                        <div style="display: flex; gap: 0.35rem;">
                            <button type="button" onclick="triggerSlot(2)" style="flex: 1; background: #e0e7ff; color: #4338ca; border: none; padding: 0.4rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-upload"></i> ${not empty property.imageUrl2 ? 'Replace' : 'Upload'}
                            </button>
                            <button type="button" onclick="clearSlot(2)" title="Clear photo" style="background: #fee2e2; color: #dc2626; border: none; padding: 0.4rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                        <a href="javascript:void(0)" onclick="toggleSlotUrl(2)" style="font-size: 0.72rem; color: var(--primary); text-decoration: none; font-weight: 600; text-align: center;">
                            <i class="bi bi-link-45deg"></i> Custom URL
                        </a>
                        <div id="urlBox2" style="display: none; margin-top: 0.2rem;">
                            <input type="text" id="imageUrl2" name="imageUrl2" value="${property.imageUrl2}" placeholder="https://..." style="width: 100%; padding: 0.35rem 0.5rem; border: 1px solid var(--border); border-radius: 6px; font-size: 0.75rem;" oninput="handleSlotUrl(2, this.value)">
                        </div>
                    </div>

                    <!-- Slot 3: Access Road / Entrance -->
                    <div class="photo-slot-card" style="background: #ffffff; border: 2px solid ${not empty property.imageUrl3 ? '#10b981' : '#cbd5e1'}; border-radius: 12px; padding: 0.85rem; display: flex; flex-direction: column; gap: 0.6rem; position: relative;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.78rem; font-weight: 800; color: #475569; text-transform: uppercase;">Photo 3 (Access Road)</span>
                            <span id="slotBadge3" style="font-size: 0.7rem; font-weight: 700; color: ${not empty property.imageUrl3 ? '#059669' : '#94a3b8'};">
                                ${not empty property.imageUrl3 ? 'Active' : 'Empty'}
                            </span>
                        </div>
                        <div style="width: 100%; height: 110px; border-radius: 8px; overflow: hidden; background: #f1f5f9; position: relative;">
                            <img id="previewImg3" src="${not empty property.imageUrl3 ? property.imageUrl3 : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="Slot 3" style="width: 100%; height: 110px; object-fit: cover; opacity: ${not empty property.imageUrl3 ? '1' : '0.4'};">
                        </div>
                        <input type="file" id="imageFile3" name="imageFile3" accept=".jpg,.jpeg,.png,.webp,.jfif" style="display: none;" onchange="handleSlotFile(event, 3)">
                        <div style="display: flex; gap: 0.35rem;">
                            <button type="button" onclick="triggerSlot(3)" style="flex: 1; background: #e0e7ff; color: #4338ca; border: none; padding: 0.4rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-upload"></i> ${not empty property.imageUrl3 ? 'Replace' : 'Upload'}
                            </button>
                            <button type="button" onclick="clearSlot(3)" title="Clear photo" style="background: #fee2e2; color: #dc2626; border: none; padding: 0.4rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                        <a href="javascript:void(0)" onclick="toggleSlotUrl(3)" style="font-size: 0.72rem; color: var(--primary); text-decoration: none; font-weight: 600; text-align: center;">
                            <i class="bi bi-link-45deg"></i> Custom URL
                        </a>
                        <div id="urlBox3" style="display: none; margin-top: 0.2rem;">
                            <input type="text" id="imageUrl3" name="imageUrl3" value="${property.imageUrl3}" placeholder="https://..." style="width: 100%; padding: 0.35rem 0.5rem; border: 1px solid var(--border); border-radius: 6px; font-size: 0.75rem;" oninput="handleSlotUrl(3, this.value)">
                        </div>
                    </div>

                    <!-- Slot 4: Boundaries / Survey Plan -->
                    <div class="photo-slot-card" style="background: #ffffff; border: 2px solid ${not empty property.imageUrl4 ? '#10b981' : '#cbd5e1'}; border-radius: 12px; padding: 0.85rem; display: flex; flex-direction: column; gap: 0.6rem; position: relative;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.78rem; font-weight: 800; color: #475569; text-transform: uppercase;">Photo 4 (Boundaries)</span>
                            <span id="slotBadge4" style="font-size: 0.7rem; font-weight: 700; color: ${not empty property.imageUrl4 ? '#059669' : '#94a3b8'};">
                                ${not empty property.imageUrl4 ? 'Active' : 'Empty'}
                            </span>
                        </div>
                        <div style="width: 100%; height: 110px; border-radius: 8px; overflow: hidden; background: #f1f5f9; position: relative;">
                            <img id="previewImg4" src="${not empty property.imageUrl4 ? property.imageUrl4 : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="Slot 4" style="width: 100%; height: 110px; object-fit: cover; opacity: ${not empty property.imageUrl4 ? '1' : '0.4'};">
                        </div>
                        <input type="file" id="imageFile4" name="imageFile4" accept=".jpg,.jpeg,.png,.webp,.jfif" style="display: none;" onchange="handleSlotFile(event, 4)">
                        <div style="display: flex; gap: 0.35rem;">
                            <button type="button" onclick="triggerSlot(4)" style="flex: 1; background: #e0e7ff; color: #4338ca; border: none; padding: 0.4rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-upload"></i> ${not empty property.imageUrl4 ? 'Replace' : 'Upload'}
                            </button>
                            <button type="button" onclick="clearSlot(4)" title="Clear photo" style="background: #fee2e2; color: #dc2626; border: none; padding: 0.4rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                        <a href="javascript:void(0)" onclick="toggleSlotUrl(4)" style="font-size: 0.72rem; color: var(--primary); text-decoration: none; font-weight: 600; text-align: center;">
                            <i class="bi bi-link-45deg"></i> Custom URL
                        </a>
                        <div id="urlBox4" style="display: none; margin-top: 0.2rem;">
                            <input type="text" id="imageUrl4" name="imageUrl4" value="${property.imageUrl4}" placeholder="https://..." style="width: 100%; padding: 0.35rem 0.5rem; border: 1px solid var(--border); border-radius: 6px; font-size: 0.75rem;" oninput="handleSlotUrl(4, this.value)">
                        </div>
                    </div>

                    <!-- Slot 5: Surroundings / Highlights -->
                    <div class="photo-slot-card" style="background: #ffffff; border: 2px solid ${not empty property.imageUrl5 ? '#10b981' : '#cbd5e1'}; border-radius: 12px; padding: 0.85rem; display: flex; flex-direction: column; gap: 0.6rem; position: relative;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 0.78rem; font-weight: 800; color: #475569; text-transform: uppercase;">Photo 5 (Surroundings)</span>
                            <span id="slotBadge5" style="font-size: 0.7rem; font-weight: 700; color: ${not empty property.imageUrl5 ? '#059669' : '#94a3b8'};">
                                ${not empty property.imageUrl5 ? 'Active' : 'Empty'}
                            </span>
                        </div>
                        <div style="width: 100%; height: 110px; border-radius: 8px; overflow: hidden; background: #f1f5f9; position: relative;">
                            <img id="previewImg5" src="${not empty property.imageUrl5 ? property.imageUrl5 : 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400'}" alt="Slot 5" style="width: 100%; height: 110px; object-fit: cover; opacity: ${not empty property.imageUrl5 ? '1' : '0.4'};">
                        </div>
                        <input type="file" id="imageFile5" name="imageFile5" accept=".jpg,.jpeg,.png,.webp,.jfif" style="display: none;" onchange="handleSlotFile(event, 5)">
                        <div style="display: flex; gap: 0.35rem;">
                            <button type="button" onclick="triggerSlot(5)" style="flex: 1; background: #e0e7ff; color: #4338ca; border: none; padding: 0.4rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-upload"></i> ${not empty property.imageUrl5 ? 'Replace' : 'Upload'}
                            </button>
                            <button type="button" onclick="clearSlot(5)" title="Clear photo" style="background: #fee2e2; color: #dc2626; border: none; padding: 0.4rem 0.6rem; border-radius: 6px; font-weight: 700; font-size: 0.75rem; cursor: pointer;">
                                <i class="bi bi-x-lg"></i>
                            </button>
                        </div>
                        <a href="javascript:void(0)" onclick="toggleSlotUrl(5)" style="font-size: 0.72rem; color: var(--primary); text-decoration: none; font-weight: 600; text-align: center;">
                            <i class="bi bi-link-45deg"></i> Custom URL
                        </a>
                        <div id="urlBox5" style="display: none; margin-top: 0.2rem;">
                            <input type="text" id="imageUrl5" name="imageUrl5" value="${property.imageUrl5}" placeholder="https://..." style="width: 100%; padding: 0.35rem 0.5rem; border: 1px solid var(--border); border-radius: 6px; font-size: 0.75rem;" oninput="handleSlotUrl(5, this.value)">
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" placeholder="Briefly describe the highlights of the land...">${property.description}</textarea>
            </div>

            <div class="form-group">
                <label for="type">Land Category Type</label>
                <select id="type" name="type" required>
                    <option value="RESIDENTIAL" ${property.type == 'RESIDENTIAL' ? 'selected' : ''}>Residential Land</option>
                    <option value="COMMERCIAL" ${property.type == 'COMMERCIAL' ? 'selected' : ''}>Commercial Land</option>
                    <option value="AGRICULTURAL" ${property.type == 'AGRICULTURAL' ? 'selected' : ''}>Agricultural Land</option>
                    <option value="INDUSTRIAL" ${property.type == 'INDUSTRIAL' ? 'selected' : ''}>Industrial Land</option>
                </select>
            </div>

            <div class="form-group">
                <label for="status">Plot Lifecycle Status</label>
                <select id="status" name="status" required>
                    <option value="PENDING_SURVEY" ${property.status != null and property.status.equalsIgnoreCase('PENDING_SURVEY') or empty property.id ? 'selected' : ''}>PENDING SURVEY (Queued for Field Inspection & Valuation)</option>
                    <option value="AVAILABLE" ${property.status != null and property.status.equalsIgnoreCase('AVAILABLE') ? 'selected' : ''}>AVAILABLE (Survey Certified & Open for Reservation)</option>
                    <option value="RESERVED" ${property.status != null and property.status.equalsIgnoreCase('RESERVED') ? 'selected' : ''}>RESERVED (Hold / Customer Advance Paid)</option>
                    <option value="SOLD" ${property.status != null and property.status.equalsIgnoreCase('SOLD') ? 'selected' : ''}>SOLD (Ownership Transferred)</option>
                </select>
                <small style="color: var(--text-muted); font-size: 0.8rem; margin-top: 0.25rem;">
                    <i class="bi bi-info-circle"></i> Newly registered land plots are automatically routed to the Land Surveyor for boundary demarcation before public listing.
                </small>
            </div>

            <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                <a href="${pageContext.request.contextPath}/property" style="flex: 1; text-align: center; padding: 0.75rem 1.5rem; border: 1px solid var(--border); border-radius: 8px; text-decoration: none; color: var(--text-dark); font-weight: 600;">
                    Cancel
                </a>
                <button type="submit" class="btn-submit" style="flex: 2;">
                    ${property.id != null ? 'Update Property Plot' : 'Save Property Plot'}
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Script for 5-Photo Studio & Batch Dropzone -->
<script>
    const validExts = ['.jpg', '.jpeg', '.png', '.webp', '.jfif'];

    function triggerSlot(num) {
        const input = document.getElementById('imageFile' + num);
        if (input) input.click();
    }

    function handleSlotFile(event, num) {
        const file = event.target.files[0];
        if (file) {
            const fileName = file.name.toLowerCase();
            const isValid = validExts.some(ext => fileName.endsWith(ext));
            if (!isValid) {
                alert('Please select a valid image file (.jpg, .jpeg, .png, or .webp)');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const img = document.getElementById('previewImg' + num);
                if (img) {
                    img.src = e.target.result;
                    img.style.opacity = '1';
                }
                const badge = document.getElementById('slotBadge' + num);
                if (badge) {
                    badge.textContent = 'Ready';
                    badge.style.color = '#059669';
                }
                const card = img ? img.closest('.photo-slot-card') : null;
                if (card) {
                    card.style.borderColor = '#10b981';
                }
            };
            reader.readAsDataURL(file);
        }
    }

    function clearSlot(num) {
        const fileInput = document.getElementById('imageFile' + num);
        if (fileInput) fileInput.value = '';

        const urlInput = document.getElementById('imageUrl' + num);
        if (urlInput) urlInput.value = '';

        const img = document.getElementById('previewImg' + num);
        if (img) {
            img.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400';
            img.style.opacity = '0.4';
        }

        const badge = document.getElementById('slotBadge' + num);
        if (badge) {
            badge.textContent = 'Empty';
            badge.style.color = '#94a3b8';
        }

        const card = img ? img.closest('.photo-slot-card') : null;
        if (card) {
            card.style.borderColor = '#cbd5e1';
        }
    }

    function toggleSlotUrl(num) {
        const box = document.getElementById('urlBox' + num);
        if (box) {
            box.style.display = (box.style.display === 'none' || box.style.display === '') ? 'block' : 'none';
        }
    }

    function handleSlotUrl(num, val) {
        const url = (val || '').trim();
        const img = document.getElementById('previewImg' + num);
        const badge = document.getElementById('slotBadge' + num);
        const card = img ? img.closest('.photo-slot-card') : null;

        if (url) {
            if (img) {
                img.src = url;
                img.style.opacity = '1';
            }
            if (badge) {
                badge.textContent = 'Linked';
                badge.style.color = '#059669';
            }
            if (card) card.style.borderColor = '#10b981';
        } else {
            if (img) {
                img.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400';
                img.style.opacity = '0.4';
            }
            if (badge) {
                badge.textContent = 'Empty';
                badge.style.color = '#94a3b8';
            }
            if (card) card.style.borderColor = '#cbd5e1';
        }
    }

    function triggerBatchSelect() {
        const batchInput = document.getElementById('batchImageFiles');
        if (batchInput) batchInput.click();
    }

    function handleBatchFileSelect(event) {
        const files = event.target.files;
        if (!files || files.length === 0) return;

        const limit = Math.min(files.length, 5);
        for (let i = 0; i < limit; i++) {
            const file = files[i];
            const slotNum = i + 1;
            const fileName = file.name.toLowerCase();
            const isValid = validExts.some(ext => fileName.endsWith(ext));
            if (!isValid) continue;

            // Transfer file preview
            (function(f, num) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.getElementById('previewImg' + num);
                    if (img) {
                        img.src = e.target.result;
                        img.style.opacity = '1';
                    }
                    const badge = document.getElementById('slotBadge' + num);
                    if (badge) {
                        badge.textContent = 'Batch (' + f.name.substring(0, 10) + '...)';
                        badge.style.color = '#059669';
                    }
                    const card = img ? img.closest('.photo-slot-card') : null;
                    if (card) card.style.borderColor = '#10b981';
                };
                reader.readAsDataURL(f);
            })(file, slotNum);
        }
    }

    // Drag & Drop for batch dropzone
    document.addEventListener('DOMContentLoaded', function() {
        const dropzone = document.getElementById('batchDropzone');
        if (dropzone) {
            ['dragenter', 'dragover'].forEach(eventName => {
                dropzone.addEventListener(eventName, function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    dropzone.style.borderColor = '#4f46e5';
                    dropzone.style.backgroundColor = '#eef2ff';
                }, false);
            });
            ['dragleave', 'drop'].forEach(eventName => {
                dropzone.addEventListener(eventName, function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    dropzone.style.borderColor = '#94a3b8';
                    dropzone.style.backgroundColor = '#ffffff';
                }, false);
            });
            dropzone.addEventListener('drop', function(e) {
                const dt = e.dataTransfer;
                const files = dt.files;
                if (files && files.length > 0) {
                    document.getElementById('batchImageFiles').files = files;
                    handleBatchFileSelect({ target: { files: files } });
                }
            });
        }
    });
</script>

</body>
</html>
