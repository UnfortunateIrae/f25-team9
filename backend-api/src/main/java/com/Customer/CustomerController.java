package com.customer;  // package names should be lowercase!

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/customers")
public class CustomerController {

    private final CustomerRepository repo;

    @Autowired
    public CustomerController(CustomerRepository repo) {
        this.repo = repo;
    }

    // CREATE
    @PostMapping
    public Customer create(@RequestBody Customer c) {
        return repo.save(c);
    }

    // READ (all)
    @GetMapping
    public List<Customer> all() {
        return repo.findAll();
    }

    // READ (by id)
    @GetMapping("/{id}")
    public Optional<Customer> get(@PathVariable Long id) {
        return repo.findById(id);
    }

    // UPDATE
    @PutMapping("/{id}")
    public Customer update(@PathVariable Long id, @RequestBody Customer updated) {
        updated.setId(id);
        return repo.save(updated);
    }

    // DELETE
    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        repo.deleteById(id);
    }
}
