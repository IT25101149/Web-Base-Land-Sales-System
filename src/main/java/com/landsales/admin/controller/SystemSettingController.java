package com.landsales.admin.controller;

import com.landsales.admin.entity.SystemSetting;
import com.landsales.admin.service.SystemSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/settings")
public class SystemSettingController {

    @Autowired
    private SystemSettingService systemSettingService;

    @GetMapping
    public String viewSettings(Model model) {
        model.addAttribute("settings", systemSettingService.getSettings());
        return "admin/settings";
    }

    @PostMapping("/update")
    public String updateSettings(@ModelAttribute SystemSetting form,
                                 Authentication authentication,
                                 RedirectAttributes redirectAttributes) {
        try {
            String username = (authentication != null) ? authentication.getName() : "admin";
            systemSettingService.updateSettings(form, username);
            redirectAttributes.addFlashAttribute("successMessage", "Business policies and system configuration updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update system settings: " + e.getMessage());
        }
        return "redirect:/admin/settings";
    }

    @PostMapping("/reset")
    public String resetSettings(Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        try {
            String username = (authentication != null) ? authentication.getName() : "admin";
            systemSettingService.resetToDefaults(username);
            redirectAttributes.addFlashAttribute("successMessage", "System settings have been reset to company enterprise defaults.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to reset system settings: " + e.getMessage());
        }
        return "redirect:/admin/settings";
    }
}

