package com.landsales.sales.service;

import com.landsales.sales.entity.Sale;
import com.landsales.sales.repository.SaleRepository;
import com.landsales.property.entity.Property;
import com.landsales.property.repository.PropertyRepository;
import com.landsales.crm.entity.Customer;
import com.landsales.crm.repository.CustomerRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.List;

@Service
public class SaleService {

    @Autowired
    private SaleRepository saleRepository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired(required = false)
    private com.landsales.admin.service.AuditLogService auditLogService;

    @Autowired(required = false)
    private com.landsales.notification.service.NotificationService notificationService;

    @PostConstruct
    public void initData() {
        // Seed historical sales for prior months if repository has minimal records,
        // providing management with rich Month-over-Month comparative analytics.
        try {
            if (saleRepository.count() <= 4) {
                var properties = propertyRepository.findAll();
                var customers = customerRepository.findAll();
                if (properties.size() >= 3 && customers.size() >= 2) {
                    boolean hasJuneSale = saleRepository.findAll().stream()
                            .anyMatch(s -> s.getSaleDate() != null && s.getSaleDate().getMonthValue() == 6 && s.getSaleDate().getYear() == 2026);
                    if (!hasJuneSale) {
                        Property p1 = properties.get(1);
                        Customer c1 = customers.get(0);
                        Sale s1 = new Sale();
                        s1.setProperty(p1);
                        s1.setCustomer(c1);
                        s1.setSalePrice(3850000.0);
                        s1.setAdvancePaid(3850000.0);
                        s1.setBalanceAmount(0.0);
                        s1.setSaleDate(LocalDate.of(2026, 6, 18));
                        s1.setStatus("COMPLETED");
                        s1.setPaymentStatus("FULLY_PAID");
                        s1.setLegalStatus("OWNERSHIP_TRANSFERRED");
                        s1.setBuyerFullName(c1.getName());
                        s1.setBankDetails("Commercial Bank - Colombo Corporate Branch");
                        s1.setPaymentReference("DEP-2026-0618-882");
                        s1.setPaymentApprovedBy("admin");
                        s1.setPaymentApprovedAt(java.time.LocalDateTime.of(2026, 6, 18, 14, 30));
                        s1.setSalesNotes("Completed transaction - June 2026 deed registered");
                        saleRepository.save(s1);
                    }

                    boolean hasJulySale = saleRepository.findAll().stream()
                            .anyMatch(s -> s.getSaleDate() != null && s.getSaleDate().getMonthValue() == 7 && s.getSaleDate().getYear() == 2026);
                    if (!hasJulySale) {
                        Property p2 = properties.get(2);
                        Customer c2 = customers.size() > 1 ? customers.get(1) : customers.get(0);
                        Sale s2 = new Sale();
                        s2.setProperty(p2);
                        s2.setCustomer(c2);
                        s2.setSalePrice(5200000.0);
                        s2.setAdvancePaid(5200000.0);
                        s2.setBalanceAmount(0.0);
                        s2.setSaleDate(LocalDate.of(2026, 7, 24));
                        s2.setStatus("COMPLETED");
                        s2.setPaymentStatus("FULLY_PAID");
                        s2.setLegalStatus("OWNERSHIP_TRANSFERRED");
                        s2.setBuyerFullName(c2.getName());
                        s2.setBankDetails("Commercial Bank - Colombo Corporate Branch");
                        s2.setPaymentReference("DEP-2026-0724-914");
                        s2.setPaymentApprovedBy("admin");
                        s2.setPaymentApprovedAt(java.time.LocalDateTime.of(2026, 7, 24, 11, 15));
                        s2.setSalesNotes("Completed transaction - July 2026 conveyancing finalized");
                        saleRepository.save(s2);
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Note: SaleService initData deferred: " + e.getMessage());
        }
    }

    public List<Sale> getAllSales() {
        return saleRepository.findAll();
    }

    @Transactional
    public Sale createReservation(Long propertyId, Long customerId, Double salePrice) {
        Property property = propertyRepository.findById(propertyId)
                .orElseThrow(() -> new IllegalArgumentException("Property not found"));
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new IllegalArgumentException("Customer not found"));

        // Update property status
        property.setStatus("RESERVED");
        propertyRepository.save(property);

        Sale sale = new Sale();
        sale.setProperty(property);
        sale.setCustomer(customer);
        double price = (salePrice != null && salePrice > 0) ? salePrice : (property.getPrice() != null ? property.getPrice() : 0.0);
        double advance = Math.min(500000.0, price > 0 ? Math.round(price * 0.1) : 500000.0);
        sale.setSalePrice(price);
        sale.setAdvancePaid(advance);
        sale.setBalanceAmount(price - advance);
        sale.setSaleDate(LocalDate.now());
        sale.setStatus("PENDING_PAYMENT");
        sale.setPaymentStatus("PENDING_PAYMENT");
        sale.setBankDetails("Commercial Bank of Ceylon PLC\nAccount Name: Ceylon Lands (Pvt) Ltd\nAccount Number: 1000849201\nBranch: Colombo Corporate Branch (03)\nSwift: CCBLKLK");
        sale.setSalesNotes("Plot reservation recorded by Sales Manager for registered customer " + customer.getName());
        sale.setBuyerFullName(customer.getName());
        sale.setLegalStatus("LOCKED_AWAITING_PAYMENT");

        Sale savedSale = saleRepository.save(sale);

        if (auditLogService != null) {
            auditLogService.log("CREATE_RESERVATION", "Sales",
                    "Created reservation for property '" + property.getTitle() + "' (#" + property.getId() + ") for customer " + customer.getName() + " with advance LKR " + String.format("%,.2f", advance));
        }

        if (notificationService != null) {
            notificationService.notifyUser(customer.getUsername(), customer.getEmail(),
                    "Reservation Created: " + property.getTitle(),
                    "Your land reservation for '" + property.getTitle() + "' has been recorded successfully. Advance payable: LKR " + String.format("%,.2f", advance) + ". Sales team will review details shortly.",
                    "/customer/portal?tab=reservations", "RESERVATION");
            notificationService.notifyRole("SALES",
                    "New Plot Reservation: " + property.getTitle(),
                    "A new plot reservation was recorded for '" + property.getTitle() + "' for customer " + customer.getName() + " (Total: LKR " + String.format("%,.2f", price) + ").",
                    "/sales", "RESERVATION");
        }

        return savedSale;
    }

    @Autowired
    private com.landsales.crm.repository.InquiryRepository inquiryRepository;

    @Autowired
    private com.landsales.legal.repository.LegalDocumentRepository legalDocumentRepository;

    @Transactional
    public Sale approveInquiryAsReservation(Long inquiryId) {
        var inquiry = inquiryRepository.findById(inquiryId)
                .orElseThrow(() -> new IllegalArgumentException("Inquiry not found: " + inquiryId));
        double price = (inquiry.getProperty() != null && inquiry.getProperty().getPrice() != null) ? inquiry.getProperty().getPrice() : 0.0;
        double advance = Math.min(500000.0, price > 0 ? Math.round(price * 0.1) : 500000.0);
        return approveInquiryWithBankDetails(inquiryId, advance,
                "Commercial Bank of Ceylon PLC\nAccount Name: Ceylon Lands (Pvt) Ltd\nAccount Number: 1000849201\nBranch: Colombo Corporate Branch (03)\nSwift: CCBLKLK",
                "Plot reservation approved by Sales Manager. Please transfer required advance deposit to lock land plot and unlock legal conveyancing.");
    }

    @Transactional
    public Sale approveInquiryWithAdvance(Long inquiryId, Double advanceAmount, String salesNotes) {
        return approveInquiryWithBankDetails(inquiryId, advanceAmount, "Commercial Bank (Account Name: Ceylon Lands Pvt Ltd, A/C: 1000849201, Branch: Colombo 03)", salesNotes);
    }

    @Transactional
    public Sale approveInquiryWithBankDetails(Long inquiryId, Double advanceAmount, String bankDetails, String salesNotes) {
        var inquiry = inquiryRepository.findById(inquiryId)
                .orElseThrow(() -> new IllegalArgumentException("Inquiry not found"));

        Property property = inquiry.getProperty();
        if (property == null) {
            throw new IllegalArgumentException("Inquiry has no associated property");
        }

        // Find or create Customer from Inquiry (matching username first!)
        Customer customer = null;
        if (inquiry.getUsername() != null && !inquiry.getUsername().trim().isEmpty()) {
            customer = customerRepository.findByUsername(inquiry.getUsername()).orElse(null);
        }
        if (customer == null && inquiry.getEmail() != null && !inquiry.getEmail().trim().isEmpty()) {
            customer = customerRepository.findByEmail(inquiry.getEmail()).orElse(null);
        }
        if (customer == null) {
            String uname = (inquiry.getUsername() != null && !inquiry.getUsername().trim().isEmpty())
                    ? inquiry.getUsername()
                    : (inquiry.getEmail() != null && !inquiry.getEmail().trim().isEmpty() ? inquiry.getEmail().split("@")[0] : inquiry.getCustomerName().replaceAll("\\s+", "").toLowerCase());
            Customer newCust = new Customer(null, uname, inquiry.getCustomerName(), inquiry.getEmail(), inquiry.getPhone(), "");
            customer = customerRepository.save(newCust);
        }

        // Update property to RESERVED (hold)
        property.setStatus("RESERVED");
        propertyRepository.save(property);

        // Create Sale record in PENDING_PAYMENT state
        Sale sale = new Sale();
        sale.setProperty(property);
        sale.setCustomer(customer);
        double price = property.getPrice() != null ? property.getPrice() : 0.0;
        double advance = advanceAmount != null ? advanceAmount : 0.0;
        sale.setSalePrice(price);
        sale.setAdvancePaid(advance);
        sale.setBalanceAmount(price - advance);
        sale.setSaleDate(LocalDate.now());
        sale.setStatus("PENDING_PAYMENT"); // Customer must pay advance/price first!
        sale.setPaymentStatus("PENDING_PAYMENT");
        sale.setBankDetails(bankDetails != null && !bankDetails.trim().isEmpty() ? bankDetails : "Commercial Bank - Ceylon Lands (Pvt) Ltd - A/C 1000849201 - Colombo 03");
        sale.setSalesNotes(salesNotes);
        sale.setBuyerFullName(customer.getName());
        sale.setLegalStatus("LOCKED_AWAITING_PAYMENT"); // Locked until payment approved

        Sale savedSale = saleRepository.save(sale);

        // Update inquiry status to PENDING_PAYMENT instead of deleting
        inquiry.setStatus("PENDING_PAYMENT");
        inquiry.setSaleId(savedSale.getId());
        inquiryRepository.save(inquiry);

        if (auditLogService != null) {
            auditLogService.log("APPROVE_INQUIRY", "Sales",
                    "Approved inquiry #" + inquiryId + " into reservation for property '" + property.getTitle() + "' for customer " + customer.getName() + " with advance deposit LKR " + String.format("%,.2f", advance));
        }

        if (notificationService != null) {
            notificationService.notifyUser(customer.getUsername(), customer.getEmail(),
                    "Reservation Approved: " + property.getTitle(),
                    "Your reservation for '" + property.getTitle() + "' has been APPROVED by the Sales Manager!\nAdvance Amount: LKR " + String.format("%,.2f", advance) + "\nBank Details: " + savedSale.getBankDetails() + "\nPlease deposit the advance and submit your receipt in the customer portal.",
                    "/customer/portal?tab=reservations", "PAYMENT");
            notificationService.notifyRole("SALES",
                    "Reservation Approved: " + property.getTitle(),
                    "Reservation approved for customer " + customer.getName() + ". Payment instructions dispatched.",
                    "/sales", "RESERVATION");
        }

        return savedSale;
    }

    @Transactional
    public void cancelInquiry(Long inquiryId) {
        inquiryRepository.findById(inquiryId).ifPresent(inq -> {
            inq.setStatus("CANCELLED");
            inquiryRepository.save(inq);
            if (inq.getSaleId() != null) {
                cancelReservation(inq.getSaleId());
            }
            if (auditLogService != null) {
                auditLogService.log("CANCEL_INQUIRY", "Sales",
                        "Cancelled customer inquiry #" + inquiryId + " (" + inq.getCustomerName() + ")");
            }
        });
    }

    @Transactional
    public void submitCustomerPaymentProof(Long saleId, String paymentReference, String paymentSlipUrl) {
        Sale sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale record not found: " + saleId));

        sale.setPaymentReference(paymentReference);
        sale.setPaymentSlipUrl(paymentSlipUrl);
        sale.setPaymentStatus("PAYMENT_SUBMITTED"); // Pending Sales Manager approval
        saleRepository.save(sale);

        // Update corresponding inquiry if exists
        inquiryRepository.findAll().stream()
                .filter(i -> saleId.equals(i.getSaleId()))
                .findFirst()
                .ifPresent(inq -> {
                    inq.setStatus("PAYMENT_SUBMITTED");
                    inquiryRepository.save(inq);
                });

        if (auditLogService != null) {
            String customerName = (sale.getCustomer() != null && sale.getCustomer().getName() != null) ? sale.getCustomer().getName() : "Customer";
            auditLogService.log("SUBMIT_PAYMENT", "SALES",
                    "Customer " + customerName + " submitted payment slip/ref '" + paymentReference + "' for reservation #" + saleId + (sale.getProperty() != null ? " (" + sale.getProperty().getTitle() + ")" : ""));
        }

        if (notificationService != null) {
            String customerName = (sale.getCustomer() != null && sale.getCustomer().getName() != null) ? sale.getCustomer().getName() : "Customer";
            notificationService.notifyRole("SALES",
                    "Payment Slip Uploaded: Reservation #" + saleId,
                    "Customer " + customerName + " uploaded bank payment slip (Ref: " + paymentReference + ") for Reservation #" + saleId + ". Please verify funds.",
                    "/sales", "PAYMENT");
        }
    }

    @Transactional
    public void confirmPaymentAndUnlockLegal(Long saleId) {
        Sale sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale record not found: " + saleId));

        String approver = (auditLogService != null) ? auditLogService.getCurrentUsername() : "system";

        // Sales Manager full approves payment -> record who approved it!
        sale.setPaymentApprovedBy(approver);
        sale.setPaymentApprovedAt(java.time.LocalDateTime.now());
        sale.setPaymentStatus("PAYMENT_VERIFIED");
        sale.setStatus("FULL_APPROVED"); // Or RESERVED
        sale.setLegalStatus("PENDING_DOCS"); // Document submission is now UNLOCKED for customer
        saleRepository.save(sale);

        // Update corresponding inquiry if exists
        inquiryRepository.findAll().stream()
                .filter(i -> saleId.equals(i.getSaleId()))
                .findFirst()
                .ifPresent(inq -> {
                    inq.setStatus("FULL_APPROVED");
                    inquiryRepository.save(inq);
                });

        // Create initial legal conveyancing docket
        com.landsales.legal.entity.LegalDocument initialDoc = new com.landsales.legal.entity.LegalDocument(
                sale, sale.getProperty(), "RESERVATION_ORDER", "Plot Reservation & Payment Clearance - " + sale.getProperty().getTitle(),
                sale.getPaymentSlipUrl() != null ? sale.getPaymentSlipUrl() : "",
                "Payment verified by Sales Manager '" + approver + "'. Handed over to Legal Department for title search and Deed of Transfer execution."
        );
        legalDocumentRepository.save(initialDoc);

        if (auditLogService != null) {
            auditLogService.log("CONFIRM_PAYMENT", "SALES",
                    "Payment of LKR " + String.format("%,.2f", sale.getAdvancePaid() != null ? sale.getAdvancePaid() : 0.0) +
                            " verified and approved by operator '" + approver + "' for reservation #" + saleId +
                            (sale.getProperty() != null ? " (" + sale.getProperty().getTitle() + ")" : "") +
                            ". Conveyancing unlocked & forwarded to Legal Department.");
        }

        if (notificationService != null) {
            String customerUname = (sale.getCustomer() != null) ? sale.getCustomer().getUsername() : null;
            String customerEmail = (sale.getCustomer() != null) ? sale.getCustomer().getEmail() : null;
            notificationService.notifyUser(customerUname, customerEmail,
                    "Payment Verified! Legal Conveyancing Unlocked",
                    "Your payment for '" + sale.getProperty().getTitle() + "' was verified by the Sales Manager! Conveyancing is now open. Please upload your NIC and address proof in the customer portal to initiate Deed preparation.",
                    "/customer/portal?tab=reservations", "PAYMENT");
            notificationService.notifyRole("LEGAL",
                    "New Conveyancing Case: " + sale.getProperty().getTitle(),
                    "Customer payment was verified for Reservation #" + saleId + ". The conveyancing case is unlocked for title search and Deed of Transfer execution.",
                    "/legal", "LEGAL_DEED");
        }
    }

    @Transactional
    public void cancelReservation(Long saleId) {
        Sale sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale record not found: " + saleId));

        sale.setStatus("CANCELLED");
        sale.setPaymentStatus("CANCELLED");
        sale.setLegalStatus("CANCELLED");
        saleRepository.save(sale);

        Property property = sale.getProperty();
        if (property != null) {
            property.setStatus("AVAILABLE");
            propertyRepository.save(property);
        }

        syncInquiryStatus(saleId, "CANCELLED");

        if (auditLogService != null) {
            auditLogService.log("CANCEL_RESERVATION", "Sales",
                    "Cancelled reservation #" + saleId + (property != null ? " for property '" + property.getTitle() + "'" : ""));
        }

        if (notificationService != null && sale.getCustomer() != null) {
            notificationService.notifyUser(sale.getCustomer().getUsername(), sale.getCustomer().getEmail(),
                    "Reservation Cancelled: " + (property != null ? property.getTitle() : "Plot #" + saleId),
                    "Your reservation #" + saleId + " has been cancelled. The property has been restored to available inventory.",
                    "/customer/portal?tab=reservations", "RESERVATION");
        }
    }

    @Transactional
    public void updateBuyerDocumentation(Long saleId, String buyerFullName, String buyerNic, String nicImageUrl, String addressProofUrl, String notes) {
        Sale sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale record not found: " + saleId));

        // Ensure payment is verified before accepting deed documentation
        if (!"PAYMENT_VERIFIED".equalsIgnoreCase(sale.getPaymentStatus()) && !"FULLY_PAID".equalsIgnoreCase(sale.getPaymentStatus()) && !"PAID".equalsIgnoreCase(sale.getPaymentStatus())) {
            throw new IllegalStateException("Payment must be verified by Sales Manager before submitting deed documentation.");
        }

        if (buyerFullName != null && !buyerFullName.trim().isEmpty()) {
            sale.setBuyerFullName(buyerFullName.trim());
        }
        if (buyerNic != null && !buyerNic.trim().isEmpty()) {
            sale.setBuyerNic(buyerNic.trim());
        }
        if (nicImageUrl != null && !nicImageUrl.trim().isEmpty()) {
            sale.setNicImageUrl(nicImageUrl.trim());
            // Create legal doc record for NIC
            com.landsales.legal.entity.LegalDocument nicDoc = new com.landsales.legal.entity.LegalDocument(
                    sale, sale.getProperty(), "BUYER_NIC", "Customer NIC Copy - " + sale.getBuyerNic(),
                    nicImageUrl.trim(), "Uploaded by customer for deed title registration."
            );
            legalDocumentRepository.save(nicDoc);
        }
        if (addressProofUrl != null && !addressProofUrl.trim().isEmpty()) {
            sale.setAddressProofUrl(addressProofUrl.trim());
            // Create legal doc record for Address Proof
            com.landsales.legal.entity.LegalDocument addrDoc = new com.landsales.legal.entity.LegalDocument(
                    sale, sale.getProperty(), "ADDRESS_PROOF", "Proof of Billing / Address - " + sale.getBuyerFullName(),
                    addressProofUrl.trim(), "Uploaded by customer for deed title registration."
            );
            legalDocumentRepository.save(addrDoc);
        }

        sale.setLegalStatus("DOCS_SUBMITTED");
        sale.setLegalNotes(null); // Clear previous rejection note upon resubmission
        saleRepository.save(sale);

        if (notificationService != null) {
            notificationService.notifyRole("LEGAL",
                    "Buyer Deed Documents Submitted: Case #" + saleId,
                    "Buyer " + buyerFullName + " (NIC: " + buyerNic + ") has submitted identification and proof of address for Reservation #" + saleId + ". Ready for Legal Officer review.",
                    "/legal", "LEGAL_DEED");
        }
    }

    @Transactional
    public void confirmSale(Long saleId) {
        Sale sale = saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale not found"));

        sale.setStatus("COMPLETED");
        sale.setPaymentStatus("FULLY_PAID");
        sale.setLegalStatus("OWNERSHIP_TRANSFERRED");
        saleRepository.save(sale);

        Property property = sale.getProperty();
        if (property != null) {
            property.setStatus("SOLD");
            propertyRepository.save(property);
        }

        syncInquiryStatus(saleId, "COMPLETED");

        if (auditLogService != null) {
            auditLogService.log("CONFIRM_SALE", "Sales",
                    "Confirmed and finalized sale for property '" + (property != null ? property.getTitle() : "ID:" + saleId) + "' to customer " + (sale.getCustomer() != null ? sale.getCustomer().getName() : "N/A"));
        }

        if (notificationService != null && sale.getCustomer() != null) {
            notificationService.notifyUser(sale.getCustomer().getUsername(), sale.getCustomer().getEmail(),
                    "🎉 Sale Confirmed: " + (property != null ? property.getTitle() : "Plot #" + saleId),
                    "Congratulations! The sale and registration for '" + (property != null ? property.getTitle() : "Plot #" + saleId) + "' is finalized. Welcome to property ownership with Ceylon Lands!",
                    "/customer/portal?tab=reservations", "LEGAL_DEED");
            notificationService.notifyRole("PROPERTY",
                    "Property Marked as SOLD: " + (property != null ? property.getTitle() : "Plot #" + saleId),
                    "Transaction finalized. Property status has transitioned to SOLD in inventory.",
                    "/property", "LEGAL_DEED");
        }
    }

    @Transactional
    public void syncInquiryStatus(Long saleId, String status) {
        if (saleId == null || inquiryRepository == null) return;
        List<com.landsales.crm.entity.Inquiry> inqs = inquiryRepository.findBySaleId(saleId);
        if (inqs.isEmpty()) {
            saleRepository.findById(saleId).ifPresent(s -> {
                if (s.getProperty() != null) {
                    List<com.landsales.crm.entity.Inquiry> propInqs = inquiryRepository.findByPropertyId(s.getProperty().getId());
                    for (com.landsales.crm.entity.Inquiry pi : propInqs) {
                        if (pi.getSaleId() == null && s.getCustomer() != null &&
                                ((pi.getEmail() != null && pi.getEmail().equalsIgnoreCase(s.getCustomer().getEmail())) ||
                                        (pi.getUsername() != null && pi.getUsername().equalsIgnoreCase(s.getCustomer().getUsername())))) {
                            pi.setSaleId(s.getId());
                            pi.setStatus(status);
                            inquiryRepository.save(pi);
                        }
                    }
                }
            });
        } else {
            for (com.landsales.crm.entity.Inquiry inq : inqs) {
                inq.setStatus(status);
                inquiryRepository.save(inq);
            }
        }
    }

    @Transactional
    public List<com.landsales.crm.entity.Inquiry> getAllInquiries() {
        List<com.landsales.crm.entity.Inquiry> inquiries = inquiryRepository.findAll();
        List<Sale> allSales = saleRepository.findAll();

        // Auto-synchronize inquiries with sales records
        for (com.landsales.crm.entity.Inquiry inq : inquiries) {
            Sale matchedSale = null;
            if (inq.getSaleId() != null) {
                matchedSale = allSales.stream().filter(s -> s.getId().equals(inq.getSaleId())).findFirst().orElse(null);
            } else if (inq.getProperty() != null) {
                // Auto-link if property and customer match
                matchedSale = allSales.stream()
                        .filter(s -> s.getProperty() != null && s.getProperty().getId().equals(inq.getProperty().getId()))
                        .filter(s -> s.getCustomer() != null && (
                                (inq.getEmail() != null && inq.getEmail().equalsIgnoreCase(s.getCustomer().getEmail())) ||
                                        (inq.getUsername() != null && inq.getUsername().equalsIgnoreCase(s.getCustomer().getUsername()))
                        ))
                        .findFirst().orElse(null);
                if (matchedSale != null) {
                    inq.setSaleId(matchedSale.getId());
                }
            }

            if (matchedSale != null) {
                String expectedStatus = inq.getStatus();
                if ("COMPLETED".equalsIgnoreCase(matchedSale.getStatus()) || "OWNERSHIP_TRANSFERRED".equalsIgnoreCase(matchedSale.getLegalStatus())) {
                    expectedStatus = "COMPLETED";
                } else if ("FULL_APPROVED".equalsIgnoreCase(matchedSale.getStatus()) || "PAYMENT_VERIFIED".equalsIgnoreCase(matchedSale.getPaymentStatus())) {
                    expectedStatus = "FULL_APPROVED";
                } else if ("PAYMENT_SUBMITTED".equalsIgnoreCase(matchedSale.getPaymentStatus())) {
                    expectedStatus = "PAYMENT_SUBMITTED";
                } else if ("PENDING_PAYMENT".equalsIgnoreCase(matchedSale.getPaymentStatus()) || "PENDING_PAYMENT".equalsIgnoreCase(matchedSale.getStatus())) {
                    expectedStatus = "PENDING_PAYMENT";
                } else if ("CANCELLED".equalsIgnoreCase(matchedSale.getStatus())) {
                    expectedStatus = "CANCELLED";
                }

                if (!expectedStatus.equals(inq.getStatus())) {
                    inq.setStatus(expectedStatus);
                    inquiryRepository.save(inq);
                }
            }
        }

        // Return sorted by inquiry date descending
        inquiries.sort((a, b) -> {
            if (a.getInquiryDate() == null && b.getInquiryDate() == null) return 0;
            if (a.getInquiryDate() == null) return 1;
            if (b.getInquiryDate() == null) return -1;
            return b.getInquiryDate().compareTo(a.getInquiryDate());
        });

        return inquiries;
    }
}

