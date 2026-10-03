package com.landsales.crm.entity;

import jakarta.persistence.*;
import com.landsales.property.entity.Property;
import java.time.LocalDateTime;

@Entity
public class Inquiry {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String customerName;
    private String username;
    private String email;
    private String phone;
    private String message;
    private LocalDateTime inquiryDate;
    private String status = "PENDING"; // PENDING, PENDING_PAYMENT, PAYMENT_SUBMITTED, FULL_APPROVED, CANCELLED
    private Long saleId;

    @ManyToOne
    @JoinColumn(name = "property_id")
    private Property property;

    public Inquiry() {}

    public Inquiry(Long id, String customerName, String email, String phone, String message, LocalDateTime inquiryDate, Property property) {
        this.id = id;
        this.customerName = customerName;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.inquiryDate = inquiryDate;
        this.property = property;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public LocalDateTime getInquiryDate() { return inquiryDate; }
    public void setInquiryDate(LocalDateTime inquiryDate) { this.inquiryDate = inquiryDate; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Long getSaleId() { return saleId; }
    public void setSaleId(Long saleId) { this.saleId = saleId; }
    public Property getProperty() { return property; }
    public void setProperty(Property property) { this.property = property; }
}
