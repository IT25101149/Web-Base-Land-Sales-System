package com.landsales.admin.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "audit_log")
public class AuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    @Column(nullable = false)
    private String username;

    private String userRole;

    @Column(nullable = false)
    private String action; // e.g. CREATE_PROPERTY, CERTIFY_SURVEY, CONFIRM_PAYMENT, TRANSFER_DEED, CREATE_USER

    @Column(nullable = false)
    private String module; // PROPERTY, SURVEY, SALES, LEGAL, USER_MANAGEMENT, AUTH

    @Column(length = 1000)
    private String description;

    private String ipAddress;

    private String status; // SUCCESS, WARNING, FAILED

    public AuditLog() {
        this.timestamp = LocalDateTime.now();
        this.status = "SUCCESS";
    }

    public AuditLog(String username, String userRole, String action, String module, String description, String ipAddress, String status) {
        this.timestamp = LocalDateTime.now();
        this.username = username;
        this.userRole = userRole;
        this.action = action;
        this.module = module;
        this.description = description;
        this.ipAddress = ipAddress;
        this.status = (status != null ? status : "SUCCESS");
    }

    public AuditLog(LocalDateTime timestamp, String username, String userRole, String action, String module, String description, String ipAddress, String status) {
        this.timestamp = timestamp;
        this.username = username;
        this.userRole = userRole;
        this.action = action;
        this.module = module;
        this.description = description;
        this.ipAddress = ipAddress;
        this.status = (status != null ? status : "SUCCESS");
    }

    // Helper methods for easy JSP display
    public String getFormattedDate() {
        if (timestamp == null) return "";
        return timestamp.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public String getFormattedTime() {
        if (timestamp == null) return "";
        return timestamp.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
    }

    public String getFormattedDateTime() {
        if (timestamp == null) return "";
        return timestamp.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public String getRelativeTime() {
        if (timestamp == null) return "";
        LocalDateTime now = LocalDateTime.now();
        long minutes = ChronoUnit.MINUTES.between(timestamp, now);
        if (minutes < 1) return "Just now";
        if (minutes < 60) return minutes + "m ago";
        long hours = ChronoUnit.HOURS.between(timestamp, now);
        if (hours < 24) return hours + "h ago";
        long days = ChronoUnit.DAYS.between(timestamp, now);
        if (days == 1) return "Yesterday";
        if (days < 7) return days + "d ago";
        return getFormattedDate();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getUserRole() { return userRole; }
    public void setUserRole(String userRole) { this.userRole = userRole; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getModule() { return module; }
    public void setModule(String module) { this.module = module; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIpAddress() { return ipAddress; }
    public void setIpAddress(String ipAddress) { this.ipAddress = ipAddress; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

