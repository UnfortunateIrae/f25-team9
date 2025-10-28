package com.Writer;

import com.Source.Source;
import com.Source.SourceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class WriterService {

    private final WriterRepository writerRepository;
    private final SourceRepository sourceRepository;

    public Writer createWriter(Writer writer) { return writerRepository.save(writer); }

    public Writer createWriterWithSource(Long sourceId, Writer writer) {
        Source source = sourceRepository.findById(sourceId).orElseThrow(() -> new RuntimeException("Source not found"));
        writer.setSource(source);
        return writerRepository.save(writer);
    }

    public Writer updateWriter(Long id, Writer details) {
        Writer writer = writerRepository.findById(id).orElseThrow(() -> new RuntimeException("Writer not found"));
        writer.setName(details.getName());
        writer.setEmail(details.getEmail());
        writer.setPhoneNumber(details.getPhoneNumber());
        writer.setSource(details.getSource());
        return writerRepository.save(writer);
    }

    public void deleteWriter(Long id) { writerRepository.deleteById(id); }
    public Writer getWriterById(Long id) { return writerRepository.findById(id).orElseThrow(() -> new RuntimeException("Writer not found")); }
    public List<Writer> getAllWriters() { return writerRepository.findAll(); }
}
