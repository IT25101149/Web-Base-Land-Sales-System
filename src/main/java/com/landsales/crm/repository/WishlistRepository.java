package com.landsales.crm.repository;

import com.landsales.crm.entity.WishlistItem;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface WishlistRepository extends JpaRepository<WishlistItem, Long> {
    List<WishlistItem> findByUsernameOrderByAddedAtDesc(String username);
    Optional<WishlistItem> findByUsernameAndPropertyId(String username, Long propertyId);
    boolean existsByUsernameAndPropertyId(String username, Long propertyId);
    List<WishlistItem> findByPropertyId(Long propertyId);
    void deleteByUsernameAndPropertyId(String username, Long propertyId);
    long countByUsername(String username);
}