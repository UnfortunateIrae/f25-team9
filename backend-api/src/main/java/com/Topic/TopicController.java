package com.Topic;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

@Controller
public class TopicController {

    @Autowired
    private TopicRepository topicRepository;

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
        topicRepository.save(topic);
        return "redirect:/topics";
    }

    @GetMapping("/topics/{id}/edit")
    public String editTopicPage(@PathVariable Long id, Model model) {
        Optional<Topic> optionalTopic = topicRepository.findById(id);
        if (optionalTopic.isEmpty()) {
            return "redirect:/topics";
        }
        model.addAttribute("topic", optionalTopic.get());
        return "high-fidelity-prototype/edit-topic";
    }

    @PostMapping("/topics/{id}/update")
    public String updateTopic(@PathVariable Long id, @Valid @ModelAttribute Topic details) {
        Optional<Topic> optionalTopic = topicRepository.findById(id);
        if (optionalTopic.isEmpty()) {
            return "redirect:/topics";
        }
        Topic topic = optionalTopic.get();
        topic.setName(details.getName());
        topic.setUrl(details.getUrl());
        topicRepository.save(topic);
        return "redirect:/topics";
    }

    @PostMapping("/topics/{id}/delete")
    public String deleteTopic(@PathVariable Long id) {
        topicRepository.deleteById(id);
        return "redirect:/topics";
    }
}
