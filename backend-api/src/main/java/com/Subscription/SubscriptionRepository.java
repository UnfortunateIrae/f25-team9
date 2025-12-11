package com.Subscription;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.Customer.Customer;
import com.Topic.Topic;
import com.Writer.Writer;
import java.time.LocalDateTime;

@Repository
public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {

    List<Subscription> findByCustomerAndActive(Customer customer, boolean active);

    List<Subscription> findByTopic(Topic topic);

    List<Subscription> findByWriter(Writer writer);

    List<Subscription> findByActiveTrueAndEndDateAfter(LocalDateTime now);

    @Query("""
        SELECT s FROM Subscription s
        WHERE s.active = true
          AND (s.endDate IS NULL OR s.endDate > :now)
    """)
    List<Subscription> findAllValidActive(@Param("now") LocalDateTime now);

    boolean existsByCustomerAndTopic(Customer customer, Topic topic);
}

