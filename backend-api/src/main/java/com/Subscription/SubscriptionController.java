package com.Subscription;

import org.springframework.web.bind.annotation.*;

import com.Customer.Customer;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import com.Customer.CustomerRepository;
import com.Topic.Topic;
import com.Topic.TopicRepository;

@RestController
@RequiredArgsConstructor
public class SubscriptionController {
    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TopicRepository topicRepository;

    @PostMapping("/subscriptions")
    public String subscribe(@RequestParam Long topicId, @RequestParam Long customerId) {

        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Topic topic = topicRepository.findById(topicId)
                .orElseThrow(() -> new RuntimeException("Topic not found"));

        boolean alreadySubscribed = subscriptionRepository.existsByCustomerAndTopic(customer, topic);
        if (!alreadySubscribed) {
            Subscription subscription = new Subscription();
            subscription.setCustomer(customer);
            subscription.setTopic(topic);
            subscription.setStartDate(java.time.LocalDateTime.now());
            subscription.setActive(true);
            subscriptionRepository.save(subscription);
        }

        return "redirect:/topics";
    }

}
