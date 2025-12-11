package com.Security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.List;
import java.util.Collection;

public class CustomUserDetails implements UserDetails {

    private Long id;
    private String email;
    private String password;
    private String accountType;

    public CustomUserDetails(Long id, String email, String password, String accountType) {
        this.id = id;
        this.email = email;
        this.password = password;
        this.accountType = accountType;
    }

    public Long getId() {
        return id;
    }

    public String getAccountType() {
        return accountType;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(accountType)); // "CUSTOMER" or "ADMIN"
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
