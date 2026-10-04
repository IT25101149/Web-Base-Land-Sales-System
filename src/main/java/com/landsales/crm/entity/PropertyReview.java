package com.landsales.crm.entity;

import com.landsales.property.entity.Property;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "property_review")
public class PropertyReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "property_id")
    private Property property;

    private String username;
    private String customerName;
    private int rating; // 1 to 5 stars

    @Column(length = 1000)
    private String comment;

    private LocalDateTime createdAt;

    public PropertyReview() {
        this.createdAt = LocalDateTime.now();
    }

    public PropertyReview(Property property, String username, String customerName, int rating, String comment) {
        this.property = property;
        this.username = username;
        this.customerName = customerName;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Property getProperty() { return property; }
    public void setProperty(Property property) { this.property = property; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
