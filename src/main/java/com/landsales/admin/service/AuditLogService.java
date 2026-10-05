package com.landsales.admin.service;

import com.landsales.admin.entity.AuditLog;
import com.landsales.admin.repository.AuditLogRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class AuditLogService {

    @Autowired
    private AuditLogRepository auditLogRepository;

    /**
     * Resolves the current authenticated username or defaults to 'system'.
     */
    public String getCurrentUsername() {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
                return auth.getName();
            }
        } catch (Exception ignored) {}
        return "system";
    }

    /**
     * Resolves the current user role.
     */
    public String getCurrentUserRole() {
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getName())) {
                return auth.getAuthorities().stream()
                        .map(Object::toString)
                        .findFirst()
                        .orElse("USER");
            }
        } catch (Exception ignored) {}
        return "SYSTEM";
    }

    /**
     * Records an audit log entry automatically detecting the logged-in user, role, and IP address.
     */
    public void log(String action, String module, String description) {
        String username = getCurrentUsername();
        String role = getCurrentUserRole();
        String ipAddress = "127.0.0.1";

        try {
            ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (sra != null && sra.getRequest() != null) {
                String remote = sra.getRequest().getRemoteAddr();
                if (remote != null && !remote.trim().isEmpty()) {
                    ipAddress = remote;
                }
            }
        } catch (Exception ignored) {}

        log(username, role, action, module, description, ipAddress, "SUCCESS");
    }

    /**
     * Records an audit log entry with explicit operator parameters.
     */
    public void log(String username, String role, String action, String module, String description, String ipAddress, String status) {
        try {
            AuditLog log = new AuditLog(username, role, action, module, description, ipAddress, status);
            auditLogRepository.save(log);
        } catch (Exception e) {
            System.err.println("Failed to write audit log: " + e.getMessage());
        }
    }

    public List<AuditLog> getAllLogs() {
        return auditLogRepository.findAllByOrderByTimestampDesc();
    }

    public List<AuditLog> getRecentLogs(int limit) {
        return auditLogRepository.findTop15ByOrderByTimestampDesc();
    }

    public List<AuditLog> filterLogs(String module, String username, String date, String query) {
        List<AuditLog> logs = auditLogRepository.findAllByOrderByTimestampDesc();

        return logs.stream()
                .filter(l -> {
                    if (module != null && !module.trim().isEmpty() && !"ALL".equalsIgnoreCase(module)) {
                        if (!module.equalsIgnoreCase(l.getModule())) return false;
                    }
                    if (username != null && !username.trim().isEmpty() && !"ALL".equalsIgnoreCase(username)) {
                        if (!username.equalsIgnoreCase(l.getUsername())) return false;
                    }
                    if (date != null && !date.trim().isEmpty()) {
                        if (!l.getFormattedDate().equals(date.trim())) return false;
                    }
                    if (query != null && !query.trim().isEmpty()) {
                        String q = query.toLowerCase().trim();
                        boolean match = (l.getUsername() != null && l.getUsername().toLowerCase().contains(q)) ||
                                (l.getAction() != null && l.getAction().toLowerCase().contains(q)) ||
                                (l.getModule() != null && l.getModule().toLowerCase().contains(q)) ||
                                (l.getDescription() != null && l.getDescription().toLowerCase().contains(q));
                        if (!match) return false;
                    }
                    return true;
                })
                .collect(Collectors.toList());
    }

    /**
     * Seeds initial realistic audit trail if database has no audit entries.
     */
    @PostConstruct
    public void seedHistoricalAuditLogs() {
        try {
            if (auditLogRepository.count() == 0) {
                LocalDateTime now = LocalDateTime.now();

                // 1. Initial System Setup
                auditLogRepository.save(new AuditLog(now.minusDays(3).withHour(9).withMinute(15).withSecond(30),
                        "admin", "ROLE_ADMIN", "SYSTEM_INIT", "SECURITY",
                        "System initialization & Microsoft SQL Server connection verified", "127.0.0.1", "SUCCESS"));

                // 2. User Creation
                auditLogRepository.save(new AuditLog(now.minusDays(3).withHour(10).withMinute(30).withSecond(0),
                        "admin", "ROLE_ADMIN", "CREATE_USER", "USER_MANAGEMENT",
                        "Created system user account 'property' (Role: PROPERTY_MANAGER)", "127.0.0.1", "SUCCESS"));

                auditLogRepository.save(new AuditLog(now.minusDays(3).withHour(10).withMinute(35).withSecond(12),
                        "admin", "ROLE_ADMIN", "CREATE_USER", "USER_MANAGEMENT",
                        "Created system user account 'survey' (Role: SURVEYOR)", "127.0.0.1", "SUCCESS"));

                // 3. Property Registration
                auditLogRepository.save(new AuditLog(now.minusDays(2).withHour(11).withMinute(10).withSecond(45),
                        "property", "ROLE_PROPERTY", "CREATE_PROPERTY", "PROPERTY",
                        "Registered new land plot #1 'Green Valley Estate' (15.0 Perches, LKR 4,500,000) - Status: PENDING_SURVEY", "127.0.0.1", "SUCCESS"));

                // 4. Cadastral Survey Certification
                auditLogRepository.save(new AuditLog(now.minusDays(2).withHour(14).withMinute(45).withSecond(20),
                        "survey", "ROLE_SURVEY", "CERTIFY_SURVEY", "SURVEY",
                        "Inspected and certified Cadastral Survey Plan PP/KANDY/2026/04 for Plot #1 'Green Valley Estate'. Status activated to AVAILABLE", "127.0.0.1", "SUCCESS"));

                // 5. Customer Reservation Approval
                auditLogRepository.save(new AuditLog(now.minusDays(1).withHour(10).withMinute(20).withSecond(15),
                        "sales", "ROLE_SALES", "APPROVE_RESERVATION", "SALES",
                        "Approved online reservation for Plot #1 'Green Valley Estate' for customer Kasun Bandara", "127.0.0.1", "SUCCESS"));

                // 6. Payment Confirmation
                auditLogRepository.save(new AuditLog(now.minusDays(1).withHour(15).withMinute(40).withSecond(50),
                        "sales", "ROLE_SALES", "CONFIRM_PAYMENT", "SALES",
                        "Confirmed customer bank transfer slip (LKR 500,000 advance deposit) for Sale #1", "127.0.0.1", "SUCCESS"));

                // 7. Title Deed Transfer
                auditLogRepository.save(new AuditLog(now.minusHours(5).withMinute(25).withSecond(10),
                        "legal", "ROLE_LEGAL", "TRANSFER_DEED", "LEGAL",
                        "Completed Land Registry title verification & transferred legal deed for Plot #1. Status changed to SOLD", "127.0.0.1", "SUCCESS"));

                // 8. New Plot with Photo Upload
                auditLogRepository.save(new AuditLog(now.minusMinutes(35).withSecond(18),
                        "property", "ROLE_PROPERTY", "CREATE_PROPERTY", "PROPERTY",
                        "Registered new land plot 'Hanthana Pine Vista Plots' (18.0 Perches, LKR 8,500,000) with uploaded JPG photo. Queued for Survey", "127.0.0.1", "SUCCESS"));

                // 9. Admin Login
                auditLogRepository.save(new AuditLog(now.minusMinutes(5).withSecond(4),
                        "admin", "ROLE_ADMIN", "USER_LOGIN", "AUTH",
                        "Administrator session authenticated successfully via Web Console", "127.0.0.1", "SUCCESS"));
            }
        } catch (Exception e) {
            System.err.println("Notice: Historical audit log seeding skipped: " + e.getMessage());
        }
    }
}

