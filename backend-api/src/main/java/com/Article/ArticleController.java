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
import org.springframework.ui.Model;

@RequiredArgsConstructor
@RestController
public class ArticleController {

    private final ArticleRepository articleRepository;
    private final WriterRepository writerRepository;

    @GetMapping("/articles")
    public String getAll(Model model) {
        List<Article> articles = articleRepository.findAll();
        model.addAttribute("articles", articles);
        return "high-fidelity-prototype/articles-list";
    }

    @GetMapping("/articles/{id}")
    public String getById(@PathVariable Long id, Model model) {
        return "high-fidelity-prototype/article-view";
    }

    @GetMapping("articles/create")
    public String createArticlePage(@RequestParam Long topicId, Model model) {
        return "high-fidelity-prototype/create-article";
    }

    @PostMapping("/articles")
    public Article create(@Valid @RequestBody Map<String, Object> request) {

        String title = (String) request.get("title");
        String content = (String) request.get("content");
        Number writerId = (Number) request.get("writerId");

        if (title == null || content == null || writerId == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }

        Writer writer = writerRepository.findById(writerId.longValue())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Article article = new Article(title, content, writer);
        return articleRepository.save(article);
    }

    @PutMapping("/articles/{id}")
    public Article update(@PathVariable Long id, @Valid @RequestBody Map<String, Object> request) {

        Article article = articleRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        if (request.containsKey("title")) {
            article.setTitle((String) request.get("title"));
        }

        if (request.containsKey("content")) {
            article.setContent((String) request.get("content"));
        }

        if (request.containsKey("writerId")) {
            Number writerId = (Number) request.get("writerId");
            Writer writer = writerRepository.findById(writerId.longValue())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
            article.setWriter(writer);
        }

        return articleRepository.save(article);
    }

    @DeleteMapping("/articles/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!articleRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }

        articleRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
