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
    private PasswordEncoder passwordEncoder;

    private String accountType;
    private Object id;

    public CustomUserDetailsService(CustomerRepository customerRepo,
                                    WriterRepository writerRepo,
                                    PasswordEncoder passwordEncoder) {
        this.customerRepo = customerRepo;
        this.writerRepo = writerRepo;
        this.passwordEncoder = passwordEncoder;
    }

     public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
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
