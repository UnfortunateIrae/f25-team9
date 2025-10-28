package com.Review;

import com.Customer.Customer;
import com.Writer.Writer;
import com.Topic.Topic;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByTopic(Topic topic);
    List<Review> findByCustomer(Customer customer);
    List<Review> findByTopicWriter(Writer writer);
}