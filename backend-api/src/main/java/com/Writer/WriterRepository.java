package com.Writer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
@Repository
public interface WriterRepository extends JpaRepository<Writer, Long> {

    @Query("SELECT w FROM Writer w LEFT JOIN FETCH w.source LEFT JOIN FETCH w.articles WHERE w.id = :id")
    Writer findByIdWithArticlesAndSource(@Param("id") Long id);

    @Query("SELECT w FROM Writer w LEFT JOIN FETCH w.topics WHERE w.id = :id")
    Writer fetchTopics(@Param("id") Long id);

    @Query("SELECT DISTINCT w FROM Writer w LEFT JOIN FETCH w.source")
    List<Writer> findAllWithSource();

    @Query("SELECT DISTINCT w FROM Writer w LEFT JOIN FETCH w.source LEFT JOIN FETCH w.articles LEFT JOIN FETCH w.topics")
    List<Writer> findAllWithDetails();

    @Query("SELECT w FROM Writer w WHERE w.name = :name")
    Optional<Writer> findByName(@Param("name") String name);
}