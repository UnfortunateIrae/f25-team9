package com.Writer;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/writers")
@RequiredArgsConstructor
public class WriterController {
    private final WriterService WriterService;

    @PostMapping
    public ResponseEntity<Writer> createWriter(@Valid @RequestBody Writer Writer) {
        return ResponseEntity.ok(WriterService.createWriter(Writer));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Writer> updateWriter(@PathVariable Long id, @Valid @RequestBody Writer WriterDetails) {
        return ResponseEntity.ok(WriterService.updateWriter(id, WriterDetails));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Writer> getWriter(@PathVariable Long id) {
        return ResponseEntity.ok(WriterService.getWriterById(id));
    }
}
