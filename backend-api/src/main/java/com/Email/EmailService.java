package com.Email;

import com.Customer.Customer;
import com.Subscription.SubscriptionRepository;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.resource.Emailv31;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.List;
import com.Subscription.Subscription;
import com.Topic.Topic;
import com.Writer.Writer;

@Service
public class EmailService {

    @Resource
    private MailjetClient client;

    @Value("${mailjet.sender}")
    private String sender;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    public void sendEmail(String to, String subject, String html) throws Exception {
        MailjetRequest request = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", sender)
                                        .put("Name", "Your App"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject().put("Email", to)))
                                .put(Emailv31.Message.SUBJECT, subject)
                                .put(Emailv31.Message.HTMLPART, html)
                        )
                );

        MailjetResponse response = client.post(request);

        if (response.getStatus() >= 400) {
            throw new RuntimeException("Mailjet error: " + response.getData());
        }
    }

    @Scheduled(cron = "0 0 8 * * SUN")
    public void sendWeeklyNewsletter() {

        List<Subscription> subscriptions =
                subscriptionRepository.findByActiveTrueAndEndDateAfter(null);

        if (subscriptions.isEmpty()) {
            System.out.println("No active subscriptions found.");
            return;
        }

        for (Subscription sub : subscriptions) {
            try {
                Customer customer = sub.getCustomer();
                Topic topic = sub.getTopic();
                Writer writer = sub.getWriter();

                String html = buildNewsletterHtml(customer, topic, writer);

                sendEmail(
                        customer.getEmail(),
                        "Weekly Newsletter: " + topic.getName(),
                        html
                );

                System.out.println("Newsletter sent to: " + customer.getEmail());

            } catch (Exception e) {
                System.err.println("Failed to send for subscription "
                        + sub.getId() + ": " + e.getMessage());
            }
        }
    }

    private String buildNewsletterHtml(Customer customer, Topic topic, Writer writer) {
        return """
                <h1>Hello %s!</h1>
                <p>Here is your weekly content update.</p>

                <h2>Topic: %s</h2>
                <p>Written by: %s</p>

                <p>Your subscription started on: %s</p>

                <p>Enjoy your weekly update!</p>
                """
                .formatted(
                        customer.getName(),
                        topic.getName(),
                        writer.getName(),
                        customer.getId()
                );
    }
}
