package com.Topic;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Pageable;

@Repository
public interface TopicRepository extends JpaRepository<Topic, Long> {

    @Query("SELECT s.topic FROM Subscription s WHERE s.customer.id = :customerId AND s.active = true")
    List<Topic> findActiveSubscriptions(@Param("customerId") Long customerId);

    @Query("SELECT t FROM Topic t LEFT JOIN FETCH t.articles WHERE t.id = :id")
    Optional<Topic> findByIdWithArticles(@Param("id") Long id);

    @Query(value = """
                SELECT t
                FROM Topic t
                LEFT JOIN Subscription s ON s.topic = t
                GROUP BY t.id, t.name, t.url
                ORDER BY COUNT(s.id) DESC
            """, countQuery = """
                SELECT COUNT(DISTINCT t.id)
                FROM Topic t
                LEFT JOIN Subscription s ON s.topic = t
            """)
    List<Topic> findTopicsByMostSubscribers(Pageable pageable);

}
