package com.landsales.survey.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.landsales.survey.entity.Survey;
import java.util.List;

public interface SurveyRepository extends JpaRepository<Survey, Long> {
    List<Survey> findAllByOrderBySurveyDateDesc();
    List<Survey> findByPropertyId(Long propertyId);
    long countByStatus(String status);
}

