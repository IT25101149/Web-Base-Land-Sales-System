package com.landsales.admin.controller;

import com.landsales.admin.entity.AuditLog;
import com.landsales.admin.service.AuditLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping({"/admin/audit", "/admin/audit-logs", "/admin/audits"})
public class AuditController {

    @Autowired
    private AuditLogService auditLogService;

    @Autowired
    private com.landsales.admin.repository.UserRepository userRepository;

    @GetMapping
    public String viewAuditLogs(@RequestParam(value = "module", required = false) String module,
                                @RequestParam(value = "username", required = false) String username,
                                @RequestParam(value = "date", required = false) String date,
                                @RequestParam(value = "query", required = false) String query,
                                Model model) {

        List<AuditLog> allLogs = auditLogService.getAllLogs();
        List<AuditLog> filteredLogs = auditLogService.filterLogs(module, username, date, query);

        List<String> distinctModules = allLogs.stream()
                .map(AuditLog::getModule)
                .filter(m -> m != null && !m.trim().isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());

        java.util.Set<String> userSet = new java.util.TreeSet<>();
        allLogs.stream()
                .map(AuditLog::getUsername)
                .filter(u -> u != null && !u.trim().isEmpty())
                .forEach(userSet::add);
        userRepository.findAll().stream()
                .map(com.landsales.admin.entity.User::getUsername)
                .filter(u -> u != null && !u.trim().isEmpty())
                .forEach(userSet::add);

        List<String> distinctUsers = new java.util.ArrayList<>(userSet);

        String todayStr = LocalDate.now().toString();
        long todayCount = allLogs.stream()
                .filter(l -> l.getTimestamp() != null && l.getTimestamp().toLocalDate().toString().equals(todayStr))
                .count();

        model.addAttribute("logs", filteredLogs);
        model.addAttribute("totalCount", allLogs.size());
        model.addAttribute("filteredCount", filteredLogs.size());
        model.addAttribute("todayCount", todayCount);
        model.addAttribute("distinctModules", distinctModules);
        model.addAttribute("distinctUsers", distinctUsers);
        model.addAttribute("selectedModule", module);
        model.addAttribute("selectedUsername", username);
        model.addAttribute("selectedDate", date);
        model.addAttribute("query", query);

        return "admin/audit";
    }
}

