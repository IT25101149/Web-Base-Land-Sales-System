package com.landsales.crm.service;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import com.landsales.crm.entity.Customer;
import com.landsales.crm.repository.CustomerRepository;
import com.landsales.sales.repository.SaleRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired(required = false)
    private SaleRepository saleRepository;

    private static final Set<String> SYSTEM_STAFF_USERNAMES = Set.of(
            "admin", "sales", "property", "legal", "survey", "manager"
    );

    @PostConstruct
    public void cleanupStaffCustomerRecords() {
        try {
            Set<String> staffUsernames = new HashSet<>(SYSTEM_STAFF_USERNAMES);
            for (User u : userRepository.findAll()) {
                if (u.getRole() != null && !u.getRole().equalsIgnoreCase("CUSTOMER")) {
                    staffUsernames.add(u.getUsername().toLowerCase());
                }
            }

            for (Customer c : customerRepository.findAll()) {
                boolean isStaff = (c.getUsername() != null && staffUsernames.contains(c.getUsername().toLowerCase()))
                        || (c.getEmail() != null && (c.getEmail().toLowerCase().endsWith("@terrasales.com") || c.getEmail().toLowerCase().endsWith("@ceylonlands.lk")) && !c.getUsername().equalsIgnoreCase("customer"));
                if (isStaff) {
                    boolean hasSales = false;
                    if (saleRepository != null && c.getId() != null) {
                        hasSales = !saleRepository.findByCustomerIdOrderBySaleDateDesc(c.getId()).isEmpty();
                    }
                    if (!hasSales) {
                        customerRepository.delete(c);
                    }
                }
            }
        } catch (Exception ignored) {
        }
    }

    public List<Customer> getAllCustomers() {
        Set<String> staffUsernames = new HashSet<>(SYSTEM_STAFF_USERNAMES);
        Set<String> staffEmails = new HashSet<>();

        try {
            for (User u : userRepository.findAll()) {
                if (u.getRole() != null && !u.getRole().equalsIgnoreCase("CUSTOMER")) {
                    if (u.getUsername() != null) staffUsernames.add(u.getUsername().toLowerCase());
                    if (u.getEmail() != null) staffEmails.add(u.getEmail().toLowerCase());
                }
            }
        } catch (Exception ignored) {}

        return customerRepository.findAll().stream()
                .filter(c -> c.getUsername() == null || !staffUsernames.contains(c.getUsername().toLowerCase()))
                .filter(c -> c.getEmail() == null || !staffEmails.contains(c.getEmail().toLowerCase()))
                .filter(c -> {
                    if (c.getEmail() != null && (c.getEmail().toLowerCase().endsWith("@terrasales.com") || c.getEmail().toLowerCase().endsWith("@ceylonlands.lk"))) {
                        return "customer".equalsIgnoreCase(c.getUsername());
                    }
                    return true;
                })
                .collect(Collectors.toList());
    }

    public Customer getCustomerById(Long id) {
        return customerRepository.findById(id).orElse(null);
    }

    public Customer saveCustomer(Customer customer) {
        return customerRepository.save(customer);
    }

    public void deleteCustomer(Long id) {
        customerRepository.deleteById(id);
    }
}

