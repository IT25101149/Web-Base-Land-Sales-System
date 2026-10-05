package com.landsales.admin.service;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostConstruct
    public void seedUsers() {
        ensureUser("admin", "admin123", "admin@terrasales.com", "ADMIN");
        ensureUser("property", "property123", "property@terrasales.com", "PROPERTY");
        ensureUser("sales", "sales123", "sales@terrasales.com", "SALES");
        ensureUser("survey", "survey123", "survey@terrasales.com", "SURVEY");
        ensureUser("legal", "legal123", "legal@terrasales.com", "LEGAL");
        ensureUser("customer", "customer123", "customer@ceylonlands.com", "CUSTOMER");

        // Remove legacy user records if present
        userRepository.findByUsername("lahiru").ifPresent(userRepository::delete);
        userRepository.findByUsername("crm").ifPresent(userRepository::delete);

        System.out.println("=== CURRENT USERS IN DATABASE ===");
        userRepository.findAll().forEach(u -> System.out.println("ID: " + u.getId() + " | Username: " + u.getUsername() + " | Email: " + u.getEmail() + " | Role: " + u.getRole()));
        System.out.println("=================================");
    }

    private void ensureUser(String username, String rawPassword, String email, String role) {
        var existing = userRepository.findByUsername(username);
        if (existing.isEmpty()) {
            userRepository.save(new User(null, username, passwordEncoder.encode(rawPassword), email, role));
        } else {
            User u = existing.get();
            if (email != null && !email.equalsIgnoreCase(u.getEmail())) {
                u.setEmail(email);
                userRepository.save(u);
            }
        }
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
