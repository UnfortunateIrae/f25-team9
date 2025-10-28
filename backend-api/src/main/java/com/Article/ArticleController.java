package com.Article;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;
import com.Writer.Writer;
import com.Writer.WriterRepository;

import java.util.Map;

@RestController
@RequestMapping("/api/articles")
@RequiredArgsConstructor
public class ArticleController {

    private final ArticleService articleService;
    private final WriterRepository writerRepository;

    @RestController
    @RequestMapping("/api/test")
    public class TestController {

    @PostMapping
    public ResponseEntity<String> testJson(@RequestBody Map<String, Object> body) {
        return ResponseEntity.ok("Received: " + body);
    }
}

    @PostMapping(value = "/writer/{writerId}")
    public ResponseEntity<Article> addArticle(
            @PathVariable Long writerId,
            @Valid @RequestBody Article article) {

        Writer writer = writerRepository.findById(writerId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Writer not found"));

        article.setWriter(writer); // associate the article with the writer

        Article savedArticle = articleService.saveArticle(article); // make sure your service saves it

        return ResponseEntity.status(HttpStatus.CREATED).body(savedArticle);
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
