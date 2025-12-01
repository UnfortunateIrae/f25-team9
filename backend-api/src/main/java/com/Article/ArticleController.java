package com.Article;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class ArticleController {

    @Autowired
    private ArticleRepository articleRepository;

    @GetMapping("/articles/create")
    public String showCreateArticleForm(@RequestParam Long topicId, Model model) {
        model.addAttribute("topicId", topicId);
        model.addAttribute("article", new Article());
        return "high-fidelity-prototype/create-article";
    }

    @PostMapping("/articles/create")
    public String createArticle(@RequestParam Long topicId,
                                @RequestParam String title,
                                @RequestParam String content) {

        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);

        articleRepository.save(article);

        return "redirect:/topics/" + topicId;
    }

    @GetMapping("/articles/{id}")
    public String viewArticle(@PathVariable Long id, Model model) {
        Article article = articleRepository.findById(id).orElseThrow();
        model.addAttribute("article", article);
        return "high-fidelity-prototype/article-view";
    }

    @GetMapping("/articles/{id}/edit")
    public String editArticlePage(@PathVariable Long id, Model model) {
        Article article = articleRepository.findById(id).orElseThrow();
        model.addAttribute("article", article);
        return "high-fidelity-prototype/article-edit";
    }

    @PostMapping("/articles/{id}/update")
    public String updateArticle(@PathVariable Long id,
                                @RequestParam String title,
                                @RequestParam String content) {

        Article article = articleRepository.findById(id).orElseThrow();
        article.setTitle(title);
        article.setContent(content);

        articleRepository.save(article);

        return "redirect:/articles/" + id;
    }

    @PostMapping("/articles/{id}/delete")
    public String deleteArticle(@PathVariable Long id) {
        articleRepository.deleteById(id);
        return "redirect:/articles";
    }

    @GetMapping("/articles")
    public String listArticles(Model model) {
        model.addAttribute("articles", articleRepository.findAll());
        return "high-fidelity-prototype/articles-list";
    }
}
