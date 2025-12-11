package com.Security;

import com.Customer.CustomerRepository;

import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import com.Writer.WriterRepository;
import org.springframework.security.crypto.password.PasswordEncoder;

@Service
public class CustomUserDetailsService{

    private CustomerRepository customerRepo;
    private WriterRepository writerRepo;
    private String accountType;
    private Object id;

    public CustomUserDetailsService(CustomerRepository customerRepo,
                                    WriterRepository writerRepo,
                                    PasswordEncoder passwordEncoder) {
        this.customerRepo = customerRepo;
        this.writerRepo = writerRepo;
    }

     public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        if (email == "admin@me.com"){
            return new CustomUserDetails(
                    0L,
                    "admin@me.com",
                    "$2a$10$Dow1v0uK5bY0c69mY1FhEuJ8v0b0F5lH6b6j/3p6tKqFhQWJ9y5eW",
                    "ADMIN");
        }
        var customer = customerRepo.findByEmail(email);
        if (customer.isPresent()) {
            var c = customer.get();
            return new CustomUserDetails(
                    c.getId(),
                    c.getEmail(),
                    c.getPassword(),
                    "CUSTOMER"
            );
        }

        var writer = writerRepo.findByEmail(email);
        if (writer.isPresent()) {
            var w = writer.get();
            return new CustomUserDetails(
                    w.getId(),
                    w.getEmail(),
                    w.getPassword(),
                    "WRITER"
            );
        }

        throw new UsernameNotFoundException("User not found");
    }

    public String getAccountType() {
        return accountType;
    }

    public Object getId() {
        return id;
    }
}
