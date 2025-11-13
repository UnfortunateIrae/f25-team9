package com.Topic;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;
import com.Writer.Writer;

@Entity
public class Topic {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToMany(mappedBy = "topics")
    private List<Writer> writers = new ArrayList<>();

    // getters & setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public List<Writer> getWriters() { return writers; }
    public void setWriters(List<Writer> writers) { this.writers = writers; }
}
