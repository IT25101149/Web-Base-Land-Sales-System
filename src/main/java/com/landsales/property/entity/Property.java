package com.landsales.property.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Property {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String location;
    private Double size;
    private Double price;
    private String description;
    private String status;

    @Column(length = 500)
    private String imageUrl; // Slot 1: Primary Cover Photo

    @Column(length = 500)
    private String imageUrl2; // Slot 2: Plot View

    @Column(length = 500)
    private String imageUrl3; // Slot 3: Access Road / Entrance

    @Column(length = 500)
    private String imageUrl4; // Slot 4: Boundaries / Survey View

    @Column(length = 500)
    private String imageUrl5; // Slot 5: Surroundings / Highlights

    private String type; // RESIDENTIAL, COMMERCIAL, AGRICULTURAL, INDUSTRIAL

    public Property() {}

    public Property(Long id, String title, String location, Double size, Double price, String description, String status, String imageUrl, String type) {
        this.id = id;
        this.title = title;
        this.location = location;
        this.size = size;
        this.price = price;
        this.description = description;
        this.status = status;
        this.imageUrl = imageUrl;
        this.type = type;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public Double getSize() { return size; }
    public void setSize(Double size) { this.size = size; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getImageUrl2() { return imageUrl2; }
    public void setImageUrl2(String imageUrl2) { this.imageUrl2 = imageUrl2; }
    public String getImageUrl3() { return imageUrl3; }
    public void setImageUrl3(String imageUrl3) { this.imageUrl3 = imageUrl3; }
    public String getImageUrl4() { return imageUrl4; }
    public void setImageUrl4(String imageUrl4) { this.imageUrl4 = imageUrl4; }
    public String getImageUrl5() { return imageUrl5; }
    public void setImageUrl5(String imageUrl5) { this.imageUrl5 = imageUrl5; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    /**
     * Helper method to retrieve all non-empty images as a List (up to 5 images).
     * Always returns at least one fallback image if none are configured.
     */
    public List<String> getAllImages() {
        List<String> list = new ArrayList<>();
        if (imageUrl != null && !imageUrl.trim().isEmpty()) list.add(imageUrl.trim());
        if (imageUrl2 != null && !imageUrl2.trim().isEmpty()) list.add(imageUrl2.trim());
        if (imageUrl3 != null && !imageUrl3.trim().isEmpty()) list.add(imageUrl3.trim());
        if (imageUrl4 != null && !imageUrl4.trim().isEmpty()) list.add(imageUrl4.trim());
        if (imageUrl5 != null && !imageUrl5.trim().isEmpty()) list.add(imageUrl5.trim());
        if (list.isEmpty()) {
            list.add("https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800");
        }
        return list;
    }

    /**
     * Returns the number of distinct images assigned to this property.
     */
    public int getImageCount() {
        int count = 0;
        if (imageUrl != null && !imageUrl.trim().isEmpty()) count++;
        if (imageUrl2 != null && !imageUrl2.trim().isEmpty()) count++;
        if (imageUrl3 != null && !imageUrl3.trim().isEmpty()) count++;
        if (imageUrl4 != null && !imageUrl4.trim().isEmpty()) count++;
        if (imageUrl5 != null && !imageUrl5.trim().isEmpty()) count++;
        return count > 0 ? count : 1;
    }
}

