package com.landsales.crm.entity;

import jakarta.persistence.*;

@Entity
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String name;
    private String email;
    private String phone;
    private String address;

    public Customer() {}

    public Customer(Long id, String username, String name, String email, String phone, String address) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public Customer(Long id, String name, String email, String phone, String address) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
