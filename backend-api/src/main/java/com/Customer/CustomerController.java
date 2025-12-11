package com.Customer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.Article.Article;
import com.Article.ArticleRepository;
import com.Subscription.SubscriptionRepository;
import com.Topic.Topic;
import com.Topic.TopicRepository;
import com.Writer.Writer;
import com.Writer.WriterRepository;

@Controller
public class CustomerController {

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private WriterRepository writerRepository;

    @Autowired
    private ArticleRepository articleRepository;

    @GetMapping("/")
    public String homePage(Model model) {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        // Check if user is a writer first
        var writerOpt = writerRepository.findByEmail(email);
        if (writerOpt.isPresent()) {
            Writer writer = writerOpt.get();
            model.addAttribute("writer", writer);
            
            // Get writer's articles
            List<Article> writerArticles = articleRepository.findByWriterId(writer.getId());
            model.addAttribute("writerArticles", writerArticles);
            
            // Get writer's topics
            model.addAttribute("writerTopics", writer.getTopics());
            
            return "high-fidelity-prototype/homePage";
        }

        // Otherwise, handle as customer
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Long customerId = customer.getId();
        model.addAttribute("customerId", customerId);

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
    public String profilePage(Model model, @PathVariable Long id, @AuthenticationPrincipal com.Security.CustomUserDetails customUserDetails) {

        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(id);

        model.addAttribute("customer", customer);
        model.addAttribute("activeSubscriptions", activeSubscriptions);
        Long customerId = customUserDetails.getId();
        model.addAttribute("customerId", customerId);

        return "high-fidelity-prototype/profile";
    }

    @GetMapping("/profiles")
    public String profilesList(Model model) {
        List<Customer> customers = customerRepository.findAll();
        model.addAttribute("customers", customers);
        return "high-fidelity-prototype/profiles-list";
    }
        
    @GetMapping("/customer/edit/{id}")
    public String editCustomerPage(Model model, @PathVariable Long id) {

        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        model.addAttribute("customer", customer);

        return "high-fidelity-prototype/editCustomer";
    }

    @PostMapping("/customer/update/{id}")
    public String updateCustomer(Customer updatedCustomer, @PathVariable Long id) {

        Customer existingCustomer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        existingCustomer.setName(updatedCustomer.getName());
        existingCustomer.setEmail(updatedCustomer.getEmail());
        existingCustomer.setPhoneNumber(updatedCustomer.getPhoneNumber());
        customerRepository.save(existingCustomer);

        return "redirect:/profile/" + id;
    }

    @GetMapping("/customer/subscriptions/{id}")
    public String customerSubscriptionsPage(Model model, @PathVariable Long id) {

        Customer customer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        List<Topic> activeSubscriptions = topicRepository.findActiveSubscriptions(id);

        model.addAttribute("customer", customer);
        model.addAttribute("activeSubscriptions", activeSubscriptions);

        return "high-fidelity-prototype/customerSubscriptions";
    }
}
