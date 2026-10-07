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

    public Survey() {}

    public Survey(Long id, Property property, String surveyNumber, String surveyorName, LocalDate surveyDate,
                  String planNumber, String lotNumber, String landExtent, String northBoundary, String southBoundary,
                  String eastBoundary, String westBoundary, Double valuationAmount, Double governmentValuation,
                  String topography, String accessRoadWidth, String utilitiesStatus, String status,
                  String surveyPlanUrl, String remarks) {
        this.id = id;
        this.property = property;
        this.surveyNumber = surveyNumber;
        this.surveyorName = surveyorName;
        this.surveyDate = surveyDate;
        this.planNumber = planNumber;
        this.lotNumber = lotNumber;
        this.landExtent = landExtent;
        this.northBoundary = northBoundary;
        this.southBoundary = southBoundary;
        this.eastBoundary = eastBoundary;
        this.westBoundary = westBoundary;
        this.valuationAmount = valuationAmount;
        this.governmentValuation = governmentValuation;
        this.topography = topography;
        this.accessRoadWidth = accessRoadWidth;
        this.utilitiesStatus = utilitiesStatus;
        this.status = status;
        this.surveyPlanUrl = surveyPlanUrl;
        this.remarks = remarks;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Property getProperty() { return property; }
    public void setProperty(Property property) { this.property = property; }

    public String getSurveyNumber() { return surveyNumber; }
    public void setSurveyNumber(String surveyNumber) { this.surveyNumber = surveyNumber; }

    public String getSurveyorName() { return surveyorName; }
    public void setSurveyorName(String surveyorName) { this.surveyorName = surveyorName; }

    public LocalDate getSurveyDate() { return surveyDate; }
    public void setSurveyDate(LocalDate surveyDate) { this.surveyDate = surveyDate; }

    public String getPlanNumber() { return planNumber; }
    public void setPlanNumber(String planNumber) { this.planNumber = planNumber; }

    public String getLotNumber() { return lotNumber; }
    public void setLotNumber(String lotNumber) { this.lotNumber = lotNumber; }

    public String getLandExtent() { return landExtent; }
    public void setLandExtent(String landExtent) { this.landExtent = landExtent; }

    public String getNorthBoundary() { return northBoundary; }
    public void setNorthBoundary(String northBoundary) { this.northBoundary = northBoundary; }

    public String getSouthBoundary() { return southBoundary; }
    public void setSouthBoundary(String southBoundary) { this.southBoundary = southBoundary; }

    public String getEastBoundary() { return eastBoundary; }
    public void setEastBoundary(String eastBoundary) { this.eastBoundary = eastBoundary; }

    public String getWestBoundary() { return westBoundary; }
    public void setWestBoundary(String westBoundary) { this.westBoundary = westBoundary; }

    public Double getValuationAmount() { return valuationAmount; }
    public void setValuationAmount(Double valuationAmount) { this.valuationAmount = valuationAmount; }

    public Double getGovernmentValuation() { return governmentValuation; }
    public void setGovernmentValuation(Double governmentValuation) { this.governmentValuation = governmentValuation; }

    public String getTopography() { return topography; }
    public void setTopography(String topography) { this.topography = topography; }

    public String getAccessRoadWidth() { return accessRoadWidth; }
    public void setAccessRoadWidth(String accessRoadWidth) { this.accessRoadWidth = accessRoadWidth; }

    public String getUtilitiesStatus() { return utilitiesStatus; }
    public void setUtilitiesStatus(String utilitiesStatus) { this.utilitiesStatus = utilitiesStatus; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSurveyPlanUrl() { return surveyPlanUrl; }
    public void setSurveyPlanUrl(String surveyPlanUrl) { this.surveyPlanUrl = surveyPlanUrl; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}
