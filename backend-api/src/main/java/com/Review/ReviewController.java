package com.Review;

import com.Customer.CustomerService;
import com.Writer.WriterService;
import com.Topic.Topic;
import com.Topic.TopicService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;
    private final TopicService TopicService;
    private  final CustomerService customerService;
    private final WriterService WriterService;

    @PostMapping
    public ResponseEntity<Review> createReview(@Valid @RequestBody Review review) {
        return ResponseEntity.ok(reviewService.createReview(review));
    }

    @PostMapping("/{id}/writer-response")
    public ResponseEntity<Review> addWriterResponse(@PathVariable Long id, @RequestBody String response) {
        return ResponseEntity.ok(reviewService.addWriterResponse(id, response));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        reviewService.deleteReview(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/box/{boxId}")
    public ResponseEntity<List<Review>> getBoxReviews(@PathVariable Long topicId) {
        return ResponseEntity.ok(reviewService.getReviewsByTopic(TopicService.getTopicByID(topicId)));
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<List<Review>> getCustomerReviews(@PathVariable Long customerId) {
        return ResponseEntity.ok(reviewService.getReviewsByCustomer(CustomerService.getCustomerById(customerId)));
    }

    @GetMapping("/writer/{writerId}")
    public ResponseEntity<List<Review>> getWriterReviews(@PathVariable Long WriterId) {
        return ResponseEntity.ok(reviewService.getReviewsByWriter(WriterService.getWriterByID(WriterId)));
    }

    @GetMapping("/topic/{topicId}/ratings")
    public ResponseEntity<Map<String, Double>> getTopicRatings(@PathVariable Long topicId) {
        Topic topic = TopicService.getTopicById(topicId);
        Map<String, Double> ratings = new HashMap<>();
        ratings.put("overall", reviewService.getAverageOverallRating(topic));
        return ResponseEntity.ok(ratings);
    }
}