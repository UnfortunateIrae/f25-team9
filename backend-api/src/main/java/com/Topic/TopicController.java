package com.Topic;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.validation.Valid;
import java.util.List;
import com.Writer.Writer;
import com.Writer.WriterRepository;

@Controller
public class TopicController {

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private WriterRepository writerRepository;

    @GetMapping("/topics")
    public String listTopics(Model model) {
        List<Topic> topics = topicRepository.findAll();
        model.addAttribute("topics", topics);
        return "high-fidelity-prototype/topics-list";
    }

    @GetMapping("/topics/create")
    public String createTopicPage(Model model) {
        model.addAttribute("topic", new Topic());
        return "high-fidelity-prototype/create-topic";
    }

    @PostMapping("/topics")
    public String createTopic(@Valid @ModelAttribute Topic topic) {
        Topic savedTopic = topicRepository.save(topic);
        savedTopic.setUrl("/topics/" + savedTopic.getId());
        topicRepository.save(savedTopic);
        return "redirect:/topics";
    }

    @GetMapping("/topics/edit/{id}")
    public String editTopicPage(@PathVariable Long id, Model model) {
        Topic topic = topicRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
        List<Writer> allWriters = writerRepository.findAll();

        model.addAttribute("topic", topic);
        model.addAttribute("allWriters", allWriters);
        return "high-fidelity-prototype/edit-topic";
    }

    @PostMapping("/topics/update/{id}")
    public String updateTopic(@PathVariable Long id,
            @RequestParam(value = "writerIds", required = false) List<Long> writerIds) {
        Topic topic = topicRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));

        topic.getWriters().clear();
        if (writerIds != null) {
            List<Writer> selectedWriters = writerRepository.findAllById(writerIds);
            topic.getWriters().addAll(selectedWriters);
        }

        topicRepository.save(topic);
        return "redirect:/topics/edit/" + id;
    }

    @PostMapping("/topics/{id}/delete")
    public String deleteTopic(@PathVariable Long id) {
        topicRepository.deleteById(id);
        return "redirect:/topics";
    }

    @GetMapping("/topics/{id}")
    public String viewTopic(@PathVariable Long id, Model model) {
        Topic topic = topicRepository.findByIdWithArticles(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
        model.addAttribute("topic", topic);
        return "high-fidelity-prototype/topic-page";
    }
}
