package com.landsales.crm.controller;

import com.landsales.crm.entity.Customer;
import com.landsales.crm.service.CustomerPortalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/customer")
public class CustomerPortalController {

    @Autowired
    private CustomerPortalService portalService;

    @Autowired(required = false)
    private com.landsales.admin.service.AuditLogService auditLogService;

    @GetMapping({"", "/portal", "/dashboard"})
    public String customerPortal(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }
        String username = authentication.getName();
        Customer customer = portalService.getCustomerByUsername(username);

        model.addAttribute("customer", customer);
        model.addAttribute("wishlist", portalService.getWishlist(username));
        model.addAttribute("inquiries", portalService.getCustomerInquiries(username));
        model.addAttribute("reservations", portalService.getCustomerReservations(username));
        model.addAttribute("reviews", portalService.getReviewsByCustomer(username));
        model.addAttribute("supportRequests", portalService.getSupportRequests(username));
        model.addAttribute("feedbacks", portalService.getPlatformFeedback(username));

        return "customer/portal";
    }

    @PostMapping("/reservation/submit-payment")
    public String submitPaymentProof(@RequestParam("saleId") Long saleId,
                                     @RequestParam("paymentReference") String paymentReference,
                                     @RequestParam(value = "paymentSlipUrl", required = false) String paymentSlipUrl,
                                     Authentication authentication,
                                     RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        try {
            portalService.submitCustomerPaymentProof(saleId, authentication.getName(), paymentReference, paymentSlipUrl);
            redirectAttributes.addFlashAttribute("portalSuccess", "Payment receipt & reference submitted successfully! The Sales Manager will review and verify your payment shortly.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("portalError", "Failed to submit payment proof: " + e.getMessage());
        }
        return "redirect:/customer/portal?tab=reservations";
    }

    @PostMapping("/reservation/upload-docs")
    public String uploadBuyerDocs(@RequestParam("saleId") Long saleId,
                                  @RequestParam("buyerFullName") String buyerFullName,
                                  @RequestParam("buyerNic") String buyerNic,
                                  @RequestParam(value = "nicImageUrl", required = false) String nicImageUrl,
                                  @RequestParam(value = "addressProofUrl", required = false) String addressProofUrl,
                                  @RequestParam(value = "notes", required = false) String notes,
                                  Authentication authentication,
                                  RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        try {
            portalService.updateCustomerBuyerDocs(saleId, authentication.getName(), buyerFullName, buyerNic, nicImageUrl, addressProofUrl, notes);
            if (auditLogService != null) {
                auditLogService.log("SUBMIT_BUYER_DOCS", "CUSTOMER",
                        "Customer '" + authentication.getName() + "' submitted legal deed documents (NIC: " + buyerNic + ", Name: " + buyerFullName + ") for Reservation #" + saleId);
            }
            redirectAttributes.addFlashAttribute("portalSuccess", "Buyer Legal Documents & NIC Submitted Successfully! Your reservation is now In Processing — waiting for Legal Officer approval & deed drafting.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("portalError", "Failed to submit documents: " + e.getMessage());
        }
        return "redirect:/customer/portal?tab=reservations";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("name") String name,
                                @RequestParam("email") String email,
                                @RequestParam("phone") String phone,
                                @RequestParam("address") String address,
                                @RequestParam(value = "newPassword", required = false) String newPassword,
                                Authentication authentication,
                                RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        portalService.updateCustomerProfile(username, name, email, phone, address, newPassword);
        if (auditLogService != null) {
            auditLogService.log("UPDATE_PROFILE", "CUSTOMER", "Customer '" + username + "' updated their profile information");
        }
        redirectAttributes.addFlashAttribute("profileSuccess", "Your profile has been updated successfully!");
        return "redirect:/customer/portal?tab=profile";
    }

    @PostMapping("/wishlist/toggle")
    public String toggleWishlist(@RequestParam("propertyId") Long propertyId,
                                 @RequestParam(value = "redirectUrl", defaultValue = "/customer/portal?tab=wishlist") String redirectUrl,
                                 Authentication authentication,
                                 RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        boolean added = portalService.toggleWishlist(username, propertyId);
        if (added) {
            redirectAttributes.addFlashAttribute("wishlistMsg", "Property added to your Wishlist!");
        } else {
            redirectAttributes.addFlashAttribute("wishlistMsg", "Property removed from your Wishlist.");
        }
        return "redirect:" + redirectUrl;
    }

    @GetMapping("/wishlist/remove/{propertyId}")
    public String removeFromWishlist(@PathVariable("propertyId") Long propertyId,
                                     Authentication authentication,
                                     RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        portalService.toggleWishlist(username, propertyId);
        redirectAttributes.addFlashAttribute("wishlistMsg", "Property removed from wishlist.");
        return "redirect:/customer/portal?tab=wishlist";
    }

    @PostMapping("/review/add")
    public String addReview(@RequestParam("propertyId") Long propertyId,
                            @RequestParam("rating") int rating,
                            @RequestParam("comment") String comment,
                            @RequestParam(value = "redirectUrl", required = false) String redirectUrl,
                            Authentication authentication,
                            RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        portalService.addReview(username, propertyId, rating, comment);
        if (auditLogService != null) {
            auditLogService.log("SUBMIT_REVIEW", "CUSTOMER", "Customer '" + username + "' submitted a " + rating + "-star review on property #" + propertyId);
        }
        redirectAttributes.addFlashAttribute("reviewSuccess", "Thank you! Your rating and review have been submitted.");

        if (redirectUrl != null && !redirectUrl.trim().isEmpty()) {
            return "redirect:" + redirectUrl;
        }
        return "redirect:/customer/portal?tab=reviews";
    }

    @PostMapping("/support/create")
    public String createSupportRequest(@RequestParam("subject") String subject,
                                       @RequestParam("category") String category,
                                       @RequestParam("message") String message,
                                       Authentication authentication,
                                       RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        portalService.createSupportRequest(username, subject, category, message);
        if (auditLogService != null) {
            auditLogService.log("SUPPORT_TICKET", "CUSTOMER", "Customer '" + username + "' opened a support ticket: '" + subject + "' (" + category + ")");
        }
        redirectAttributes.addFlashAttribute("supportSuccess", "Support request submitted successfully! Our team will reach out to you.");
        return "redirect:/customer/portal?tab=support";
    }

    @PostMapping("/feedback/submit")
    public String submitPlatformFeedback(@RequestParam("rating") int rating,
                                         @RequestParam("feedbackType") String feedbackType,
                                         @RequestParam("comments") String comments,
                                         Authentication authentication,
                                         RedirectAttributes redirectAttributes) {
        if (authentication == null) return "redirect:/login";

        String username = authentication.getName();
        portalService.submitPlatformFeedback(username, rating, comments, feedbackType);
        redirectAttributes.addFlashAttribute("feedbackSuccess", "Thank you for your valuable feedback!");
        return "redirect:/customer/portal?tab=feedback";
    }
}
