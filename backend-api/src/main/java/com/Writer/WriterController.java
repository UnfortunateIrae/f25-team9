package com.Writer;

import com.Source.Source;
import com.Article.ArticleRepository;
import com.Topic.TopicRepository;
import com.Source.SourceRepository;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.transaction.annotation.Transactional;
import jakarta.validation.Valid;

import java.util.*;

@Controller
public class WriterController {

    private final WriterRepository writerRepository;
    private final WriterService writerService;
    private final SourceRepository sourceRepository;

    public WriterController(
            WriterRepository writerRepository,
            TopicRepository topicRepository,
            ArticleRepository articleRepository,
            SourceRepository sourceRepository,
            WriterService writerService
    ) 
    {
        this.writerRepository = writerRepository;
        this.sourceRepository = sourceRepository;
        this.writerService = writerService;
    }

    @GetMapping("/writers")
    public String writersList(Model model) {

        List<Writer> writers = writerRepository.findAllWithSource();

        writers.forEach(w -> w.getSourceName());

        writers.sort((w1, w2) -> w1.getName().compareToIgnoreCase(w2.getName()));

        model.addAttribute("writers", writers);
        return "high-fidelity-prototype/writers-list";
    }


    @GetMapping("/writers/{id}")
    public String viewWriter(@PathVariable Long id, Model model) {
        Writer writer = writerService.getWriterById(id);
        model.addAttribute("writer", writer);
        return "high-fidelity-prototype/writer-detail";
    }

    @PostMapping("/writers")
    @Transactional
    public String createWriter(@Valid @ModelAttribute Writer writer) {
        Source source = writer.getSource();

        if (source == null || source.getId() == null) {
            source = sourceRepository.findByName("Default Source")
                    .orElseGet(() -> {
                        Source s = new Source();
                        s.setName("Default Source");
                        s.setUrl("http://default-source.local");
                        return sourceRepository.save(s);
                    });
        } else {
            source = sourceRepository.findById(source.getId())
                    .orElseThrow(() -> new RuntimeException("Source not found"));
        }

        writer.setSource(source);
        writerRepository.save(writer);

        return "redirect:/writers";
    }

    @PostMapping("/writers/{id}/update")
    public String updateWriter(@PathVariable Long id, @Valid @ModelAttribute Writer details) {
        writerService.updateWriter(id, details);
        return "redirect:/writers";
    }

    @PostMapping("/writers/{id}/delete")
    public String deleteWriter(@PathVariable Long id) {
        writerService.deleteWriter(id);
        return "redirect:/writers";
    }
}
