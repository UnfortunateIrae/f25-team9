package com.Review;

import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import com.Topic.Topic;
import com.Topic.TopicRepository;
import com.Customer.Customer;
import com.Customer.CustomerRepository;

@Controller
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @PostMapping("/review/add")
    public String addReview(@RequestParam("topicId") Long topicId,
            @RequestParam("rating") int rating,
            @RequestParam("comment") String comment,
            @RequestParam(value = "customerId", required = false) Long customerId,
            Model model) {

        Topic topic = topicRepository.findById(topicId).orElse(null);
        if (topic == null) {
            model.addAttribute("error", "Topic not found");
            return "error";
        }

        Review review = new Review();
        review.setRating(rating);
        review.setComment(comment);

        if (customerId != null) {
            Customer customer = customerRepository.findById(customerId).orElse(null);
            if (customer == null) {
                model.addAttribute("error", "Customer not found");
                return "error";
            }
            review.setCustomer(customer);
        }

        reviewRepository.save(review);

        return "redirect:/topics/" + topicId;
    }

}
