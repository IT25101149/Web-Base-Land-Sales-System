package com.landsales.admin.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "system_settings")
public class SystemSetting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String companyName = "Ceylon Lands & Real Estate PLC";

    @Column(nullable = false)
    private String companyEmail = "info@ceylonlands.lk";

    private String companyPhone = "+94 11 258 9000";

    @Column(length = 500)
    private String companyAddress = "No. 75, Galle Road, Colombo 03, Sri Lanka";

    @Column(nullable = false)
    private Double minAdvanceDepositPercentage = 10.0; // 10% minimum deposit

    @Column(nullable = false)
    private Integer reservationValidityDays = 14; // Reservation hold period in days

    @Column(nullable = false)
    private Double defaultStampDutyPercentage = 4.0; // 4% Sri Lanka Land Stamp Duty

    @Column(nullable = false)
    private Boolean onlineBookingEnabled = true;

    @Column(nullable = false)
    private Boolean maintenanceMode = false;

    private LocalDateTime updatedAt = LocalDateTime.now();

    private String updatedBy = "System Administrator";

    public SystemSetting() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }

    public String getCompanyEmail() { return companyEmail; }
    public void setCompanyEmail(String companyEmail) { this.companyEmail = companyEmail; }

    public String getCompanyPhone() { return companyPhone; }
    public void setCompanyPhone(String companyPhone) { this.companyPhone = companyPhone; }

    public String getCompanyAddress() { return companyAddress; }
    public void setCompanyAddress(String companyAddress) { this.companyAddress = companyAddress; }

    public Double getMinAdvanceDepositPercentage() { return minAdvanceDepositPercentage; }
    public void setMinAdvanceDepositPercentage(Double minAdvanceDepositPercentage) { this.minAdvanceDepositPercentage = minAdvanceDepositPercentage; }

    public Integer getReservationValidityDays() { return reservationValidityDays; }
    public void setReservationValidityDays(Integer reservationValidityDays) { this.reservationValidityDays = reservationValidityDays; }

    public Double getDefaultStampDutyPercentage() { return defaultStampDutyPercentage; }
    public void setDefaultStampDutyPercentage(Double defaultStampDutyPercentage) { this.defaultStampDutyPercentage = defaultStampDutyPercentage; }

    public Boolean getOnlineBookingEnabled() { return onlineBookingEnabled; }
    public void setOnlineBookingEnabled(Boolean onlineBookingEnabled) { this.onlineBookingEnabled = onlineBookingEnabled; }

    public Boolean getMaintenanceMode() { return maintenanceMode; }
    public void setMaintenanceMode(Boolean maintenanceMode) { this.maintenanceMode = maintenanceMode; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }
}

