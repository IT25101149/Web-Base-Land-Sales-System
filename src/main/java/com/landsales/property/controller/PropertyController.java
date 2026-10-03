package com.landsales.property.controller;

import com.landsales.property.entity.Property;
import com.landsales.property.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Controller
@RequestMapping("/property")
public class PropertyController {

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private com.landsales.survey.service.SurveyService surveyService;

    @Autowired
    private com.landsales.admin.service.AuditLogService auditLogService;

    @GetMapping({"", "/list", "/dashboard"})
    public String listProperties(Model model) {
        java.util.List<Property> properties = propertyService.getAllProperties();

        long totalProperties = properties.size();
        long availableCount = properties.stream().filter(p -> "AVAILABLE".equalsIgnoreCase(p.getStatus())).count();
        long pendingSurveyCount = properties.stream().filter(p -> "PENDING_SURVEY".equalsIgnoreCase(p.getStatus())).count();
        long reservedCount = properties.stream().filter(p -> "RESERVED".equalsIgnoreCase(p.getStatus())).count();
        long soldCount = properties.stream().filter(p -> "SOLD".equalsIgnoreCase(p.getStatus())).count();

        double totalValuation = properties.stream().mapToDouble(p -> p.getPrice() != null ? p.getPrice() : 0.0).sum();
        double availableValuation = properties.stream().filter(p -> "AVAILABLE".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getPrice() != null ? p.getPrice() : 0.0).sum();
        double reservedValuation = properties.stream().filter(p -> "RESERVED".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getPrice() != null ? p.getPrice() : 0.0).sum();
        double soldValuation = properties.stream().filter(p -> "SOLD".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getPrice() != null ? p.getPrice() : 0.0).sum();

        double totalPerches = properties.stream().mapToDouble(p -> p.getSize() != null ? p.getSize() : 0.0).sum();
        double availablePerches = properties.stream().filter(p -> "AVAILABLE".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getSize() != null ? p.getSize() : 0.0).sum();
        double reservedPerches = properties.stream().filter(p -> "RESERVED".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getSize() != null ? p.getSize() : 0.0).sum();
        double soldPerches = properties.stream().filter(p -> "SOLD".equalsIgnoreCase(p.getStatus())).mapToDouble(p -> p.getSize() != null ? p.getSize() : 0.0).sum();

        long residentialCount = properties.stream().filter(p -> "RESIDENTIAL".equalsIgnoreCase(p.getType())).count();
        long commercialCount = properties.stream().filter(p -> "COMMERCIAL".equalsIgnoreCase(p.getType())).count();
        long agriculturalCount = properties.stream().filter(p -> "AGRICULTURAL".equalsIgnoreCase(p.getType())).count();
        long industrialCount = properties.stream().filter(p -> "INDUSTRIAL".equalsIgnoreCase(p.getType())).count();

        int availablePercent = totalProperties > 0 ? (int) Math.round((availableCount * 100.0) / totalProperties) : 0;
        int reservedPercent = totalProperties > 0 ? (int) Math.round((reservedCount * 100.0) / totalProperties) : 0;
        int soldPercent = totalProperties > 0 ? (int) Math.round((soldCount * 100.0) / totalProperties) : 0;
        double avgPerchPrice = totalPerches > 0 ? (totalValuation / totalPerches) : 0.0;

        model.addAttribute("properties", properties);
        model.addAttribute("totalProperties", totalProperties);
        model.addAttribute("availableCount", availableCount);
        model.addAttribute("pendingSurveyCount", pendingSurveyCount);
        model.addAttribute("reservedCount", reservedCount);
        model.addAttribute("soldCount", soldCount);
        model.addAttribute("totalValuation", totalValuation);
        model.addAttribute("availableValuation", availableValuation);
        model.addAttribute("reservedValuation", reservedValuation);
        model.addAttribute("soldValuation", soldValuation);
        model.addAttribute("totalPerches", totalPerches);
        model.addAttribute("availablePerches", availablePerches);
        model.addAttribute("reservedPerches", reservedPerches);
        model.addAttribute("soldPerches", soldPerches);
        model.addAttribute("residentialCount", residentialCount);
        model.addAttribute("commercialCount", commercialCount);
        model.addAttribute("agriculturalCount", agriculturalCount);
        model.addAttribute("industrialCount", industrialCount);
        model.addAttribute("availablePercent", availablePercent);
        model.addAttribute("reservedPercent", reservedPercent);
        model.addAttribute("soldPercent", soldPercent);
        model.addAttribute("avgPerchPrice", avgPerchPrice);

        return "property/list";
    }

    @GetMapping("/add")
    public String addPropertyForm(Model model) {
        Property p = new Property();
        p.setStatus("PENDING_SURVEY");
        p.setType("RESIDENTIAL");
        model.addAttribute("property", p);
        return "property/form";
    }

    @GetMapping("/edit/{id}")
    public String editPropertyForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Property property = propertyService.getPropertyById(id);
        if (property == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Property not found with ID: " + id);
            return "redirect:/property";
        }
        model.addAttribute("property", property);
        return "property/form";
    }

    private String processUploadFile(MultipartFile file, String title, String suffix) throws Exception {
        if (file == null || file.isEmpty()) {
            return null;
        }
        String originalFilename = file.getOriginalFilename();
        String ext = "";
        if (originalFilename != null && originalFilename.lastIndexOf(".") != -1) {
            ext = originalFilename.substring(originalFilename.lastIndexOf(".")).toLowerCase();
        }
        if (!ext.equals(".jpg") && !ext.equals(".jpeg") && !ext.equals(".png") && !ext.equals(".webp") && !ext.equals(".jfif")) {
            throw new IllegalArgumentException("Invalid image format (" + ext + "). Allowed formats: JPG, JPEG, PNG, WEBP.");
        }

        String uploadDir = "uploads/properties";
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String cleanTitle = (title != null ? title.replaceAll("[^a-zA-Z0-9.-]", "_") : "plot");
        if (cleanTitle.length() > 25) {
            cleanTitle = cleanTitle.substring(0, 25);
        }
        String newFileName = "plot_" + System.currentTimeMillis() + "_" + cleanTitle + "_" + suffix + ext;
        Path destination = Paths.get(uploadDir, newFileName);
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        return "/uploads/properties/" + newFileName;
    }

    @PostMapping("/save")
    public String saveProperty(
            @ModelAttribute("property") Property property,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "imageFile2", required = false) MultipartFile imageFile2,
            @RequestParam(value = "imageFile3", required = false) MultipartFile imageFile3,
            @RequestParam(value = "imageFile4", required = false) MultipartFile imageFile4,
            @RequestParam(value = "imageFile5", required = false) MultipartFile imageFile5,
            @RequestParam(value = "batchImageFiles", required = false) MultipartFile[] batchImageFiles,
            RedirectAttributes redirectAttributes) {
        try {
            boolean isNew = (property.getId() == null);

            // If updating existing property, preserve previous images when no replacement is submitted
            if (!isNew && property.getId() != null) {
                Property existing = propertyService.getPropertyById(property.getId());
                if (existing != null) {
                    if ((imageFile == null || imageFile.isEmpty()) && (property.getImageUrl() == null || property.getImageUrl().trim().isEmpty())) {
                        property.setImageUrl(existing.getImageUrl());
                    }
                    if ((imageFile2 == null || imageFile2.isEmpty()) && (property.getImageUrl2() == null || property.getImageUrl2().trim().isEmpty())) {
                        property.setImageUrl2(existing.getImageUrl2());
                    }
                    if ((imageFile3 == null || imageFile3.isEmpty()) && (property.getImageUrl3() == null || property.getImageUrl3().trim().isEmpty())) {
                        property.setImageUrl3(existing.getImageUrl3());
                    }
                    if ((imageFile4 == null || imageFile4.isEmpty()) && (property.getImageUrl4() == null || property.getImageUrl4().trim().isEmpty())) {
                        property.setImageUrl4(existing.getImageUrl4());
                    }
                    if ((imageFile5 == null || imageFile5.isEmpty()) && (property.getImageUrl5() == null || property.getImageUrl5().trim().isEmpty())) {
                        property.setImageUrl5(existing.getImageUrl5());
                    }
                }
            }

            // Upload individual slot files if present
            String uploadedSlot1 = processUploadFile(imageFile, property.getTitle(), "img1");
            if (uploadedSlot1 != null) property.setImageUrl(uploadedSlot1);

            String uploadedSlot2 = processUploadFile(imageFile2, property.getTitle(), "img2");
            if (uploadedSlot2 != null) property.setImageUrl2(uploadedSlot2);

            String uploadedSlot3 = processUploadFile(imageFile3, property.getTitle(), "img3");
            if (uploadedSlot3 != null) property.setImageUrl3(uploadedSlot3);

            String uploadedSlot4 = processUploadFile(imageFile4, property.getTitle(), "img4");
            if (uploadedSlot4 != null) property.setImageUrl4(uploadedSlot4);

            String uploadedSlot5 = processUploadFile(imageFile5, property.getTitle(), "img5");
            if (uploadedSlot5 != null) property.setImageUrl5(uploadedSlot5);

            // Process any batch selected image files to fill remaining empty slots
            if (batchImageFiles != null && batchImageFiles.length > 0) {
                int batchIdx = 0;
                for (MultipartFile bf : batchImageFiles) {
                    if (bf != null && !bf.isEmpty()) {
                        batchIdx++;
                        String path = processUploadFile(bf, property.getTitle(), "batch" + batchIdx);
                        if (property.getImageUrl() == null || property.getImageUrl().trim().isEmpty()) {
                            property.setImageUrl(path);
                        } else if (property.getImageUrl2() == null || property.getImageUrl2().trim().isEmpty()) {
                            property.setImageUrl2(path);
                        } else if (property.getImageUrl3() == null || property.getImageUrl3().trim().isEmpty()) {
                            property.setImageUrl3(path);
                        } else if (property.getImageUrl4() == null || property.getImageUrl4().trim().isEmpty()) {
                            property.setImageUrl4(path);
                        } else if (property.getImageUrl5() == null || property.getImageUrl5().trim().isEmpty()) {
                            property.setImageUrl5(path);
                        }
                    }
                }
            }

            // Fallback default image if slot 1 has neither upload nor link
            if (property.getImageUrl() == null || property.getImageUrl().trim().isEmpty()) {
                property.setImageUrl("https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800");
            }

            if (isNew && (property.getStatus() == null || property.getStatus().trim().isEmpty())) {
                property.setStatus("PENDING_SURVEY");
            } else if (property.getStatus() != null) {
                property.setStatus(property.getStatus().toUpperCase().trim());
            }
            Property saved = propertyService.saveProperty(property);
            if (isNew) {
                auditLogService.log("CREATE_PROPERTY", "PROPERTY", "Registered new land plot #" + saved.getId() + " '" + saved.getTitle() + "' (" + saved.getSize() + " Perches, LKR " + String.format("%,.0f", saved.getPrice()) + ") in " + saved.getLocation());
            } else {
                auditLogService.log("UPDATE_PROPERTY", "PROPERTY", "Updated land plot #" + saved.getId() + " '" + saved.getTitle() + "' - Status: " + saved.getStatus() + ", Price: LKR " + String.format("%,.0f", saved.getPrice()));
            }

            if (isNew && "PENDING_SURVEY".equalsIgnoreCase(saved.getStatus())) {
                surveyService.createPendingSurveyForProperty(saved);
                redirectAttributes.addFlashAttribute("successMsg", "New land plot '" + saved.getTitle() + "' registered with uploaded photo and queued for Land Survey Inspection!");
            } else {
                redirectAttributes.addFlashAttribute("successMsg", isNew ? "Property plot created successfully!" : "Property plot #" + property.getId() + " updated successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMsg", "Failed to save property: " + e.getMessage());
        }
        return "redirect:/property";
    }

    @PostMapping("/quick-status/{id}")
    public String updateQuickStatus(
            @PathVariable("id") Long id,
            @RequestParam("status") String status,
            RedirectAttributes redirectAttributes) {
        try {
            Property prop = propertyService.getPropertyById(id);
            if (prop != null) {
                String oldStatus = prop.getStatus() != null ? prop.getStatus() : "UNKNOWN";
                String cleanStatus = status != null ? status.toUpperCase().trim() : "AVAILABLE";
                prop.setStatus(cleanStatus);
                propertyService.saveProperty(prop);
                if (auditLogService != null) {
                    auditLogService.log("UPDATE_PROPERTY_STATUS", "PROPERTY",
                            "Changed status for land plot #" + id + " '" + prop.getTitle() + "' from " + oldStatus + " to " + cleanStatus);
                }
                redirectAttributes.addFlashAttribute("successMsg",
                        "Land plot #" + id + " ('" + prop.getTitle() + "') status successfully updated to " + cleanStatus + "!");
            } else {
                redirectAttributes.addFlashAttribute("errorMsg", "Property not found with ID: " + id);
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMsg", "Failed to update status: " + e.getMessage());
        }
        return "redirect:/property";
    }

    @RequestMapping(value = "/delete/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteProperty(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            Property prop = propertyService.getPropertyById(id);
            String title = prop != null ? prop.getTitle() : ("#" + id);
            propertyService.deleteProperty(id);
            if (auditLogService != null) {
                auditLogService.log("DELETE_PROPERTY", "PROPERTY", "Deleted land plot #" + id + " '" + title + "'");
            }
            redirectAttributes.addFlashAttribute("successMsg", "Land plot '" + title + "' (#" + id + ") deleted successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMsg", "Failed to delete property #" + id + ": " + e.getMessage());
        }
        return "redirect:/property";
    }
}


