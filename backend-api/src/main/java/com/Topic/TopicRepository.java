package com.Topic;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TopicRepository extends JpaRepository<Topic, Long> {
    @Query("SELECT t FROM Customer c JOIN c.subscriptions t WHERE c.id = :customerId")
    List<Topic> findActiveSubscriptions(@Param("customerId") Long customerId);
}
