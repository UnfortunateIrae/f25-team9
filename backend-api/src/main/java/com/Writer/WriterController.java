package com.Writer;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/writers")
@RequiredArgsConstructor
public class WriterController {

    private final WriterService writerService;

    @PostMapping
    public ResponseEntity<Writer> createWriter(@Valid @RequestBody Writer writer) {
        return ResponseEntity.status(HttpStatus.CREATED).body(writerService.createWriter(writer));
    }

    @PostMapping("/source/{sourceId}")
    public ResponseEntity<Writer> createWriterWithSource(@PathVariable Long sourceId, @Valid @RequestBody Writer writer) {
        return ResponseEntity.status(HttpStatus.CREATED).body(writerService.createWriterWithSource(sourceId, writer));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Writer> updateWriter(@PathVariable Long id, @Valid @RequestBody Writer details) {
        return ResponseEntity.ok(writerService.updateWriter(id, details));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteWriter(@PathVariable Long id) {
        writerService.deleteWriter(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Writer> getWriterById(@PathVariable Long id) {
        return ResponseEntity.ok(writerService.getWriterById(id));
    }

    @GetMapping
    public ResponseEntity<List<Writer>> getAllWriters() {
        return ResponseEntity.ok(writerService.getAllWriters());
    }
}
