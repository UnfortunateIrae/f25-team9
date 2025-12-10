package com.Security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {
    @Autowired
    private CustomLoginSuccessHandler customLoginSuccessHandler;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CustomAuthenticationProvider customAuthenticationProvider(
            CustomUserDetailsService userDetailsService,
            PasswordEncoder encoder) {

        return new CustomAuthenticationProvider(userDetailsService, encoder);
    }

    @Bean
    public AuthenticationManager authenticationManager(
            HttpSecurity http,
            CustomAuthenticationProvider provider) throws Exception {

        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .authenticationProvider(provider)
                .build();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .csrf(csrf -> csrf
                        .ignoringRequestMatchers("/logout"))

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/login", "/register", "/CSS/**", "/JS/**").permitAll()
                        .anyRequest().authenticated())

                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .usernameParameter("email")
                        .passwordParameter("password")
                        .successHandler(customLoginSuccessHandler)
                        .failureUrl("/login?error=true")
                        .permitAll())

                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .invalidateHttpSession(true)
                        .clearAuthentication(true)
                        .permitAll());

        return http.build();
    }
}
