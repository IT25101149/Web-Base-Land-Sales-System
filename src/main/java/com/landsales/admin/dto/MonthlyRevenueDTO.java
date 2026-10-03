package com.landsales.admin.dto;

import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

public class MonthlyRevenueDTO {
    private YearMonth yearMonth;
    private String monthLabel;
    private String monthFullName;
    private double revenue;
    private long dealsCount;
    private double averageDealSize;
    private Double growthPercentage;
    private Double growthDifference;
    private String growthDirection; // "UP", "DOWN", "FLAT", "BASELINE"
    private String statusBadge;
    private boolean isPeak;

    public MonthlyRevenueDTO() {}

    public MonthlyRevenueDTO(YearMonth ym, double revenue, long dealsCount, Double growthPercentage, Double growthDifference) {
        this.yearMonth = ym;
        this.monthLabel = ym.format(DateTimeFormatter.ofPattern("MMM yyyy"));
        this.monthFullName = ym.format(DateTimeFormatter.ofPattern("MMMM yyyy"));
        this.revenue = revenue;
        this.dealsCount = dealsCount;
        this.averageDealSize = dealsCount > 0 ? (revenue / dealsCount) : 0.0;
        this.growthPercentage = growthPercentage;
        this.growthDifference = growthDifference;

        if (growthPercentage == null) {
            this.growthDirection = "BASELINE";
            this.statusBadge = "Baseline Period";
        } else if (growthPercentage > 0) {
            this.growthDirection = "UP";
            this.statusBadge = growthPercentage >= 25.0 ? "Strong Growth" : "Positive";
        } else if (growthPercentage < 0) {
            this.growthDirection = "DOWN";
            this.statusBadge = "Volume Decline";
        } else {
            this.growthDirection = "FLAT";
            this.statusBadge = "Stable";
        }
    }

    public YearMonth getYearMonth() { return yearMonth; }
    public void setYearMonth(YearMonth yearMonth) { this.yearMonth = yearMonth; }

    public String getMonthLabel() { return monthLabel; }
    public void setMonthLabel(String monthLabel) { this.monthLabel = monthLabel; }

    public String getMonthFullName() { return monthFullName; }
    public void setMonthFullName(String monthFullName) { this.monthFullName = monthFullName; }

    public double getRevenue() { return revenue; }
    public void setRevenue(double revenue) { this.revenue = revenue; }

    public long getDealsCount() { return dealsCount; }
    public void setDealsCount(long dealsCount) { this.dealsCount = dealsCount; }

    public double getAverageDealSize() { return averageDealSize; }
    public void setAverageDealSize(double averageDealSize) { this.averageDealSize = averageDealSize; }

    public Double getGrowthPercentage() { return growthPercentage; }
    public void setGrowthPercentage(Double growthPercentage) { this.growthPercentage = growthPercentage; }

    public Double getGrowthDifference() { return growthDifference; }
    public void setGrowthDifference(Double growthDifference) { this.growthDifference = growthDifference; }

    public String getGrowthDirection() { return growthDirection; }
    public void setGrowthDirection(String growthDirection) { this.growthDirection = growthDirection; }

    public String getStatusBadge() { return statusBadge; }
    public void setStatusBadge(String statusBadge) { this.statusBadge = statusBadge; }

    public boolean isPeak() { return isPeak; }
    public void setPeak(boolean peak) {
        isPeak = peak;
        if (peak) {
            this.statusBadge = "Peak Performance";
        }
    }
}
