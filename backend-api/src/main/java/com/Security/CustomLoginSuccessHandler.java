package com.Security;

import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException {

        CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();

        if ("WRITER".equals(user.getAccountType())) {
            response.sendRedirect("/writers/" + user.getId());
        } else if ("CUSTOMER".equals(user.getAccountType())) {
            response.sendRedirect("/customer/home/" + user.getId());
        } else {
            response.sendRedirect("/");
        }

    }
}
