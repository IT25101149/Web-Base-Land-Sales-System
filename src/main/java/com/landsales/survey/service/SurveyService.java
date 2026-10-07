package com.landsales.survey.service;

import com.landsales.survey.entity.Survey;
import com.landsales.survey.repository.SurveyRepository;
import com.landsales.property.entity.Property;
import com.landsales.property.repository.PropertyRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class SurveyService {

    @Autowired
    private SurveyRepository surveyRepository;

    @Autowired
    private PropertyRepository propertyRepository;

    @Autowired(required = false)
    private com.landsales.notification.service.NotificationService notificationService;

    @PostConstruct
    public void initData() {
        if (surveyRepository.count() == 0) {
            List<Property> properties = propertyRepository.findAll();
            if (!properties.isEmpty()) {
                Property p1 = properties.get(0);
                surveyRepository.save(new Survey(
                        null, p1, "SRV-2026-001", "Eng. Dayan Fernando (Licensed Surveyor)", LocalDate.now().minusDays(18),
                        "PP/WP/COL/4821", "Lot 10A", p1.getSize() + " Perches",
                        "Lot 09 & Private Access Way", "Main 30ft Carpeted Urban Road",
                        "Lot 10B & Boundary Wall", "Elegance Green Reservation",
                        p1.getPrice(), p1.getPrice() * 0.95,
                        "Flat elevated terrain, solid red gravel bedrock, zero flood risk",
                        "30 ft Carpeted Road Frontage",
                        "3-Phase CEB Electricity, NWSDB Pipe Water, Stormwater Culvert Approved",
                        "APPROVED",
                        "https://images.unsplash.com/photo-1524813686514-a57563d77d66?w=1000&auto=format&fit=crop&q=80",
                        "Boundary stones fixed and certified. Title deed boundary measurements authenticated by Land Registry."
                ));

                if (properties.size() > 1) {
                    Property p2 = properties.get(1);
                    surveyRepository.save(new Survey(
                            null, p2, "SRV-2026-002", "Eng. Sarath Wickramasinghe (Govt Valuer)", LocalDate.now().minusDays(12),
                            "PP/WP/GAM/3104", "Lot 04", p2.getSize() + " Perches",
                            "Lot 03 & Coconut Plantation", "20ft Development Road",
                            "Drainage Canal Reservation", "Lot 05 Private Land",
                            p2.getPrice(), p2.getPrice() * 0.92,
                            "Gently sloping fertile high ground, natural gravel foundation",
                            "20 ft Carpeted Tar Road",
                            "Electricity and tap water connected at plot edge",
                            "COMPLETED",
                            "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=1000&auto=format&fit=crop&q=80",
                            "Valuation completed based on recent Kadana expressway zone transactions. Excellent investment outlook."
                    ));
                }

                if (properties.size() > 2) {
                    Property p3 = properties.get(2);
                    surveyRepository.save(new Survey(
                            null, p3, "SRV-2026-003", "Eng. K. L. Jayawardena", LocalDate.now().minusDays(5),
                            "PP/WP/COL/5529", "Lot 14", p3.getSize() + " Perches",
                            "Lot 13 Residential Plot", "30ft Wide Council Roadway",
                            "Lot 15 & Concrete Wall", "Main Aththidiya Access Corridor",
                            p3.getPrice(), p3.getPrice() * 0.96,
                            "Prime urban flat land, 100% buildable, certified stable compaction",
                            "30 ft Paved Road Frontage",
                            "Full municipal utilities ready, fiber-optic cable duct, CEB Transformer 50m",
                            "APPROVED",
                            "https://images.unsplash.com/photo-1500076656116-558758c991c1?w=1000&auto=format&fit=crop&q=80",
                            "All 4 corner boundary beacons verified with GPS coordinates. Clear title plan ready for Deed of Transfer."
                    ));
                }
            }
        }
    }
    public List<Survey> getAllSurveys() {
        return surveyRepository.findAllByOrderBySurveyDateDesc();
    }

    public Survey getSurveyById(Long id) {
        return surveyRepository.findById(id).orElse(null);
    }

    public List<Survey> getSurveysByPropertyId(Long propertyId) {
        return surveyRepository.findByPropertyId(propertyId);
    }

    @Transactional
    public Survey createPendingSurveyForProperty(Property property) {
        // Check if an existing survey already exists for this property
        List<Survey> existing = surveyRepository.findByPropertyId(property.getId());
        if (!existing.isEmpty()) {
            return existing.get(0);
        }

        Survey survey = new Survey();
        survey.setProperty(property);
        survey.setSurveyNumber("SRV-" + LocalDate.now().getYear() + "-" + String.format("%04d", property.getId()));
        survey.setSurveyorName("Pending Assignment");
        survey.setSurveyDate(LocalDate.now());
        survey.setStatus("PENDING_INSPECTION");
        survey.setLandExtent(property.getSize() != null ? (property.getSize() + " Perches (Estimated)") : "Pending Demarcation");
        survey.setValuationAmount(property.getPrice());
        survey.setGovernmentValuation(property.getPrice() != null ? (property.getPrice() * 0.90) : 0.0);
        survey.setRemarks("Auto-queued from Property Management. Awaiting field inspection, lot boundary beacons fixing, and official cadastral certification.");

        return surveyRepository.save(survey);
    }

    @Transactional
    public Survey approveAndCertifySurvey(Long surveyId, String planNumber, String lotNumber,
                                          Double certifiedExtent, Double valuationAmount,
                                          String surveyorName, String remarks) {
        Survey survey = surveyRepository.findById(surveyId).orElse(null);
        if (survey != null) {
            survey.setStatus("APPROVED");
            if (planNumber != null && !planNumber.trim().isEmpty()) survey.setPlanNumber(planNumber.trim());
            if (lotNumber != null && !lotNumber.trim().isEmpty()) survey.setLotNumber(lotNumber.trim());
            if (certifiedExtent != null && certifiedExtent > 0) survey.setLandExtent(certifiedExtent + " Perches");
            if (valuationAmount != null && valuationAmount > 0) survey.setValuationAmount(valuationAmount);
            if (surveyorName != null && !surveyorName.trim().isEmpty()) survey.setSurveyorName(surveyorName.trim());
            if (remarks != null && !remarks.trim().isEmpty()) survey.setRemarks(remarks.trim());

            // Auto-update linked property to AVAILABLE and certified
            Property property = survey.getProperty();
            if (property != null) {
                property.setStatus("AVAILABLE");
                if (certifiedExtent != null && certifiedExtent > 0) {
                    property.setSize(certifiedExtent);
                }
                if (valuationAmount != null && valuationAmount > 0) {
                    property.setPrice(valuationAmount);
                }
                propertyRepository.save(property);

                if (notificationService != null) {
                    notificationService.notifyRole("PROPERTY",
                            "Cadastral Survey Certified: " + property.getTitle(),
                            "Cadastral Plan #" + (planNumber != null ? planNumber : "N/A") + " (Lot " + (lotNumber != null ? lotNumber : "N/A") + ", " + (certifiedExtent != null ? certifiedExtent + " Perches" : "") + ") has been approved and certified. Plot status is now ACTIVE & AVAILABLE for public sale.",
                            "/property", "SURVEY");
                }
            }

            return surveyRepository.save(survey);
        }
        return null;
    }

    @Transactional
    public Survey saveSurvey(Survey survey) {
        if (survey.getStatus() == null || survey.getStatus().trim().isEmpty()) {
            survey.setStatus("APPROVED");
        }
        if (survey.getSurveyDate() == null) {
            survey.setSurveyDate(LocalDate.now());
        }

        // If approved, ensure property is AVAILABLE
        if ("APPROVED".equalsIgnoreCase(survey.getStatus()) || "COMPLETED".equalsIgnoreCase(survey.getStatus())) {
            if (survey.getProperty() != null) {
                Property p = survey.getProperty();
                if ("PENDING_SURVEY".equalsIgnoreCase(p.getStatus())) {
                    p.setStatus("AVAILABLE");
                    propertyRepository.save(p);
                }
            }
        }

        return surveyRepository.save(survey);
    }

    @Transactional
    public void deleteSurvey(Long id) {
        surveyRepository.deleteById(id);
    }
}
