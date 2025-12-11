package com.Review;

import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import com.Topic.Topic;
import com.Topic.TopicRepository;
import com.Customer.Customer;
import com.Customer.CustomerRepository;
import java.util.List;

@Controller
public class ReviewController {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @PostMapping("/reviews/create")
    public String addReview(@RequestParam("topicId") Long topicId,
            @RequestParam("rating") Integer rating,
            @RequestParam("comment") String comment,
            @RequestParam(value = "customerId", required = false) Long customerId,
            Model model) {

        Topic topic = topicRepository.findById(topicId).orElse(null);
        if (topic == null) {
            model.addAttribute("error", "Topic not found");
            return "error";
        }

        Review review = new Review();
        review.setComment(comment);
        review.setTopic(topic);

        if (rating == null) {
            rating = 0; // default if no rating provided
        }
        review.setRating(rating);

        if (customerId != null) {
            Customer customer = customerRepository.findById(customerId).orElse(null);
            if (customer == null) {
                model.addAttribute("error", "Customer not found");
                return "error";
            }
            review.setCustomer(customer);
        }

        reviewRepository.save(review);

        List<Review> reviews = reviewRepository.findByTopicId(topic.getId());
        double avgRating = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
        topic.setRating((float) avgRating);
        topicRepository.save(topic);

        return "redirect:/topics/" + topicId;
    }

    @PostMapping("/reviews/{id}/delete")
    public String deleteReview(@RequestParam("reviewId") Long reviewId, Model model) {
        Review review = reviewRepository.findById(reviewId).orElse(null);
        if (review == null) {
            model.addAttribute("error", "Review not found");
            return "error";
        }

        Topic topic = review.getTopic();
        reviewRepository.delete(review);

        List<Review> reviews = reviewRepository.findByTopicId(topic.getId());
        double avgRating = reviews.stream()
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);
        topic.setRating((float) avgRating);
        topicRepository.save(topic);

        return "redirect:/topics/" + topic.getId();
    }

}
