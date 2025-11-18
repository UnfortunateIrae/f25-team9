package com.Review;

// Explicit constructor used instead of Lombok to avoid annotation-processing issues during build
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @PostMapping("/writer/{writerId}")
    public ResponseEntity<Review> addReview(@PathVariable Long writerId, @Valid @RequestBody Review review) {
        return ResponseEntity.status(HttpStatus.CREATED).body(reviewService.addReviewToWriter(writerId, review));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Review> updateReview(@PathVariable Long id, @Valid @RequestBody Review details) {
        return ResponseEntity.ok(reviewService.updateReview(id, details));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable Long id) {
        reviewService.deleteReview(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Review> getReviewById(@PathVariable Long id) {
        return ResponseEntity.ok(reviewService.getReviewById(id));
    }

    @GetMapping
    public ResponseEntity<List<Review>> getAllReviews() {
        return ResponseEntity.ok(reviewService.getAllReviews());
    }

    @GetMapping("/writer/{writerId}")
    public ResponseEntity<List<Review>> getReviewsByWriter(@PathVariable Long writerId) {
        return ResponseEntity.ok(reviewService.getReviewsByWriterId(writerId));
    }

    @GetMapping("/writer/{writerId}/average")
    public ResponseEntity<Double> getAverageRating(@PathVariable Long writerId) {
        return ResponseEntity.ok(reviewService.getAverageRatingForWriter(writerId));
    }
}
