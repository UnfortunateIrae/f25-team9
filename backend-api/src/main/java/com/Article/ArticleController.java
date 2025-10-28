package com.Article;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/articles")
@RequiredArgsConstructor
public class ArticleController {

    private final ArticleService articleService;

    @PostMapping("/writer/{writerId}")
    public ResponseEntity<Article> addArticle(@PathVariable Long writerId, @Valid @RequestBody Article article) {
        return ResponseEntity.status(HttpStatus.CREATED).body(articleService.addArticleToWriter(writerId, article));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Article> updateArticle(@PathVariable Long id, @Valid @RequestBody Article details) {
        return ResponseEntity.ok(articleService.updateArticle(id, details));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteArticle(@PathVariable Long id) {
        articleService.deleteArticle(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Article> getArticleById(@PathVariable Long id) {
        return ResponseEntity.ok(articleService.getArticleById(id));
    }

    @GetMapping
    public ResponseEntity<List<Article>> getAllArticles() {
        return ResponseEntity.ok(articleService.getAllArticles());
    }

    @GetMapping("/writer/{writerId}")
    public ResponseEntity<List<Article>> getArticlesByWriter(@PathVariable Long writerId) {
        return ResponseEntity.ok(articleService.getArticlesByWriterId(writerId));
    }
}
