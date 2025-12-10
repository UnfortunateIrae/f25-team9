package com.Customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.Topic.Topic;
import com.Topic.TopicRepository;

import java.util.HashMap;
import java.util.List;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.context.SecurityContextHolder;

import com.Subscription.SubscriptionRepository;
import java.util.Map;

import org.springframework.security.core.Authentication;

@Controller
public class CustomerController {

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TopicRepository topicRepository;

    @GetMapping("/")
    public String homePage(Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Long customerId = customer.getId();

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(customerId);

        List<Topic> topTopics = topicRepository.findTopicsByMostSubscribers(PageRequest.of(0, 10));

        Map<String, Integer> subscriberCounts = new HashMap<>();
        for (Topic topic : topTopics) {
            int count = subscriptionRepository.findByTopic(topic).size();
            subscriberCounts.put(String.valueOf(topic.getId()), count);
        }
        model.addAttribute("subscriberCounts", subscriberCounts);

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

    @GetMapping("/profiles")
    public String profilesList(Model model) {
        List<Customer> customers = customerRepository.findAll();
        model.addAttribute("customers", customers);
        return "high-fidelity-prototype/profiles-list";
    }
}
