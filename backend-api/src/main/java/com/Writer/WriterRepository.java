package com.Writer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface WriterRepository extends JpaRepository<Writer, Long> {
    @Query("SELECT w FROM Writer w JOIN FETCH w.source")
    List<Writer> findAllWithSource();
}
