import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ;

@RestController
@RequestMapping("")
public class NewsletterController {

    @PostMapping("/subscribe")
    public ResponseEntity<String> subscribeToNewsletter(@RequestBody String email) {
        // Add newsletter subscription logic here
        return ResponseEntity.ok("Successfully subscribed to newsletter");
    }

    @DeleteMapping("/unsubscribe")
    public ResponseEntity<String> unsubscribeFromNewsletter(@RequestParam String email) {
        // Add newsletter unsubscribe logic here
        return ResponseEntity.ok("Successfully unsubscribed from newsletter");
    }

    @GetMapping("/status")
    public ResponseEntity<String> getSubscriptionStatus(@RequestParam String email) {
        // Add logic to check subscription status
        return ResponseEntity.ok("Subscription status for: " + email);
    }
}