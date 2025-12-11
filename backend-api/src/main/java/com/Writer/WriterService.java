package com.Writer;

import java.util.List;

import org.springframework.stereotype.Service;

import com.Source.Source;
import com.Source.SourceRepository;

@Service
public class WriterService {

    private final WriterRepository writerRepository;
    private final SourceRepository sourceRepository;

    public WriterService(WriterRepository writerRepository, SourceRepository sourceRepository) {
        this.writerRepository = writerRepository;
        this.sourceRepository = sourceRepository;
    }

    public Writer createWriter(Writer writer) {
        if (writer.getSource() == null || writer.getSource().getId() == null) {
            Source defaultSource = sourceRepository.findById(1L)
                    .orElseThrow(() -> new RuntimeException("Default Source missing"));
            writer.setSource(defaultSource);
        } else {
            Source existingSource = sourceRepository.findById(writer.getSource().getId())
                    .orElseThrow(() -> new RuntimeException("Source not found"));
            writer.setSource(existingSource);
        }
        return writerRepository.save(writer);
    }

    public Writer createWriterWithSource(Long sourceId, Writer writer) {
        Source source = sourceRepository.findById(sourceId)
                .orElseThrow(() -> new RuntimeException("Source not found"));
        writer.setSource(source);
        return writerRepository.save(writer);
    }

    public Writer updateWriter(Long id, Writer details) {
        Writer writer = writerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Writer not found"));

        writer.setName(details.getName());
        writer.setEmail(details.getEmail());
        writer.setPhoneNumber(details.getPhoneNumber());
        writer.setSource(details.getSource());

        return writerRepository.save(writer);
    }

    public void deleteWriter(Long id) {
        writerRepository.deleteById(id);
    }

    public Writer getWriterById(Long id) {
        return writerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Writer not found"));
    }

    public List<Writer> getAllWriters() {
        return writerRepository.findAll();
    }

    public String findByID(Long id) {
        return writerRepository.findById(id)
                .map(Writer::getName)
                .orElseThrow(() -> new RuntimeException("Writer not found"));
    }
}
