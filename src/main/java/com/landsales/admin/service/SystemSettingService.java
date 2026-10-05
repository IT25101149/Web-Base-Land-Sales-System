package com.landsales.admin.service;

import com.landsales.admin.entity.SystemSetting;
import com.landsales.admin.repository.SystemSettingRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class SystemSettingService {

    @Autowired
    private SystemSettingRepository repository;

    @Autowired(required = false)
    private AuditLogService auditLogService;

    @PostConstruct
    public void initDefaults() {
        if (repository.count() == 0) {
            SystemSetting defaultSetting = new SystemSetting();
            defaultSetting.setCompanyName("Ceylon Lands & Real Estate PLC");
            defaultSetting.setCompanyEmail("info@ceylonlands.lk");
            defaultSetting.setCompanyPhone("+94 11 258 9000");
            defaultSetting.setCompanyAddress("No. 75, Galle Road, Colombo 03, Sri Lanka");
            defaultSetting.setMinAdvanceDepositPercentage(10.0);
            defaultSetting.setReservationValidityDays(14);
            defaultSetting.setDefaultStampDutyPercentage(4.0);
            defaultSetting.setOnlineBookingEnabled(true);
            defaultSetting.setMaintenanceMode(false);
            defaultSetting.setUpdatedAt(LocalDateTime.now());
            defaultSetting.setUpdatedBy("System Seed");
            repository.save(defaultSetting);
        }
    }

    public SystemSetting getSettings() {
        return repository.findAll().stream().findFirst().orElseGet(() -> {
            SystemSetting s = new SystemSetting();
            return repository.save(s);
        });
    }

    public SystemSetting updateSettings(SystemSetting form, String username) {
        SystemSetting current = getSettings();
        current.setCompanyName(form.getCompanyName());
        current.setCompanyEmail(form.getCompanyEmail());
        current.setCompanyPhone(form.getCompanyPhone());
        current.setCompanyAddress(form.getCompanyAddress());

        if (form.getMinAdvanceDepositPercentage() != null && form.getMinAdvanceDepositPercentage() >= 0) {
            current.setMinAdvanceDepositPercentage(form.getMinAdvanceDepositPercentage());
        }
        if (form.getReservationValidityDays() != null && form.getReservationValidityDays() > 0) {
            current.setReservationValidityDays(form.getReservationValidityDays());
        }
        if (form.getDefaultStampDutyPercentage() != null && form.getDefaultStampDutyPercentage() >= 0) {
            current.setDefaultStampDutyPercentage(form.getDefaultStampDutyPercentage());
        }

        current.setOnlineBookingEnabled(Boolean.TRUE.equals(form.getOnlineBookingEnabled()));
        current.setMaintenanceMode(Boolean.TRUE.equals(form.getMaintenanceMode()));
        current.setUpdatedAt(LocalDateTime.now());
        current.setUpdatedBy(username != null ? username : "Administrator");

        SystemSetting saved = repository.save(current);

        if (auditLogService != null) {
            auditLogService.log("UPDATE_SETTINGS", "SYSTEM_CONFIG",
                    "Updated company business policies: Deposit " + saved.getMinAdvanceDepositPercentage() +
                            "%, Hold " + saved.getReservationValidityDays() + " days, Stamp Duty " +
                            saved.getDefaultStampDutyPercentage() + "% by " + current.getUpdatedBy());
        }

        return saved;
    }

    public SystemSetting resetToDefaults(String username) {
        SystemSetting current = getSettings();
        current.setCompanyName("Ceylon Lands & Real Estate PLC");
        current.setCompanyEmail("info@ceylonlands.lk");
        current.setCompanyPhone("+94 11 258 9000");
        current.setCompanyAddress("No. 75, Galle Road, Colombo 03, Sri Lanka");
        current.setMinAdvanceDepositPercentage(10.0);
        current.setReservationValidityDays(14);
        current.setDefaultStampDutyPercentage(4.0);
        current.setOnlineBookingEnabled(true);
        current.setMaintenanceMode(false);
        current.setUpdatedAt(LocalDateTime.now());
        current.setUpdatedBy(username != null ? username : "Administrator");

        SystemSetting saved = repository.save(current);

        if (auditLogService != null) {
            auditLogService.log("RESET_SETTINGS", "SYSTEM_CONFIG",
                    "Reset system policies and company profile to enterprise defaults by " + current.getUpdatedBy());
        }

        return saved;
    }
}
