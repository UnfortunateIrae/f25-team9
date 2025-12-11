package com.Article;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    List<Article> findByWriterId(Long writerId);
    List<Article> findByTopicId(Long topicId);

    @Query("SELECT a FROM Article a WHERE a.topic.id = :topicId ORDER BY a.id DESC")
    Article findFirstByTopicIdOrderByCreatedAtDesc(Long topicId);
}
