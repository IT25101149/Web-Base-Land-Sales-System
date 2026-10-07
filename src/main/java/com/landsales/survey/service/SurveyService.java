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
