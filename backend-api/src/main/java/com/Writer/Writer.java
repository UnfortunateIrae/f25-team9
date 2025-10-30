package com.Writer;

import java.util.ArrayList;

import com.Article.Article;
import com.Source.Source;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import com.fasterxml.jackson.annotation.JsonBackReference;

import java.util.List;

@Entity
public class Writer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @Email
    private String email;

    @Pattern(regexp = "^\\+?\\d{10,15}$")
    private String phoneNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "source_id", nullable = false)
    @JsonBackReference
    private Source source;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public Source getSource() { return source; }
    public void setSource(Source source) { this.source = source; }

    @OneToMany(mappedBy = "writer", cascade = CascadeType.ALL)
    private List<Article> articles = new ArrayList<>();
}
