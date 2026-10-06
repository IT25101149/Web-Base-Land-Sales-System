package com.landsales.survey.controller;

import com.landsales.survey.entity.Survey;
import com.landsales.survey.service.SurveyService;
import com.landsales.property.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/survey")
public class SurveyController {

    @Autowired
    private SurveyService surveyService;

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private com.landsales.admin.service.AuditLogService auditLogService;

    @GetMapping({"", "/list"})
    public String listSurveys(Model model, org.springframework.security.core.Authentication authentication) {
        boolean isSurveyor = authentication != null && authentication.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_SURVEY") || a.getAuthority().equals("ROLE_ADMIN"));
        if (!isSurveyor) {
            return "redirect:/property";
        }

        List<Survey> surveys = surveyService.getAllSurveys();
        List<com.landsales.property.entity.Property> properties = propertyService.getAllProperties();


        // Check if any property with PENDING_SURVEY does not have a survey yet, auto-queue it
        for (com.landsales.property.entity.Property p : properties) {
            if ("PENDING_SURVEY".equalsIgnoreCase(p.getStatus())) {
                surveyService.createPendingSurveyForProperty(p);
            }
        }
        // Re-fetch in case any pending surveys were created
        surveys = surveyService.getAllSurveys();

        long totalSurveys = surveys.size();
        long approvedSurveys = surveys.stream()
                .filter(s -> "APPROVED".equalsIgnoreCase(s.getStatus()) || "COMPLETED".equalsIgnoreCase(s.getStatus()))
                .count();
        long inProgressSurveys = surveys.stream()
                .filter(s -> "IN_PROGRESS".equalsIgnoreCase(s.getStatus()) || "PENDING_INSPECTION".equalsIgnoreCase(s.getStatus()) || "PENDING".equalsIgnoreCase(s.getStatus()))
                .count();
        double totalValuation = surveys.stream()
                .filter(s -> "APPROVED".equalsIgnoreCase(s.getStatus()) || "COMPLETED".equalsIgnoreCase(s.getStatus()))
                .mapToDouble(s -> s.getValuationAmount() != null ? s.getValuationAmount() : 0.0)
                .sum();

        List<Survey> pendingList = surveys.stream()
                .filter(s -> !"APPROVED".equalsIgnoreCase(s.getStatus()) && !"COMPLETED".equalsIgnoreCase(s.getStatus()))
                .toList();

        List<Survey> certifiedList = surveys.stream()
                .filter(s -> "APPROVED".equalsIgnoreCase(s.getStatus()) || "COMPLETED".equalsIgnoreCase(s.getStatus()))
                .toList();