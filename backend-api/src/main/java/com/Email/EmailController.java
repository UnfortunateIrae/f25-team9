package com.Email;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.stereotype.Controller;


@Controller
public class EmailController {

    private final EmailService mailService;

    public EmailController(EmailService mailService) {
        this.mailService = mailService;
    }

    @GetMapping("/send-test")
    public String sendTest() throws Exception {
        mailService.sendEmail(
                "jamesjkerrigan05@gmail.com",
                "Test Email",
                "<h1>Hello from Spring Boot + Mailjet</h1>"
        );
        return "redirect:/";
    }
}
