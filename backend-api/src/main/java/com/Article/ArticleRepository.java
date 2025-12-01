package com.Article;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    List<Article> findByWriterId(Long writerId);
    List<Article> findByTopicId(Long topicId);
}
