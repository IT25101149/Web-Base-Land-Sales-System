package com.landsales.crm.repository;

import com.landsales.crm.entity.PlatformFeedback;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PlatformFeedbackRepository extends JpaRepository<PlatformFeedback, Long> {
    List<PlatformFeedback> findByUsernameOrderByCreatedAtDesc(String username);
    long countByUsername(String username);
}
