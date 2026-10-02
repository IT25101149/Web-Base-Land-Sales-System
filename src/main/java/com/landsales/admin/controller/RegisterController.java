package com.landsales.admin.controller;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import com.landsales.crm.entity.Customer;
import com.landsales.crm.repository.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping
    public String showRegistrationForm(Model model) {
        return "register";
    }

    @PostMapping("/save")
    public String registerCustomer(@RequestParam("username") String username,
                                   @RequestParam("password") String password,
                                   @RequestParam("email") String email,
                                   @RequestParam("name") String name,
                                   @RequestParam("phone") String phone,
                                   @RequestParam("address") String address,
                                   Model model) {

        final String trimmedUsername = (username != null) ? username.trim() : "";
        final String trimmedName = (name != null) ? name.trim() : "";
        final String trimmedEmail = (email != null) ? email.trim() : "";
        final String trimmedPhone = (phone != null) ? phone.trim() : "";
        final String trimmedAddress = (address != null) ? address.trim() : "";

        model.addAttribute("regUsername", trimmedUsername);
        model.addAttribute("regName", trimmedName);
        model.addAttribute("regEmail", trimmedEmail);
        model.addAttribute("regPhone", trimmedPhone);
        model.addAttribute("regAddress", trimmedAddress);

        if (trimmedUsername.length() < 3 || !trimmedUsername.matches("^[a-zA-Z0-9._-]{3,30}$")) {
            model.addAttribute("error", "Username must be between 3 and 30 characters (letters, numbers, dots, dashes, underscores).");
            return "register";
        }

        if (trimmedName.length() < 3) {
            model.addAttribute("error", "Full name is required (minimum 3 characters).");
            return "register";
        }

        if (trimmedEmail.isEmpty() || !trimmedEmail.matches("^[A-Za-z0-9+_.-]+@([A-Za-z0-9.-]+\\.[A-Za-z]{2,})$")) {
            model.addAttribute("error", "Please provide a valid email address (e.g. name@example.com).");
            return "register";
        }

        if (trimmedPhone.isEmpty() || !trimmedPhone.matches("^(?:\\+94|0)?[0-9]{9,10}$")) {
            model.addAttribute("error", "Please provide a valid phone number (e.g. 0771234567 or +94771234567).");
            return "register";
        }

        if (password == null || password.trim().length() < 6) {
            model.addAttribute("error", "Password must be at least 6 characters long.");
            return "register";
        }

        if (trimmedAddress.length() < 5) {
            model.addAttribute("error", "Please provide a valid home or business address (minimum 5 characters).");
            return "register";
        }

        // Check if username already exists
        boolean usernameExists = userRepository.findAll().stream()
                .anyMatch(u -> u.getUsername().equalsIgnoreCase(trimmedUsername));

        if (usernameExists) {
            model.addAttribute("error", "Username '" + trimmedUsername + "' is already taken. Please choose another.");
            return "register";
        }

        // Check if email already exists
        boolean emailExists = userRepository.findAll().stream()
                .anyMatch(u -> trimmedEmail.equalsIgnoreCase(u.getEmail()));

        if (emailExists) {
            model.addAttribute("error", "An account with email '" + trimmedEmail + "' is already registered. Please sign in or use a different email.");
            return "register";
        }

        // Create and save User
        User user = new User();
        user.setUsername(trimmedUsername);
        user.setPassword(passwordEncoder.encode(password.trim()));
        user.setEmail(trimmedEmail);
        user.setRole("CUSTOMER");
        userRepository.save(user);

        // Create and save Customer
        Customer customer = new Customer();
        customer.setUsername(trimmedUsername);
        customer.setName(trimmedName);
        customer.setEmail(trimmedEmail);
        customer.setPhone(trimmedPhone);
        customer.setAddress(trimmedAddress);
        customerRepository.save(customer);

        return "redirect:/login?registered=true";
    }
}
