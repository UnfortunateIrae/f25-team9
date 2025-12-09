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
import com.Subscription.SubscriptionRepository;
import java.util.Map;

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

        Long demoCustomerId = 1L;

        Customer customer = customerRepository.findById(demoCustomerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(demoCustomerId);

        List<Topic> topTopics = topicRepository.findTopicsByMostSubscribers(PageRequest.of(0, 10));

        Map<Long, Integer> subscriberCounts = new HashMap<>();
        for (Topic topic : topTopics) {
            int count = subscriptionRepository.findByTopic(topic).size();
            subscriberCounts.put(topic.getId(), count);
        }

        model.addAttribute("customer", customer);
        model.addAttribute("activeSubscriptions", activeSubscriptions);
        model.addAttribute("topTopics", topTopics);
        model.addAttribute("subscriberCounts", subscriberCounts);

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
