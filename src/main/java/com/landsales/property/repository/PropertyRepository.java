package com.landsales.property.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import com.landsales.property.entity.Property;
public interface PropertyRepository extends JpaRepository<Property, Long> {}

