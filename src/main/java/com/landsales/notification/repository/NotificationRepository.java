package com.landsales.notification.repository;

import com.landsales.notification.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    @Query("SELECT n FROM Notification n WHERE (n.recipientUsername = :username OR n.recipientRole = :role OR n.recipientRole = 'ALL') ORDER BY n.createdAt DESC")
    List<Notification> findForUserOrRole(@Param("username") String username, @Param("role") String role);

    @Query("SELECT COUNT(n) FROM Notification n WHERE (n.recipientUsername = :username OR n.recipientRole = :role OR n.recipientRole = 'ALL') AND n.isRead = false")
    long countUnreadForUserOrRole(@Param("username") String username, @Param("role") String role);

    List<Notification> findTop20ByRecipientUsernameOrRecipientRoleOrderByCreatedAtDesc(String username, String role);
}
