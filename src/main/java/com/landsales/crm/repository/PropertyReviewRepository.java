package com.landsales.crm.repository;

import com.landsales.crm.entity.PropertyReview;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PropertyReviewRepository extends JpaRepository<PropertyReview, Long> {
    List<PropertyReview> findByPropertyIdOrderByCreatedAtDesc(Long propertyId);
    List<PropertyReview> findByUsernameOrderByCreatedAtDesc(String username);
    long countByUsername(String username);
    long countByPropertyId(Long propertyId);
}
