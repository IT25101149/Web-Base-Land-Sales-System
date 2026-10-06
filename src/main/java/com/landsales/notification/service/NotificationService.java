package com.landsales.notification.service;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import com.landsales.notification.entity.Notification;
import com.landsales.notification.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private UserRepository userRepository;

    /**
     * Send in-app notification + automated email to a specific customer or staff user.
     */
    @Transactional
    public Notification notifyUser(String username, String email, String title,
                                   String message, String linkUrl, String type) {
        Notification notification = new Notification(username, email, null, title, message, linkUrl, type);
        notification = notificationRepository.save(notification);

        // Dispatch automated HTML email
        String targetEmail = email;
        if ((targetEmail == null || targetEmail.trim().isEmpty()) && username != null) {
            var userOpt = userRepository.findByUsername(username);
            if (userOpt.isPresent() && userOpt.get().getEmail() != null && !userOpt.get().getEmail().trim().isEmpty()) {
                targetEmail = userOpt.get().getEmail().trim();
                notification.setRecipientEmail(targetEmail);
            }
        }

        if (targetEmail != null && !targetEmail.trim().isEmpty()) {
            emailService.sendNotificationEmail(
                    targetEmail,
                    username != null ? username : "Valued Client",
                    "Ceylon Lands: " + title,
                    title,
                    message,
                    "View in System",
                    linkUrl != null ? linkUrl : "http://localhost:8081/"
            );
            notification.setEmailSent(true);
            notificationRepository.save(notification);
        }

        return notification;
    }

    /**
     * Send in-app notification + automated email to an entire staff role (e.g. SALES, LEGAL, PROPERTY, SURVEY).
     */
    @Transactional
    public Notification notifyRole(String role, String title, String message, String linkUrl, String type) {
        String cleanRole = role.toUpperCase().replace("ROLE_", "");
        Notification notification = new Notification(null, null, cleanRole, title, message, linkUrl, type);
        notification = notificationRepository.save(notification);

        // Find all officers assigned to this role and send them an email alert
        List<User> officers = userRepository.findAll().stream()
                .filter(u -> u.getRole() != null && u.getRole().equalsIgnoreCase(cleanRole))
                .toList();

        for (User officer : officers) {
            if (officer.getEmail() != null && !officer.getEmail().trim().isEmpty()) {
                emailService.sendNotificationEmail(
                        officer.getEmail(),
                        officer.getUsername() + " (" + cleanRole + ")",
                        "[" + cleanRole + " Alert] " + title,
                        title,
                        message,
                        "Open " + cleanRole + " Dashboard",
                        linkUrl != null ? linkUrl : "http://localhost:8081/"
                );
            }
        }

        notification.setEmailSent(!officers.isEmpty());
        return notificationRepository.save(notification);
    }

    public List<Notification> getNotificationsForUser(String username, String role) {
        String cleanRole = (role != null) ? role.toUpperCase().replace("ROLE_", "") : "";
        return notificationRepository.findForUserOrRole(username, cleanRole);
    }

    public long getUnreadCount(String username, String role) {
        String cleanRole = (role != null) ? role.toUpperCase().replace("ROLE_", "") : "";
        return notificationRepository.countUnreadForUserOrRole(username, cleanRole);
    }

    @Transactional
    public void markAsRead(Long id) {
        notificationRepository.findById(id).ifPresent(n -> {
            n.setRead(true);
            notificationRepository.save(n);
        });
    }

    @Transactional
    public void markAllAsRead(String username, String role) {
        List<Notification> list = getNotificationsForUser(username, role);
        for (Notification n : list) {
            if (!n.isRead()) {
                n.setRead(true);
                notificationRepository.save(n);
            }
        }
    }
}

