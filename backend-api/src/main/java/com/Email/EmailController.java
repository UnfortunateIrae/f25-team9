package com.Email;

import org.springframework.web.bind.annotation.GetMapping;
import java.util.List;
import com.Article.Article;
import com.Article.ArticleRepository;
import com.Subscription.Subscription;
import com.Subscription.SubscriptionRepository;
import com.Customer.Customer;
import com.Customer.CustomerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class EmailController {

    @Autowired
    private ArticleRepository articleRepository;

    @Autowired
    private SubscriptionRepository subscriptionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    private final EmailService mailService;

    public EmailController(EmailService mailService) {
        this.mailService = mailService;
    }

    @GetMapping("/send-test")
    public String sendTest() throws Exception {
        String email = "jamesjkerrigan05@gmail.com";
        String html = """
                <html>
                <head>
                    <meta charset="UTF-8">
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background: #f5f5f5;
                            padding: 20px;
                        }
                        .container {
                            max-width: 600px;
                            margin: auto;
                            background: #ffffff;
                            border-radius: 10px;
                            padding: 30px;
                            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
                        }
                        .header {
                            text-align: center;
                            margin-bottom: 25px;
                        }
                        .section {
                            margin-bottom: 20px;
                        }
                        .topic-card {
                            background: #fafafa;
                            padding: 15px;
                            border-radius: 8px;
                            margin-bottom: 15px;
                            border-left: 4px solid #4e73df;
                        }
                        .footer {
                            margin-top: 40px;
                            font-size: 12px;
                            color: #777;
                            text-align: center;
                        }
                    </style>
                </head>

                <body>
                <div class="container">

                    <div class="header">
                        <h1>{{headline}}</h1>
                        <p>{{subheadline}}</p>
                    </div>

                    <div class="section">
                        <h2>Hello {{username}},</h2>
                        <p>{{intro_message}}</p>
                    </div>

                    <div class="section">
                        {{articles_block}}
                    </div>

                    <div class="footer">
                        {{footer_note}}
                    </div>

                </div>
                </body>
                </html>
                """;

        List<Subscription> subs = subscriptionRepository.findByCustomerEmail(email);

        StringBuilder articlesBlock = new StringBuilder();

        for (Subscription s : subs) {
            Article a = articleRepository.findFirstByTopicIdOrderByCreatedAtDesc(s.getTopic().getId());

            if (a == null)
                continue;

            String snippet = a.getContent().length() > 200
                    ? a.getContent().substring(0, 200) + "..."
                    : a.getContent();

            articlesBlock.append("""
                        <div class="topic-card">
                            <h3>%s</h3>
                            <p>%s</p>
                            <a href="https://your-site.com/article/%d">Read more →</a>
                        </div>
                    """.formatted(a.getTitle(), snippet, a.getId()));
        }

        Customer customer = customerRepository.findByEmail(email).orElse(null);

        html = html.replace("{{headline}}", "Your Weekly Digest");
        html = html.replace("{{subheadline}}", "Fresh content from your subscriptions");
        html = html.replace("{{username}}", customer.getName());
        html = html.replace("{{intro_message}}", "Here's everything new this week:");
        html = html.replace("{{articles_block}}", articlesBlock.toString());
        html = html.replace("{{footer_note}}", "You can manage your subscriptions anytime.");

        mailService.sendEmail(
                email,
                "Your Weekly Newsletter!",
                html);
        return "redirect:/";
    }
}
