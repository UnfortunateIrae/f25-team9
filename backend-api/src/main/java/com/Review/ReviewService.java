package com.Review;

import com.Customer.Customer;
import com.Writer.Writer;
import com.Topic.Topic;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.OptionalDouble;

@Service
@RequiredArgsConstructor
@Transactional
public class ReviewService {
    private final ReviewRepository reviewRepository;

    public double getAverageOverallRating(Topic topic) {
        List<Review> reviews = reviewRepository.findByTopic(topic);
        OptionalDouble average = reviews.stream()
                .mapToDouble(review -> review.getOverallRating() != null ? review.getOverallRating() : 0.0)
                .average();
        return average.orElse(0.0);
    }

    public double setOverallRating(Review review) {
        return review.getOverallRating();
    }

    public Review createReview(Review review) {
        review.setOverallRating(review.getOverallRating());
        review.setCreatedAt(LocalDateTime.now());
        return reviewRepository.save(review);
    }

    public Review addFarmerResponse(Long id, String response) {
        Review review = reviewRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Review not found"));

        review.setWriterResponse(response);
        review.setWriterResponseDate(LocalDateTime.now());
        return reviewRepository.save(review);
    }

    public void deleteReview(Long id) {
        if (!reviewRepository.existsById(id)) {
            throw new EntityNotFoundException("Review not found");
        }
        reviewRepository.deleteById(id);
    }

    public List<Review> getReviewsByTopic(Topic topic) {
        return reviewRepository.findByTopic(topic);
    }

    public List<Review> getReviewsByCustomer(Customer customer) {
        return reviewRepository.findByCustomer(customer);
    }

    public List<Review> getReviewsByFarmer(Writer writer) {
        return reviewRepository.findByTopicWriter(writer);
    }
}