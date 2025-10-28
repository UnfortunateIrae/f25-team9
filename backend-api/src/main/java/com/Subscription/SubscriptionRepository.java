package com.subscription;

import com.Customer.Customer;
import com.Writer.Writer;
import com.Article.Article;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
    List<Subscription> findByCustomerAndActive(Customer customer, boolean active);
    List<Subscription> findByProduceBox(ProduceBox produceBox);
    List<Subscription> findByProduceBoxFarmFarmer(Farmer farmer);
}