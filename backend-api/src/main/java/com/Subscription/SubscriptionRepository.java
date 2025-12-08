package com.Subscription;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.Customer.Customer;
import com.Topic.Topic;
import com.Writer.Writer;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {
   List<Subscription> findByCustomerAndActive(Customer customer, boolean active);
   List<Subscription> findByTopic(Topic topic);
   List<Subscription> findByWriter(Writer writer);
}
