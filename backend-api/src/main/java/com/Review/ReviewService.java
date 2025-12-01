package com.Review;

import com.Writer.Writer;
import com.Writer.WriterRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.OptionalDouble;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final WriterRepository writerRepository;

    public ReviewService(ReviewRepository reviewRepository, WriterRepository writerRepository) {
        this.reviewRepository = reviewRepository;
        this.writerRepository = writerRepository;
    }

    public Review addReviewToWriter(Long writerId, Review review) {
        Writer writer = writerRepository.findById(writerId).orElseThrow(() -> new RuntimeException("Writer not found"));
        review.setWriter(writer);
        return reviewRepository.save(review);
    }

    public Review updateReview(Long id, Review details) {
        Review review = reviewRepository.findById(id).orElseThrow(() -> new RuntimeException("Review not found"));
        review.setRating(details.getRating());
        review.setComment(details.getComment());
        return reviewRepository.save(review);
    }

    public void deleteReview(Long id) { reviewRepository.deleteById(id); }

    public Review getReviewById(Long id) { return reviewRepository.findById(id).orElseThrow(() -> new RuntimeException("Review not found")); }

    public List<Review> getAllReviews() { return reviewRepository.findAll(); }

    public List<Review> getReviewsByWriterId(Long writerId) { return reviewRepository.findByWriterId(writerId); }

    public double getAverageRatingForWriter(Long writerId) {
        List<Review> reviews = reviewRepository.findByWriterId(writerId);
        OptionalDouble avg = reviews.stream().mapToInt(Review::getRating).average();
        return avg.orElse(0.0);
    }
}
