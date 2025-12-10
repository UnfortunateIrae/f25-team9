package com.Security;

import com.Writer.Writer;
import com.Writer.WriterRepository;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class WriterUserDetailsService implements UserDetailsService {

    private final WriterRepository writerRepository;

    public WriterUserDetailsService(WriterRepository writerRepository) {
        this.writerRepository = writerRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        System.out.println("Attempting login for writer: " + email); // debug

        Writer writer = writerRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("No writer found with email: " + email));

        return new org.springframework.security.core.userdetails.User(
                writer.getEmail(),
                writer.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_WRITER"))
        );
    }
}
