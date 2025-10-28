package com.Article;

import com.Writer.Writer;
import com.Writer.WriterRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ArticleService {

    private final ArticleRepository articleRepository;
    private final WriterRepository writerRepository;

    public Article addArticleToWriter(Long writerId, Article article) {
        Writer writer = writerRepository.findById(writerId)
                .orElseThrow(() -> new RuntimeException("Writer not found"));

        article.setWriter(writer);
        return articleRepository.save(article);
    }

    public Article getArticleById(Long id) {
        return articleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Article not found"));
    }

    public List<Article> getAllArticles() {
        return articleRepository.findAll();
    }

    public List<Article> getArticlesByWriterId(Long writerId) {
        return articleRepository.findByWriterId(writerId);
    }

    public Article updateArticle(Long id, Article details) {
        Article article = getArticleById(id);
        article.setTitle(details.getTitle());
        article.setContent(details.getContent());
        return articleRepository.save(article);
    }

    public void deleteArticle(Long id) {
        articleRepository.deleteById(id);
    }

    public Article saveArticle(Article article) {
        return articleRepository.save(article);
    }
}
