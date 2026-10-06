package com.landsales.survey.entity;

import com.landsales.property.entity.Property;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Survey {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "property_id")
    private Property property;

    private String surveyNumber;
    private String surveyorName;
    private LocalDate surveyDate;
    private String planNumber;
    private String lotNumber;
    private String landExtent;

    private String northBoundary;
    private String southBoundary;
    private String eastBoundary;
    private String westBoundary;

    private Double valuationAmount;
    private Double governmentValuation;

    private String topography;
    private String accessRoadWidth;
    private String utilitiesStatus;

    // Status: APPROVED, COMPLETED, IN_PROGRESS, PENDING_INSPECTION
    private String status = "COMPLETED";

    @Column(length = 2000)
    private String surveyPlanUrl;

    @Column(length = 1000)
    private String remarks;