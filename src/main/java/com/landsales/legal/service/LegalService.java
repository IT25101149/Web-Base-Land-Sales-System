package com.landsales.legal.service;

import com.landsales.legal.entity.LegalDocument;
import com.landsales.legal.repository.LegalDocumentRepository;
import com.landsales.sales.entity.Sale;
import com.landsales.sales.repository.SaleRepository;
import com.landsales.property.entity.Property;
import com.landsales.property.repository.PropertyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class LegalService {

    @Autowired
    private LegalDocumentRepository legalDocumentRepository;

    @Autowired
    private SaleRepository saleRepository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired(required = false)
    private com.landsales.crm.repository.InquiryRepository inquiryRepository;

    @Autowired(required = false)
    private com.landsales.admin.service.AuditLogService auditLogService;

    @Autowired(required = false)
    private com.landsales.notification.service.NotificationService notificationService;

    public List<Sale> getAllConveyancingCases() {
        return saleRepository.findAllByOrderBySaleDateDesc().stream()
                .filter(s -> !"CANCELLED".equalsIgnoreCase(s.getStatus()))
                .filter(s -> !"LOCKED_AWAITING_PAYMENT".equalsIgnoreCase(s.getLegalStatus()))
                .toList();
    }

    public Sale getCaseById(Long saleId) {
        return saleRepository.findById(saleId)
                .orElseThrow(() -> new IllegalArgumentException("Sale Case not found with ID: " + saleId));
    }

    public List<LegalDocument> getDocumentsForSale(Long saleId) {
        return legalDocumentRepository.findBySaleIdOrderByUploadedAtDesc(saleId);
    }

    @Transactional
    public void updateLegalCaseStatus(Long saleId, String legalStatus, String deedNumber, String notaryName, String legalNotes, String transferCertificateUrl, String verifiedBy) {
        Sale sale = getCaseById(saleId);
        sale.setLegalStatus(legalStatus);

        if (deedNumber != null && !deedNumber.trim().isEmpty()) {
            sale.setDeedNumber(deedNumber.trim());
        }
        if (notaryName != null && !notaryName.trim().isEmpty()) {
            sale.setNotaryName(notaryName.trim());
        }
        if (legalNotes != null && !legalNotes.trim().isEmpty()) {
            sale.setLegalNotes(legalNotes.trim());
        }
        if (transferCertificateUrl != null && !transferCertificateUrl.trim().isEmpty()) {
            sale.setTransferCertificateUrl(transferCertificateUrl.trim());

            LegalDocument certDoc = new LegalDocument(
                    sale, sale.getProperty(), "TRANSFER_CERTIFICATE",
                    "Official Ownership Transfer Certificate - " + (sale.getDeedNumber() != null ? sale.getDeedNumber() : "Case #" + saleId),
                    transferCertificateUrl.trim(),
                    "Issued and submitted by Legal Officer: " + (verifiedBy != null ? verifiedBy : "Legal Dept")
            );
            certDoc.setStatus("VERIFIED");
            certDoc.setVerifiedBy(verifiedBy);
            legalDocumentRepository.save(certDoc);
        }

        if ("OWNERSHIP_TRANSFERRED".equalsIgnoreCase(legalStatus)) {
            sale.setStatus("COMPLETED");
            sale.setPaymentStatus("FULLY_PAID");

            Property property = sale.getProperty();
            if (property != null) {
                property.setStatus("SOLD");
                propertyRepository.save(property);
            }

            if (inquiryRepository != null) {
                List<com.landsales.crm.entity.Inquiry> inqs = inquiryRepository.findBySaleId(saleId);
                if (inqs.isEmpty() && property != null) {
                    inqs = inquiryRepository.findByPropertyId(property.getId()).stream()
                            .filter(i -> i.getSaleId() == null && sale.getCustomer() != null &&
                                    ((i.getEmail() != null && i.getEmail().equalsIgnoreCase(sale.getCustomer().getEmail())) ||
                                            (i.getUsername() != null && i.getUsername().equalsIgnoreCase(sale.getCustomer().getUsername()))))
                            .toList();
                }
                for (com.landsales.crm.entity.Inquiry inq : inqs) {
                    inq.setSaleId(sale.getId());
                    inq.setStatus("COMPLETED");
                    inquiryRepository.save(inq);
                }
            }
        } else if ("DEED_DRAFTED".equalsIgnoreCase(legalStatus) || "READY_TO_SIGN".equalsIgnoreCase(legalStatus) || "TITLE_CLEARED".equalsIgnoreCase(legalStatus)) {
            sale.setStatus("RESERVED");
        }

        saleRepository.save(sale);

        if (auditLogService != null) {
            String officer = (verifiedBy != null && !verifiedBy.trim().isEmpty()) ? verifiedBy : auditLogService.getCurrentUsername();
            if ("OWNERSHIP_TRANSFERRED".equalsIgnoreCase(legalStatus)) {
                auditLogService.log("TRANSFER_DEED", "LEGAL",
                        "Deed transferred & title registered by Legal Officer '" + officer + "' for Case #" + saleId +
                                (sale.getProperty() != null ? " (" + sale.getProperty().getTitle() + ")" : "") +
                                (deedNumber != null ? ", Deed No: " + deedNumber : "") +
                                (notaryName != null ? ", Notary: " + notaryName : ""));
            } else {
                auditLogService.log("UPDATE_LEGAL_STATUS", "LEGAL",
                        "Conveyancing case #" + saleId + " updated to status '" + legalStatus + "' by Legal Officer '" + officer + "'" +
                                (sale.getProperty() != null ? " for '" + sale.getProperty().getTitle() + "'" : ""));
            }
        }

        if (notificationService != null) {
            String customerUname = (sale.getCustomer() != null) ? sale.getCustomer().getUsername() : null;
            String customerEmail = (sale.getCustomer() != null) ? sale.getCustomer().getEmail() : null;
            String propTitle = (sale.getProperty() != null) ? sale.getProperty().getTitle() : "Plot #" + saleId;

            if ("OWNERSHIP_TRANSFERRED".equalsIgnoreCase(legalStatus)) {
                notificationService.notifyUser(customerUname, customerEmail,
                        "🎉 Ownership Transferred & Deed Executed: " + propTitle,
                        "Congratulations! Your deed (Deed No: " + deedNumber + ", Notary: " + notaryName + ") has been officially registered and ownership transferred to you. Welcome to land ownership with Ceylon Lands!",
                        "/customer/portal?tab=reservations", "LEGAL_DEED");
                notificationService.notifyRole("PROPERTY",
                        "Plot Ownership Transferred: " + propTitle,
                        "Legal conveyancing finalized and title transferred. Plot is officially marked as SOLD in the inventory.",
                        "/property", "LEGAL_DEED");
            } else {
                notificationService.notifyUser(customerUname, customerEmail,
                        "Legal Conveyancing Update: " + legalStatus,
                        "Your reservation for '" + propTitle + "' conveyancing status was updated to: " + legalStatus + (legalNotes != null ? " (" + legalNotes + ")" : ""),
                        "/customer/portal?tab=reservations", "LEGAL_DEED");
            }
        }
    }

    @Transactional
    public void updateLegalCaseStatus(Long saleId, String legalStatus, String deedNumber, String notaryName, String legalNotes, String verifiedBy) {
        updateLegalCaseStatus(saleId, legalStatus, deedNumber, notaryName, legalNotes, null, verifiedBy);
    }

    @Transactional
    public void rejectBuyerDocumentation(Long saleId, String rejectionMessage, String verifier) {
        Sale sale = getCaseById(saleId);
        sale.setLegalStatus("DOCS_REJECTED");
        String note = (rejectionMessage != null && !rejectionMessage.trim().isEmpty())
                ? rejectionMessage.trim()
                : "Documents require correction. Please re-submit clear NIC and address proof.";
        sale.setLegalNotes(note);
        saleRepository.save(sale);

        if (auditLogService != null) {
            String officer = (verifier != null && !verifier.trim().isEmpty()) ? verifier : auditLogService.getCurrentUsername();
            auditLogService.log("REJECT_LEGAL_DOCS", "LEGAL",
                    "Buyer conveyancing documents rejected by Legal Officer '" + officer + "' for Case #" + saleId + ": " + note);
        }

        if (notificationService != null && sale.getCustomer() != null) {
            notificationService.notifyUser(sale.getCustomer().getUsername(), sale.getCustomer().getEmail(),
                    "Action Required: Legal Document Issue on Case #" + saleId,
                    "The Legal Department noted an issue with your conveyancing documents: " + note + ". Please re-upload clear documents via your portal.",
                    "/customer/portal?tab=reservations", "LEGAL_DEED");
        }
    }

    @Transactional
    public LegalDocument addLegalDocument(Long saleId, String documentType, String documentName, String documentUrl, String remarks) {
        Sale sale = getCaseById(saleId);
        LegalDocument doc = new LegalDocument(sale, sale.getProperty(), documentType, documentName, documentUrl, remarks);
        return legalDocumentRepository.save(doc);
    }

    @Transactional
    public void verifyDocument(Long docId, String verifiedBy, boolean approved, String remarks) {
        LegalDocument doc = legalDocumentRepository.findById(docId)
                .orElseThrow(() -> new IllegalArgumentException("Document not found with ID: " + docId));
        doc.setStatus(approved ? "VERIFIED" : "REJECTED");
        doc.setVerifiedBy(verifiedBy);
        if (remarks != null && !remarks.trim().isEmpty()) {
            doc.setRemarks(remarks.trim());
        }
        legalDocumentRepository.save(doc);

        if (auditLogService != null) {
            String officer = (verifiedBy != null && !verifiedBy.trim().isEmpty()) ? verifiedBy : auditLogService.getCurrentUsername();
            auditLogService.log(approved ? "VERIFY_DOCUMENT" : "REJECT_DOCUMENT", "LEGAL",
                    (approved ? "Verified" : "Rejected") + " legal document '" + doc.getDocumentName() + "' (ID: #" + docId + ") by Legal Officer '" + officer + "'");
        }
    }
}
