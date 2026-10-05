package com.landsales.crm.service;

import com.landsales.admin.entity.User;
import com.landsales.admin.repository.UserRepository;
import com.landsales.crm.entity.*;
import com.landsales.crm.repository.*;
import com.landsales.property.entity.Property;
import com.landsales.property.repository.PropertyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class CustomerPortalService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private WishlistRepository wishlistRepository;

    @Autowired
    private PropertyReviewRepository propertyReviewRepository;

    @Autowired
    private SupportRequestRepository supportRequestRepository;

    @Autowired
    private PlatformFeedbackRepository platformFeedbackRepository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private InquiryRepository inquiryRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // Profile Management
    public Customer getCustomerByUsername(String username) {
        return customerRepository.findByUsername(username)
                .orElseGet(() -> {
                    // Fallback to searching by User
                    Optional<User> userOpt = userRepository.findAll().stream()
                            .filter(u -> u.getUsername().equalsIgnoreCase(username))
                            .findFirst();
                    if (userOpt.isPresent()) {
                        User user = userOpt.get();
                        // Only persist Customer record for actual CUSTOMER role users
                        if ("CUSTOMER".equalsIgnoreCase(user.getRole())) {
                            Customer newCustomer = new Customer(null, user.getUsername(), user.getUsername(), user.getEmail(), "", "");
                            return customerRepository.save(newCustomer);
                        }
                        return new Customer(null, user.getUsername(), user.getUsername(), user.getEmail(), "", "");
                    }
                    return new Customer(null, username, username, "", "", "");
                });
    }

    @Transactional
    public void updateCustomerProfile(String username, String name, String email, String phone, String address, String newPassword) {
        Customer customer = getCustomerByUsername(username);
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customerRepository.save(customer);

        // Update User table email & password
        userRepository.findAll().stream()
                .filter(u -> u.getUsername().equalsIgnoreCase(username))
                .findFirst()
                .ifPresent(user -> {
                    user.setEmail(email);
                    if (newPassword != null && !newPassword.trim().isEmpty()) {
                        user.setPassword(passwordEncoder.encode(newPassword.trim()));
                    }
                    userRepository.save(user);
                });
    }

    // Wishlist Management
    @Transactional
    public boolean toggleWishlist(String username, Long propertyId) {
        Property property = propertyRepository.findById(propertyId).orElse(null);
        if (property == null) return false;

        Optional<WishlistItem> existing = wishlistRepository.findByUsernameAndPropertyId(username, propertyId);
        if (existing.isPresent()) {
            wishlistRepository.delete(existing.get());
            return false; // Removed from wishlist
        } else {
            WishlistItem item = new WishlistItem(username, property);
            wishlistRepository.save(item);
            return true; // Added to wishlist
        }
    }

    public boolean isPropertyInWishlist(String username, Long propertyId) {
        if (username == null || propertyId == null) return false;
        return wishlistRepository.existsByUsernameAndPropertyId(username, propertyId);
    }

    public List<WishlistItem> getWishlist(String username) {
        return wishlistRepository.findByUsernameOrderByAddedAtDesc(username);
    }

    // Ratings & Reviews
    @Transactional
    public PropertyReview addReview(String username, Long propertyId, int rating, String comment) {
        Property property = propertyRepository.findById(propertyId)
                .orElseThrow(() -> new IllegalArgumentException("Property not found with ID: " + propertyId));
        Customer customer = getCustomerByUsername(username);
        String customerName = (customer.getName() != null && !customer.getName().trim().isEmpty()) ? customer.getName() : username;

        // Ensure rating is bounded 1-5
        int boundedRating = Math.max(1, Math.min(5, rating));
        PropertyReview review = new PropertyReview(property, username, customerName, boundedRating, comment);
        return propertyReviewRepository.save(review);
    }

    public List<PropertyReview> getReviewsForProperty(Long propertyId) {
        return propertyReviewRepository.findByPropertyIdOrderByCreatedAtDesc(propertyId);
    }

    public List<PropertyReview> getReviewsByCustomer(String username) {
        return propertyReviewRepository.findByUsernameOrderByCreatedAtDesc(username);
    }

    // Support Requests
    @Transactional
    public SupportRequest createSupportRequest(String username, String subject, String category, String message) {
        Customer customer = getCustomerByUsername(username);
        String customerName = (customer.getName() != null && !customer.getName().trim().isEmpty()) ? customer.getName() : username;
        SupportRequest req = new SupportRequest(username, customerName, customer.getEmail(), customer.getPhone(), subject, category, message);
        return supportRequestRepository.save(req);
    }

    public List<SupportRequest> getSupportRequests(String username) {
        return supportRequestRepository.findByUsernameOrderByCreatedAtDesc(username);
    }

    // Platform Feedback
    @Transactional
    public PlatformFeedback submitPlatformFeedback(String username, int rating, String comments, String feedbackType) {
        Customer customer = getCustomerByUsername(username);
        String customerName = (customer.getName() != null && !customer.getName().trim().isEmpty()) ? customer.getName() : username;
        int boundedRating = Math.max(1, Math.min(5, rating));
        PlatformFeedback feedback = new PlatformFeedback(username, customerName, boundedRating, comments, feedbackType);
        return platformFeedbackRepository.save(feedback);
    }

    public List<PlatformFeedback> getPlatformFeedback(String username) {
        return platformFeedbackRepository.findByUsernameOrderByCreatedAtDesc(username);
    }

    @Autowired
    private com.landsales.sales.repository.SaleRepository saleRepository;

    @Autowired
    private com.landsales.sales.service.SaleService saleService;

    // Customer Inquiries
    public List<Inquiry> getCustomerInquiries(String username) {
        Customer customer = getCustomerByUsername(username);
        List<Inquiry> list = new java.util.ArrayList<>();
        if (username != null && !username.trim().isEmpty()) {
            list.addAll(inquiryRepository.findAll().stream()
                    .filter(i -> username.equalsIgnoreCase(i.getUsername()))
                    .toList());
        }
        if (customer != null && customer.getEmail() != null && !customer.getEmail().trim().isEmpty()) {
            List<Inquiry> emailInquiries = inquiryRepository.findByEmailOrderByInquiryDateDesc(customer.getEmail());
            for (Inquiry inq : emailInquiries) {
                if (!list.contains(inq)) {
                    list.add(inq);
                }
            }
        }
        return list;
    }

    // Customer Reservations & Deeds
    public List<com.landsales.sales.entity.Sale> getCustomerReservations(String username) {
        Customer customer = getCustomerByUsername(username);
        List<com.landsales.sales.entity.Sale> list = new java.util.ArrayList<>();
        if (customer != null && customer.getId() != null) {
            list.addAll(saleRepository.findByCustomerIdOrderBySaleDateDesc(customer.getId()));
        }

        // Also check any inquiry made by this user that has a saleId
        List<Inquiry> userInquiries = getCustomerInquiries(username);
        for (Inquiry inq : userInquiries) {
            if (inq.getSaleId() != null) {
                saleRepository.findById(inq.getSaleId()).ifPresent(s -> {
                    if (!list.contains(s)) {
                        list.add(s);
                    }
                });
            }
        }

        // Fallback check by email or username if id did not link
        List<com.landsales.sales.entity.Sale> allSales = saleRepository.findAll();
        for (com.landsales.sales.entity.Sale s : allSales) {
            if (s.getCustomer() != null) {
                boolean matches = false;
                if (customer != null && customer.getEmail() != null && !customer.getEmail().isEmpty() && customer.getEmail().equalsIgnoreCase(s.getCustomer().getEmail())) {
                    matches = true;
                }
                if (customer != null && customer.getUsername() != null && !customer.getUsername().isEmpty() && customer.getUsername().equalsIgnoreCase(s.getCustomer().getUsername())) {
                    matches = true;
                }
                if (customer != null && customer.getName() != null && !customer.getName().isEmpty() && customer.getName().equalsIgnoreCase(s.getCustomer().getName())) {
                    matches = true;
                }
                if (matches && !list.contains(s)) {
                    list.add(s);
                }
            }
        }
        return list;
    }

    @Transactional
    public void submitCustomerPaymentProof(Long saleId, String username, String paymentReference, String paymentSlipUrl) {
        var sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Reservation not found: " + saleId));

        saleService.submitCustomerPaymentProof(saleId, paymentReference, paymentSlipUrl);
    }

    @Transactional
    public void updateCustomerBuyerDocs(Long saleId, String username, String buyerFullName, String buyerNic, String nicImageUrl, String addressProofUrl, String notes) {
        var sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Reservation not found: " + saleId));

        saleService.updateBuyerDocumentation(saleId, buyerFullName, buyerNic, nicImageUrl, addressProofUrl, notes);
    }
}
