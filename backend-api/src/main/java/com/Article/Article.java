package com.Article;

import com.Writer.Writer;
import com.Topic.Topic;
import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
// Avoid serializing Hibernate proxies; writer serialization is handled
// via @JsonBackReference on the `writer` field and @JsonManagedReference on Writer.articles
@JsonIgnoreProperties({"hibernateLazyInitializer","handler"})
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String title;

    @NotBlank
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "writer_id")
    @JsonBackReference
    private Writer writer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "topic_id")
    private Topic topic;

    // JPA requires a no-arg constructor
    public Article() { }

    public Article(String title, String content, Writer writer) {
        this.title = title;
        this.content = content;
        this.writer = writer;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Writer getWriter() { return writer; }
    public void setWriter(Writer writer) { this.writer = writer; }

    public Topic getTopic() { return topic; }
    public void setTopic(Topic topic) { this.topic = topic; }
}
