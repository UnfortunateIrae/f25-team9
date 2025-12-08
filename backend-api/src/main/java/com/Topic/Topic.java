package com.Topic;

import com.Article.Article;
import com.Writer.Writer;
import com.Customer.Customer;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
public class Topic {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String url;

    @ManyToMany
    @JoinTable(
        name = "writer_topic",
        joinColumns = @JoinColumn(name = "topic_id"),
        inverseJoinColumns = @JoinColumn(name = "writer_id")
    )
    private List<Writer> writers = new ArrayList<>();

    @OneToMany(mappedBy = "topic", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Article> articles = new ArrayList<>();

    // Add this to link customers
    @ManyToMany(mappedBy = "subscriptions")
    private Set<Customer> customers = new HashSet<>();

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public List<Writer> getWriters() { return writers; }
    public void setWriters(List<Writer> writers) { this.writers = writers; }

    public List<Article> getArticles() { return articles; }
    public void setArticles(List<Article> articles) { this.articles = articles; }

    public Set<Customer> getCustomers() { return customers; }
    public void setCustomers(Set<Customer> customers) { this.customers = customers; }
}
