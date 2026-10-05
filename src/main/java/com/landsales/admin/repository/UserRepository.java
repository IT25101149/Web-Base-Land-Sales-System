package com.landsales.admin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.landsales.admin.entity.User;
import java.util.Optional;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    List<User> findAllByUsername(String username);
}
