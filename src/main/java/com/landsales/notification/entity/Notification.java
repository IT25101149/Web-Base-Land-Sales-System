package com.landsales.notification.entity;

import jakarta.persistence.*;
import java.time.Duration;
import java.time.LocalDateTime;

@Entity
@Table(name = "notification")
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "recipient_username", length = 100)
    private String recipientUsername;

    @Column(name = "recipient_email", length = 150)
    private String recipientEmail;

    @Column(name = "recipient_role", length = 50)
    private String recipientRole;

    @Column(nullable = false, length = 200)
    private String title;

    @Column(length = 1000)
    private String message;

    @Column(name = "link_url", length = 300)
    private String linkUrl;

    @Column(length = 50)
    private String type; // RESERVATION, PAYMENT, LEGAL_DEED, SURVEY, SYSTEM

    @Column(name = "is_read", nullable = false)
    private boolean isRead = false;

    @Column(name = "email_sent", nullable = false)
    private boolean emailSent = false;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    public Notification() {}

    public Notification(String recipientUsername, String recipientEmail, String recipientRole,
                        String title, String message, String linkUrl, String type) {
        this.recipientUsername = recipientUsername;
        this.recipientEmail = recipientEmail;
        this.recipientRole = recipientRole;
        this.title = title;
        this.message = message;
        this.linkUrl = linkUrl;
        this.type = type;
        this.createdAt = LocalDateTime.now();
        this.isRead = false;
        this.emailSent = false;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getRecipientUsername() { return recipientUsername; }
    public void setRecipientUsername(String recipientUsername) { this.recipientUsername = recipientUsername; }

    public String getRecipientEmail() { return recipientEmail; }
    public void setRecipientEmail(String recipientEmail) { this.recipientEmail = recipientEmail; }

    public String getRecipientRole() { return recipientRole; }
    public void setRecipientRole(String recipientRole) { this.recipientRole = recipientRole; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }

    public boolean isEmailSent() { return emailSent; }
    public void setEmailSent(boolean emailSent) { this.emailSent = emailSent; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    /**
     * User-friendly relative timestamp (e.g. "Just now", "2m ago", "1h ago", "Yesterday")
     */
    public String getTimeAgo() {
        if (createdAt == null) return "";
        Duration duration = Duration.between(createdAt, LocalDateTime.now());
        long seconds = duration.getSeconds();
        if (seconds < 60) return "Just now";
        long minutes = seconds / 60;
        if (minutes < 60) return minutes + "m ago";
        long hours = minutes / 60;
        if (hours < 24) return hours + "h ago";
        long days = hours / 24;
        if (days == 1) return "Yesterday";
        if (days < 7) return days + "d ago";
        return createdAt.toLocalDate().toString();
    }
}

