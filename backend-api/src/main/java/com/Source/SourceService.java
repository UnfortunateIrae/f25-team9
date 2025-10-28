package com.Source;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SourceService {

    private final SourceRepository sourceRepository;

    public Source createSource(Source source) { return sourceRepository.save(source); }
    public Source updateSource(Long id, Source details) {
        Source source = sourceRepository.findById(id).orElseThrow(() -> new RuntimeException("Source not found"));
        source.setName(details.getName());
        source.setUrl(details.getUrl());
        return sourceRepository.save(source);
    }
    public void deleteSource(Long id) { sourceRepository.deleteById(id); }
    public Source getSourceById(Long id) { return sourceRepository.findById(id).orElseThrow(() -> new RuntimeException("Source not found")); }
    public List<Source> getAllSources() { return sourceRepository.findAll(); }
}
