package com.Writer;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import com.Source.SourceRepository;
import com.Source.Source;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import java.util.List;
import jakarta.validation.Valid;
import org.springframework.transaction.annotation.Transactional;


@RestController
@RequestMapping("/api/writers")
@RequiredArgsConstructor
public class WriterController {

    @Autowired
    private WriterService writerService;

    private final WriterRepository writerRepository;
    private final SourceRepository sourceRepository;

    @PostMapping
    @Transactional
    public ResponseEntity<Writer> createWriter(@RequestBody Writer writer) {

        Source source = writer.getSource();

        if (source == null || source.getId() == null) {
            // Get or create default source
            source = sourceRepository.findByName("Default Source")
                    .orElseGet(() -> {
                        Source s = new Source();
                        s.setName("Default Source");
                        s.setUrl("http://default-source.local");
                        return sourceRepository.save(s);
                    });
        } else {
            // Ensure provided source exists
            source = sourceRepository.findById(source.getId())
                    .orElseThrow(() -> new RuntimeException("Source not found"));
        }

        writer.setSource(source);
        Writer saved = writerRepository.save(writer);

        return ResponseEntity.status(HttpStatus.CREATED).body(saved);
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
