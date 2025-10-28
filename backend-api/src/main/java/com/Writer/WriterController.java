package com.Writer;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;

@RestController
@RequestMapping("/writers")
@RequiredArgsConstructor
public class WriterController {

    private final WriterService writerService;

    @PostMapping
    public ResponseEntity<Writer> createWriter(@Valid @RequestBody Writer writer) {
        Writer createdWriter = writerService.createWriter(writer);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(createdWriter.getId())
                .toUri();
        return ResponseEntity.created(location).body(createdWriter);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Writer> getWriterById(@PathVariable Long id) {
        Writer writer = writerService.getWriterById(id);
        return ResponseEntity.ok(writer);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Writer> updateWriter(@PathVariable Long id, @Valid @RequestBody Writer writerDetails) {
        Writer updatedWriter = writerService.updateWriter(id, writerDetails);
        return ResponseEntity.ok(updatedWriter);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteWriter(@PathVariable Long id) {
        writerService.deleteWriter(id);
        return ResponseEntity.noContent().build();
    }
}
