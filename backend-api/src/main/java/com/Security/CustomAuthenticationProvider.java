package com.Security;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;



@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

    private final CustomUserDetailsService uds;
    private final PasswordEncoder encoder;

    public CustomAuthenticationProvider(CustomUserDetailsService uds, PasswordEncoder encoder) {
        this.uds = uds;
        this.encoder = encoder;
    }

    @Override
    public Authentication authenticate(Authentication auth) {
        String email = auth.getName();
        String password = auth.getCredentials().toString();

        UserDetails user = uds.loadUserByUsername(email);

        if (!encoder.matches(password, user.getPassword())) {
            throw new BadCredentialsException("Invalid credentials");
        }

        return new UsernamePasswordAuthenticationToken(
                user, user.getPassword(), user.getAuthorities()
        );
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(clazz);
    }
}

