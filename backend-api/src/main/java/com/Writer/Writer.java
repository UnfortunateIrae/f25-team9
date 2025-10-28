package com.Writer;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import com.Source.*;

@Data
@NoArgsConstructor
@Entity
@Table(name = "writers")
public class Writer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Column(nullable = false)
    private String name;

    @Email
    @NotBlank
    @Column(unique = true, nullable = false)
    private String email;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonIgnoreProperties("writers")
    private Source source;

    private String phoneNumber;

    public Writer(Long id) {
        this.id = id;
    }
}
