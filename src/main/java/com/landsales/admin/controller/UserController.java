package com.landsales.admin.controller;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import com.landsales.admin.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private com.landsales.admin.service.AuditLogService auditLogService;

    @GetMapping({"", "/"})
    public String adminHome() {
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/users")
    public String listUsers(Model model) {
        model.addAttribute("users", userService.getAllUsers());
        return "admin/users";
    }

    @PostMapping("/users/add")
    public String addUser(@RequestParam("username") String username,
                          @RequestParam("email") String email,
                          @RequestParam("password") String password,
                          @RequestParam("role") String role,
                          RedirectAttributes redirectAttributes) {
        try {
            final String trimmedUsername = (username != null) ? username.trim() : "";
            if (trimmedUsername.isEmpty() || !trimmedUsername.matches("^[a-zA-Z0-9._-]{3,30}$")) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username must be between 3 and 30 alphanumeric characters (letters, numbers, dots, dashes, underscores).");
                return "redirect:/admin/users";
            }

            if (userRepository.findAll().stream().anyMatch(u -> u.getUsername().equalsIgnoreCase(trimmedUsername))) {
                redirectAttributes.addFlashAttribute("errorMessage", "A user with username '" + trimmedUsername + "' already exists.");
                return "redirect:/admin/users";
            }

            final String trimmedEmail = (email != null) ? email.trim() : "";
            if (trimmedEmail.isEmpty() || !trimmedEmail.matches("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$")) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please provide a valid email address (e.g. name@domain.com).");
                return "redirect:/admin/users";
            }

            if (userRepository.findAll().stream().anyMatch(u -> trimmedEmail.equalsIgnoreCase(u.getEmail()))) {
                redirectAttributes.addFlashAttribute("errorMessage", "A user account with email '" + trimmedEmail + "' already exists.");
                return "redirect:/admin/users";
            }

            if (password == null || password.trim().length() < 6) {
                redirectAttributes.addFlashAttribute("errorMessage", "Password must be at least 6 characters long.");
                return "redirect:/admin/users";
            }

            String formattedRole = (role != null && !role.trim().isEmpty()) ? role.trim().toUpperCase() : "SALES";
            java.util.List<String> allowedRoles = java.util.Arrays.asList("ADMIN", "PROPERTY", "PROPERTY_MANAGER", "SALES", "SURVEY", "LEGAL", "CUSTOMER");
            if (!allowedRoles.contains(formattedRole)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid role selected. Allowed roles: " + String.join(", ", allowedRoles));
                return "redirect:/admin/users";
            }

            User user = new User();
            user.setUsername(trimmedUsername);
            user.setEmail(trimmedEmail);
            user.setPassword(passwordEncoder.encode(password.trim()));
            user.setRole(formattedRole);
            userRepository.save(user);

            auditLogService.log("CREATE_USER", "USER_MANAGEMENT", "Created staff account '" + trimmedUsername + "' with role " + formattedRole + " (" + trimmedEmail + ")");
            redirectAttributes.addFlashAttribute("successMessage", "Staff user '" + trimmedUsername + "' created successfully with role " + formattedRole + ".");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to create user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/edit")
    public String updateUser(@RequestParam("id") Long id,
                             @RequestParam("email") String email,
                             @RequestParam(value = "role", required = false) String role,
                             @RequestParam(value = "password", required = false) String password,
                             RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findById(id).orElse(null);
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found with ID #" + id);
                return "redirect:/admin/users";
            }

            final String trimmedEmail = (email != null) ? email.trim() : "";
            if (trimmedEmail.isEmpty() || !trimmedEmail.matches("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$")) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please provide a valid email address.");
                return "redirect:/admin/users";
            }

            // Check if email taken by another user
            if (userRepository.findAll().stream().anyMatch(u -> !u.getId().equals(id) && trimmedEmail.equalsIgnoreCase(u.getEmail()))) {
                redirectAttributes.addFlashAttribute("errorMessage", "Another user account with email '" + trimmedEmail + "' already exists.");
                return "redirect:/admin/users";
            }

            // Protect primary admin from losing admin rights accidentally
            if ("admin".equalsIgnoreCase(user.getUsername())) {
                role = "ADMIN";
            }

            String oldRole = user.getRole();
            String newRole = (role != null && !role.trim().isEmpty()) ? role.trim().toUpperCase() : oldRole;
            java.util.List<String> allowedRoles = java.util.Arrays.asList("ADMIN", "PROPERTY", "PROPERTY_MANAGER", "SALES", "SURVEY", "LEGAL", "CUSTOMER");
            if (!allowedRoles.contains(newRole)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid role selected.");
                return "redirect:/admin/users";
            }

            user.setEmail(trimmedEmail);
            user.setRole(newRole);

            if (password != null && !password.trim().isEmpty()) {
                if (password.trim().length() < 6) {
                    redirectAttributes.addFlashAttribute("errorMessage", "New password must be at least 6 characters long.");
                    return "redirect:/admin/users";
                }
                user.setPassword(passwordEncoder.encode(password.trim()));
            }

            userRepository.save(user);

            String changeDetails = "Updated user '" + user.getUsername() + "' (ID: " + id + "). Role: " + oldRole + " -> " + newRole;
            auditLogService.log("UPDATE_USER", "USER_MANAGEMENT", changeDetails);

            redirectAttributes.addFlashAttribute("successMessage",
                    "User '" + user.getUsername() + "' updated successfully (Role: " + newRole + ")!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @Autowired(required = false)
    private com.landsales.crm.service.CustomerService customerService;

    @Autowired(required = false)
    private com.landsales.crm.repository.CustomerRepository customerRepository;

    @Autowired(required = false)
    private com.landsales.crm.repository.WishlistRepository wishlistRepository;

    @Autowired(required = false)
    private com.landsales.notification.repository.NotificationRepository notificationRepository;

    @GetMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findById(id).orElse(null);
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User #" + id + " does not exist.");
                return "redirect:/admin/users";
            }
            if ("admin".equalsIgnoreCase(user.getUsername())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Primary Administrator account 'admin' cannot be deleted.");
                return "redirect:/admin/users";
            }

            String uname = user.getUsername();

            // 1. If customer profile exists, cascade delete customer
            if (customerRepository != null && customerService != null) {
                customerRepository.findAll().stream()
                        .filter(c -> uname.equalsIgnoreCase(c.getUsername()))
                        .findFirst()
                        .ifPresent(c -> customerService.deleteCustomer(c.getId()));
            }

            // 2. Clean wishlist
            if (wishlistRepository != null) {
                var items = wishlistRepository.findByUsernameOrderByAddedAtDesc(uname);
                if (items != null && !items.isEmpty()) {
                    wishlistRepository.deleteAll(items);
                }
            }

            // 3. Clean notifications
            if (notificationRepository != null) {
                var notifs = notificationRepository.findAll().stream()
                        .filter(n -> uname.equalsIgnoreCase(n.getRecipientUsername()))
                        .collect(java.util.stream.Collectors.toList());
                if (!notifs.isEmpty()) {
                    notificationRepository.deleteAll(notifs);
                }
            }

            userRepository.delete(user);
            if (auditLogService != null) {
                auditLogService.log("DELETE_USER", "USER_MANAGEMENT", "Deleted system user account '" + uname + "' (#" + id + ")");
            }
            redirectAttributes.addFlashAttribute("successMessage", "User '" + uname + "' deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @RequestMapping(value = "/users/toggle-status/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String toggleUserStatus(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findById(id).orElse(null);
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User #" + id + " does not exist.");
                return "redirect:/admin/users";
            }
            if ("admin".equalsIgnoreCase(user.getUsername())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Primary Administrator account 'admin' cannot be suspended.");
                return "redirect:/admin/users";
            }

            String currentStatus = user.getStatus();
            String newStatus = "SUSPENDED".equalsIgnoreCase(currentStatus) ? "ACTIVE" : "SUSPENDED";
            user.setStatus(newStatus);
            userRepository.save(user);

            if (auditLogService != null) {
                auditLogService.log("TOGGLE_STATUS", "USER_MANAGEMENT",
                        "Changed user '" + user.getUsername() + "' status: " + currentStatus + " -> " + newStatus);
            }

            if ("SUSPENDED".equals(newStatus)) {
                redirectAttributes.addFlashAttribute("successMessage",
                        "User account '" + user.getUsername() + "' has been SUSPENDED. They are now blocked from logging into Ceylon Lands.");
            } else {
                redirectAttributes.addFlashAttribute("successMessage",
                        "User account '" + user.getUsername() + "' has been REACTIVATED. Login access has been restored.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to toggle user status: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }

    @PostMapping("/users/reset-password")
    public String resetPassword(@RequestParam("id") Long id,
                                @RequestParam("newPassword") String newPassword,
                                RedirectAttributes redirectAttributes) {
        try {
            User user = userRepository.findById(id).orElse(null);
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User #" + id + " does not exist.");
                return "redirect:/admin/users";
            }
            if (newPassword == null || newPassword.trim().length() < 6) {
                redirectAttributes.addFlashAttribute("errorMessage", "New password must be at least 6 characters long.");
                return "redirect:/admin/users";
            }

            user.setPassword(passwordEncoder.encode(newPassword.trim()));
            userRepository.save(user);

            if (auditLogService != null) {
                auditLogService.log("RESET_PASSWORD", "USER_MANAGEMENT",
                        "Admin reset password for user '" + user.getUsername() + "' (ID: #" + id + ")");
            }
            redirectAttributes.addFlashAttribute("successMessage", "Password has been reset successfully for user '" + user.getUsername() + "'.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to reset password: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}


