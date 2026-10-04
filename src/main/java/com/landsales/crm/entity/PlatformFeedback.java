package com.landsales.crm.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "platform_feedback")
public class PlatformFeedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String customerName;
    private int rating; // 1-5

    @Column(length = 1000)
    private String comments;

    private String feedbackType; // EXPERIENCE, SUGGESTION, COMPLAINT, COMPLIMENT
    private LocalDateTime createdAt;

    public PlatformFeedback() {
        this.createdAt = LocalDateTime.now();
    }

    public PlatformFeedback(String username, String customerName, int rating, String comments, String feedbackType) {
        this.username = username;
        this.customerName = customerName;
        this.rating = rating;
        this.comments = comments;
        this.feedbackType = feedbackType;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComments() { return comments; }
    public void setComments(String comments) { this.comments = comments; }

    public String getFeedbackType() { return feedbackType; }
    public void setFeedbackType(String feedbackType) { this.feedbackType = feedbackType; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
