package com.landsales.sales.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.landsales.sales.entity.Sale;
import com.landsales.crm.entity.Customer;
import java.util.List;

public interface SaleRepository extends JpaRepository<Sale, Long> {
    List<Sale> findByCustomerIdOrderBySaleDateDesc(Long customerId);
    List<Sale> findByCustomerOrderBySaleDateDesc(Customer customer);
    List<Sale> findByStatusOrderBySaleDateDesc(String status);
    List<Sale> findByPropertyId(Long propertyId);
    List<Sale> findAllByOrderBySaleDateDesc();
}
