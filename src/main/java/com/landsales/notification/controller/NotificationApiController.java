package com.landsales.notification.controller;

import com.landsales.notification.entity.Notification;
import com.landsales.notification.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/notifications")
public class NotificationApiController {

    @Autowired
    private NotificationService notificationService;

    private String getPrimaryRole(Authentication authentication) {
        if (authentication == null || authentication.getAuthorities() == null) return "CUSTOMER";
        return authentication.getAuthorities().stream()
                .findFirst()
                .map(a -> a.getAuthority().replace("ROLE_", ""))
                .orElse("CUSTOMER");
    }

    @GetMapping
    public List<Map<String, Object>> getMyNotifications(Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return Collections.emptyList();
        }

        String username = authentication.getName();
        String role = getPrimaryRole(authentication);
        List<Notification> list = notificationService.getNotificationsForUser(username, role);

        return list.stream().map(n -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", n.getId());
            map.put("title", n.getTitle());
            map.put("message", n.getMessage());
            map.put("linkUrl", n.getLinkUrl());
            map.put("type", n.getType());
            map.put("isRead", n.isRead());
            map.put("timeAgo", n.getTimeAgo());
            return map;
        }).toList();
    }

    @GetMapping("/unread-count")
    public Map<String, Object> getUnreadCount(Authentication authentication) {
        Map<String, Object> res = new HashMap<>();
        if (authentication == null || !authentication.isAuthenticated()) {
            res.put("unreadCount", 0);
            return res;
        }

        String username = authentication.getName();
        String role = getPrimaryRole(authentication);
        long count = notificationService.getUnreadCount(username, role);
        res.put("unreadCount", count);
        return res;
    }

    @PostMapping("/mark-read/{id}")
    public Map<String, Object> markRead(@PathVariable("id") Long id) {
        notificationService.markAsRead(id);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        return res;
    }

    @PostMapping("/mark-all-read")
    public Map<String, Object> markAllRead(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();
            String role = getPrimaryRole(authentication);
            notificationService.markAllAsRead(username, role);
        }
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        return res;
    }
}
