package com.Topic;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
public class TopicController {
    @Autowired
    private TopicRepository topicRepository;

    @GetMapping("/topics")
    public String getAllTopics(Model model) {
        List<Topic> topics = topicRepository.findAll();
        model.addAttribute("topics", topics);
        return "high-fidelity-prototype/topics-list";
    }
}
