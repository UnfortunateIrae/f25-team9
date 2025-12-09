package com.Email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EmailController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/send-test-email")
    public void sendTestEmail() {
        emailService.sendSimpleEmail(
                "jamesjkerrigan05@gmail.com",
                "Test Email",
                "This is a test email from Spring Boot!"
        );
    }
}
