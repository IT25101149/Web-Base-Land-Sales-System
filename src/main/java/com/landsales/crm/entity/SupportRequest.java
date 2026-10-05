package com.landsales.crm.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "support_request")
public class SupportRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String customerName;
    private String email;
    private String phone;
    private String subject;
    private String category; // Legal, Payments, Site Visit, General

    @Column(length = 1500)
    private String message;

    private String status; // OPEN, IN_PROGRESS, RESOLVED
    private LocalDateTime createdAt;

    public SupportRequest() {
        this.status = "OPEN";
        this.createdAt = LocalDateTime.now();
    }

    public SupportRequest(String username, String customerName, String email, String phone, String subject, String category, String message) {
        this.username = username;
        this.customerName = customerName;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.category = category;
        this.message = message;
        this.status = "OPEN";
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
