package com.landsales.crm.repository;

import com.landsales.crm.entity.Inquiry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface InquiryRepository extends JpaRepository<Inquiry, Long> {
    List<Inquiry> findByEmailOrderByInquiryDateDesc(String email);
    long countByEmail(String email);
    List<Inquiry> findBySaleId(Long saleId);
    List<Inquiry> findByPropertyId(Long propertyId);
}

