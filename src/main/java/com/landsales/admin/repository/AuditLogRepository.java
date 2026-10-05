package com.landsales.admin.repository;

import com.landsales.admin.entity.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
    List<AuditLog> findAllByOrderByTimestampDesc();
    List<AuditLog> findTop15ByOrderByTimestampDesc();
    List<AuditLog> findByModuleOrderByTimestampDesc(String module);
    List<AuditLog> findByUsernameOrderByTimestampDesc(String username);
}
