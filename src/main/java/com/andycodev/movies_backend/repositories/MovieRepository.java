package com.andycodev.movies_backend.repositories;

import com.andycodev.movies_backend.models.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovieRepository extends JpaRepository<Movie, Long> {

}
