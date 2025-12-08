package com.Customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Topic.Topic;
import com.Topic.TopicRepository;

import java.util.List;
import org.springframework.data.domain.PageRequest;

@Controller
public class CustomerController {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TopicRepository topicRepository;

    @GetMapping("/")
    public String homePage(Model model) {

        // TEMP: Load a test customer for the homepage (replace with session later)
        Long demoCustomerId = 1L;

        Customer customer = customerRepository.findById(demoCustomerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(demoCustomerId);

        // Get Top 10 most-subscribed topics
        List<Topic> topTopics = topicRepository.findTopicsByMostSubscribers(PageRequest.of(0, 10));

        model.addAttribute("customer", customer);
        model.addAttribute("activeSubscriptions", activeSubscriptions);
        model.addAttribute("topTopics", topTopics);

        return "high-fidelity-prototype/homePage";
    }

    @GetMapping("/profile/{id}")
    public String profilePage(Model model, @PathVariable Long id) {

        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(id);

        model.addAttribute("customer", customer);
        model.addAttribute("activeSubscriptions", activeSubscriptions);

        return "high-fidelity-prototype/profile";
    }
}
