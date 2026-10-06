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
