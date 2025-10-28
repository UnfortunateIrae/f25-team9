package com.Writer;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Source.*;


@Service
@RequiredArgsConstructor
@Transactional
public class WriterService {

    private final WriterRepository writerRepository;

    public static class DuplicateEmailException extends RuntimeException {
        public DuplicateEmailException(String message) {
            super(message);
        }
    }

    public static class ResourceNotFoundException extends RuntimeException {
        public ResourceNotFoundException(String message) {
            super(message);
        }
    }

    public Writer createWriter(Writer writer) {
        if (writerRepository.existsByEmail(writer.getEmail())) {
            throw new DuplicateEmailException("Email already in use: " + writer.getEmail());
        }
        return writerRepository.save(writer);
    }

    @Transactional(readOnly = true)
    public Writer getWriterById(Long id) {
        return writerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Writer not found with id: " + id));
    }

    public Writer updateWriter(Long id, Writer writerDetails) {
        Writer writer = getWriterById(id);

        writer.setName(writerDetails.getName());

        if (!writer.getEmail().equals(writerDetails.getEmail()) &&
                writerRepository.existsByEmail(writerDetails.getEmail())) {
            throw new DuplicateEmailException("Email already in use: " + writerDetails.getEmail());
        }

        writer.setEmail(writerDetails.getEmail());
        writer.setPhoneNumber(writerDetails.getPhoneNumber());
        writer.setSource(writerDetails.getSource());

        return writerRepository.save(writer);
    }

    public void deleteWriter(Long id) {
        Writer writer = getWriterById(id);
        writerRepository.delete(writer);
    }
}
