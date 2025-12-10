package com.Review;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.OptionalDouble;

@Service
public class ReviewService {
    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    public double calculateAverageRatingForTopic(Long topicId) {
        List<Review> reviews = reviewRepository.findByTopicId(topicId);
        OptionalDouble average = reviews.stream()
                .mapToInt(Review::getRating)
                .average();
        return average.orElse(0.0);
    }
}
