package com.andycodev.movies_backend.controllers;

import com.andycodev.movies_backend.models.Movie;
import com.andycodev.movies_backend.repositories.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/movies")
public class MovieController {

    @Autowired
    private MovieRepository movieRepository;

    @CrossOrigin
    //@GetMapping("/list") si deseo ampliar mi url
    @GetMapping
    public List<Movie> getMovies() {
        return movieRepository.findAll();
    }

    @CrossOrigin
    @GetMapping("/{id}")
    public ResponseEntity<Movie> getMovieById(@PathVariable Long id) {
      Optional<Movie> movie = movieRepository.findById(id);
      return movie.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @CrossOrigin
    @PostMapping
    public ResponseEntity<Movie> createMovie(@RequestBody Movie movie) {
        Movie saveMovie = movieRepository.save(movie);
        return ResponseEntity.status(HttpStatus.CREATED).body(saveMovie);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Movie> updateMovie(@PathVariable Long id, @RequestBody Movie movie) {
        if(!movieRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        movie.setMovieId(id);
        Movie saveMovie = movieRepository.save(movie);
        return ResponseEntity.ok(saveMovie);
    }

    @CrossOrigin
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMovie(@PathVariable Long id) {
        if(!movieRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        movieRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

}
