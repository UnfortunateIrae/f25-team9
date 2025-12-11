package com.Topic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Writer.Writer;
import com.Writer.WriterRepository;

import jakarta.validation.Valid;

@Controller
public class TopicController {

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private WriterRepository writerRepository;
    
    @GetMapping("/topics")
    public String listTopics(Model model, @AuthenticationPrincipal com.Security.CustomUserDetails customUserDetails) {
        List<Topic> topics = topicRepository.findAll();
        model.addAttribute("topics", topics);

        Long customerId = customUserDetails.getId();
        String accountType = customUserDetails.getAccountType();
        model.addAttribute("accountType", accountType);
        model.addAttribute("customerId", customerId);
        return "high-fidelity-prototype/topics-list";
    }

    @GetMapping("/topics/create")
    public String createTopicPage(Model model, @AuthenticationPrincipal com.Security.CustomUserDetails customUserDetails) {
        model.addAttribute("topic", new Topic());
        Long customerId = customUserDetails.getId();
        model.addAttribute("customerId", customerId);
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
    public String editTopicPage(@PathVariable Long id, Model model, @AuthenticationPrincipal com.Security.CustomUserDetails customUserDetails) {
        Topic topic = topicRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
        List<Writer> allWriters = writerRepository.findAll();
        Long customerId = customUserDetails.getId();
        model.addAttribute("customerId", customerId);
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
        return "redirect:/";
    }

    @PostMapping("/topics/{id}/delete")
    public String deleteTopic(@PathVariable Long id) {
        topicRepository.deleteById(id);
        return "redirect:/topics";
    }

    @GetMapping("/topics/{id}")
    public String viewTopic(@PathVariable Long id, Model model, @AuthenticationPrincipal com.Security.CustomUserDetails customUserDetails) {
        Topic topic = topicRepository.findByIdWithArticles(id)
                .orElseThrow(() -> new RuntimeException("Topic not found"));
        model.addAttribute("topic", topic);
        Long customerId = customUserDetails.getId();
        String accountType = customUserDetails.getAccountType();
        model.addAttribute("accountType", accountType);
        model.addAttribute("customerId", customerId);
        return "high-fidelity-prototype/topic-page";
    }
}
