package com.Article;

import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.*;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.validation.Valid;
import com.Writer.Writer;
import com.Writer.WriterRepository;

@RestController
@RequestMapping("/api/article")
public class ArticleController {

    private final ArticleService articleService;
    private final WriterRepository writerRepository;

    public ArticleController(ArticleService articleService, WriterRepository writerRepository) {
        this.articleService = articleService;
        this.writerRepository = writerRepository;
    }

        @PostMapping(value = "/writer/{writerId}")
        public ResponseEntity<Article> addArticle(
                @PathVariable Long writerId,
                @Valid @RequestBody Article article) {

            Writer writer = writerRepository.findById(writerId)
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Writer not found"));

            article.setWriter(writer); // associate the article with the writer

            Article savedArticle = articleService.saveArticle(article);
            return ResponseEntity.status(HttpStatus.CREATED).body(savedArticle);
        }

    @PutMapping("/{id}")
    public ResponseEntity<Article> updateArticle(@PathVariable Long id, @Valid @RequestBody Article details) {
        Article updated = articleService.updateArticle(id, details);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteArticle(@PathVariable Long id) {
        articleService.deleteArticle(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    @Transactional(readOnly = true)
    public ResponseEntity<Article> getArticleById(@PathVariable Long id) {
        Article a = articleService.getArticleById(id);
        return ResponseEntity.ok(a);
    }

    @GetMapping
    @Transactional(readOnly = true)
    public ResponseEntity<List<Article>> getAllArticles() {
        List<Article> list = articleService.getAllArticles();
        return ResponseEntity.ok(list);
    }

    @GetMapping("/topic/{topicId}")
    @Transactional(readOnly = true)
    public ResponseEntity<List<Article>> getArticlesByTopic(@PathVariable Long topicId) {
        List<Article> list = articleService.getArticlesByTopicId(topicId);
        return ResponseEntity.ok(list);
    }

    @GetMapping("/writer/{writerId}")
    @Transactional(readOnly = true)
    public ResponseEntity<List<Article>> getArticlesByWriter(@PathVariable Long writerId) {
        List<Article> list = articleService.getArticlesByWriterId(writerId);
        return ResponseEntity.ok(list);
    }

    
}
