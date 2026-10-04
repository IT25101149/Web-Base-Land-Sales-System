package com.landsales.property.controller;

import com.landsales.property.entity.Property;
import com.landsales.property.service.PropertyService;
import com.landsales.crm.entity.Inquiry;
import com.landsales.crm.repository.InquiryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/")
public class PublicPropertyController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private InquiryRepository inquiryRepository;

    @Autowired(required = false)
    private com.landsales.notification.service.NotificationService notificationService;

    @GetMapping("/home")
    public String home(Model model) {
        List<Property> allAvailable = propertyService.getAllProperties().stream()
                .filter(p -> "AVAILABLE".equalsIgnoreCase(p.getStatus()))
                .collect(Collectors.toList());

        List<Property> featured = allAvailable.stream()
                .limit(9)
                .collect(Collectors.toList());
        model.addAttribute("featured", featured);

        // Sort reverse order for distinct newly added section
        List<Property> latest = allAvailable.stream()
                .sorted(java.util.Comparator.comparing(Property::getId, java.util.Comparator.nullsLast(java.util.Comparator.reverseOrder())))
                .limit(4)
                .collect(Collectors.toList());
        model.addAttribute("latest", latest);

        // Dynamic distinct locations from DB
        List<String> locations = allAvailable.stream()
                .map(Property::getLocation)
                .filter(l -> l != null && !l.trim().isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());
        model.addAttribute("locations", locations);
        model.addAttribute("totalAvailableCount", allAvailable.size());

        return "public/home";
    }

    @GetMapping("/properties")
    public String catalog(@RequestParam(value = "search", required = false) String search,
                          @RequestParam(value = "location", required = false) String location,
                          @RequestParam(value = "maxPrice", required = false) Double maxPrice,
                          @RequestParam(value = "size", required = false) Double size,
                          @RequestParam(value = "type", required = false) String type,
                          @RequestParam(value = "status", required = false) String status,
                          Model model) {
        // Retrieve all public land listings (excluding internal pending survey inspections)
        List<Property> allPublicLands = propertyService.getAllProperties().stream()
                .filter(p -> p.getStatus() != null && !"PENDING_SURVEY".equalsIgnoreCase(p.getStatus()))
                .collect(Collectors.toList());

        long availableCount = allPublicLands.stream().filter(p -> "AVAILABLE".equalsIgnoreCase(p.getStatus())).count();
        long reservedCount = allPublicLands.stream().filter(p -> "RESERVED".equalsIgnoreCase(p.getStatus())).count();
        long soldCount = allPublicLands.stream().filter(p -> "SOLD".equalsIgnoreCase(p.getStatus())).count();

        List<Property> properties = allPublicLands.stream()
                .filter(p -> search == null || search.trim().isEmpty() ||
                        (p.getTitle() != null && p.getTitle().toLowerCase().contains(search.toLowerCase())) ||
                        (p.getType() != null && p.getType().toLowerCase().contains(search.toLowerCase())) ||
                        (p.getLocation() != null && p.getLocation().toLowerCase().contains(search.toLowerCase())))
                .filter(p -> location == null || location.trim().isEmpty() ||
                        (p.getLocation() != null && (p.getLocation().equalsIgnoreCase(location) ||
                                p.getLocation().toLowerCase().contains(location.toLowerCase()) ||
                                location.toLowerCase().contains(p.getLocation().toLowerCase()))))
                .filter(p -> maxPrice == null || (p.getPrice() != null && p.getPrice() <= maxPrice))
                .filter(p -> size == null || (p.getSize() != null && p.getSize() >= size))
                .filter(p -> type == null || type.trim().isEmpty() || (p.getType() != null && p.getType().equalsIgnoreCase(type)))
                .filter(p -> status == null || status.trim().isEmpty() || "ALL".equalsIgnoreCase(status) ||
                        (p.getStatus() != null && p.getStatus().equalsIgnoreCase(status)))
                .collect(Collectors.toList());

        List<String> locations = allPublicLands.stream()
                .map(Property::getLocation)
                .filter(l -> l != null && !l.trim().isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());

        model.addAttribute("properties", properties);
        model.addAttribute("locations", locations);
        model.addAttribute("selectedLocation", location);
        model.addAttribute("selectedType", type);
        model.addAttribute("selectedMaxPrice", maxPrice);
        model.addAttribute("selectedSize", size);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("searchQuery", search);
        model.addAttribute("totalPublicCount", allPublicLands.size());
        model.addAttribute("availableCount", availableCount);
        model.addAttribute("reservedCount", reservedCount);
        model.addAttribute("soldCount", soldCount);
        return "public/catalog";
    }

    @Autowired
    private com.landsales.crm.service.CustomerPortalService customerPortalService;

    @GetMapping({"/properties/{id}", "/properties/detail/{id}"})
    public String detail(@PathVariable("id") Long id, Model model, org.springframework.security.core.Authentication authentication) {
        Property property = propertyService.getPropertyById(id);
        if (property == null) {
            return "redirect:/properties";
        }
        model.addAttribute("property", property);

        var reviews = customerPortalService.getReviewsForProperty(id);
        model.addAttribute("reviews", reviews);

        double avgRating = reviews.isEmpty() ? 5.0 : reviews.stream().mapToInt(r -> r.getRating()).average().orElse(5.0);
        model.addAttribute("avgRating", avgRating);

        boolean inWishlist = false;
        if (authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getName())) {
            inWishlist = customerPortalService.isPropertyInWishlist(authentication.getName(), id);
            model.addAttribute("customer", customerPortalService.getCustomerByUsername(authentication.getName()));
        }
        model.addAttribute("inWishlist", inWishlist);

        return "public/detail";
    }

    @PostMapping("/properties/inquire")
    public String submitInquiry(@RequestParam("propertyId") Long propertyId,
                                @RequestParam("customerName") String customerName,
                                @RequestParam("email") String email,
                                @RequestParam("phone") String phone,
                                @RequestParam("message") String message,
                                org.springframework.security.core.Authentication authentication,
                                org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getName())) {
            return "redirect:/login";
        }

        Property property = propertyService.getPropertyById(propertyId);
        if (property != null) {
            Inquiry inquiry = new Inquiry();
            inquiry.setProperty(property);
            inquiry.setCustomerName(customerName);
            inquiry.setUsername(authentication.getName());
            inquiry.setEmail(email);
            inquiry.setPhone(phone);
            inquiry.setMessage(message);
            inquiry.setInquiryDate(LocalDateTime.now());
            inquiryRepository.save(inquiry);

            if (notificationService != null) {
                notificationService.notifyUser(authentication.getName(), email,
                        "Inquiry Received: " + property.getTitle(),
                        "Thank you for your interest in '" + property.getTitle() + "'! Our sales team has received your message and will reach out to you at " + phone + ".",
                        "/customer/portal?tab=inquiries", "GENERAL");
                notificationService.notifyRole("SALES",
                        "New Property Inquiry: " + property.getTitle(),
                        "Customer " + customerName + " submitted an inquiry for plot '" + property.getTitle() + "'.\nContact: " + phone + " | " + email + "\nMessage: " + message,
                        "/sales", "GENERAL");
            }
        }
        return "redirect:/properties/detail/" + propertyId + "?success=true";
    }

    @GetMapping("/about")
    public String about() {
        return "public/about";
    }

    @GetMapping("/how-it-works")
    public String howItWorks() {
        return "public/how-it-works";
    }

    @GetMapping("/contact")
    public String contact() {
        return "public/contact";
    }

    @PostMapping("/contact/submit")
    public String submitGeneralContact(@RequestParam("name") String name,
                                       @RequestParam("email") String email,
                                       @RequestParam("phone") String phone,
                                       @RequestParam("message") String message) {
        Inquiry inquiry = new Inquiry();
        inquiry.setCustomerName(name);
        inquiry.setEmail(email);
        inquiry.setPhone(phone);
        inquiry.setMessage("[General Contact] " + message);
        inquiry.setInquiryDate(LocalDateTime.now());
        inquiryRepository.save(inquiry);
        return "redirect:/contact?success=true";
    }
}

