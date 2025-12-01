package com.Source;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/sources")
public class SourceController {

    private final SourceService sourceService;

    public SourceController(SourceService sourceService) {
        this.sourceService = sourceService;
    }

    @PostMapping
    public ResponseEntity<Source> createSource(@Valid @RequestBody Source source) {
        return ResponseEntity.status(HttpStatus.CREATED).body(sourceService.createSource(source));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Source> updateSource(@PathVariable Long id, @Valid @RequestBody Source details) {
        return ResponseEntity.ok(sourceService.updateSource(id, details));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSource(@PathVariable Long id) {
        sourceService.deleteSource(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Source> getSourceById(@PathVariable Long id) {
        return ResponseEntity.ok(sourceService.getSourceById(id));
    }

    @GetMapping
    public ResponseEntity<List<Source>> getAllSources() {
        return ResponseEntity.ok(sourceService.getAllSources());
    }
}
