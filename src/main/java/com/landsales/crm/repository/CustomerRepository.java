package com.landsales.crm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.landsales.crm.entity.Customer;
import java.util.List;
import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Long> {
    List<Customer> findAllByUsername(String username);
    List<Customer> findAllByEmail(String email);

    default Optional<Customer> findByUsername(String username) {
        if (username == null || username.trim().isEmpty()) return Optional.empty();
        return findAllByUsername(username).stream().findFirst();
    }

    default Optional<Customer> findByEmail(String email) {
        if (email == null || email.trim().isEmpty()) return Optional.empty();
        return findAllByEmail(email).stream().findFirst();
    }
}

