package com.landsales.crm.repository;

import com.landsales.crm.entity.SupportRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SupportRequestRepository extends JpaRepository<SupportRequest, Long> {
    List<SupportRequest> findByUsernameOrderByCreatedAtDesc(String username);
    long countByUsername(String username);
    long countByStatus(String status);
}
