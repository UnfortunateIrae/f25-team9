package com;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.Customer.CustomerRepository;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private CustomerRepository customerRepository;

    @ModelAttribute
    public void addCustomerToModel(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            String email = auth.getName();
            customerRepository.findByEmail(email).ifPresent(customer -> {
                model.addAttribute("customer", customer);
            });
        }
    }
}
