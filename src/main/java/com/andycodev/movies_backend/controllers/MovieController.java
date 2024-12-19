package com.andycodev.movies_backend.controllers;

import com.andycodev.movies_backend.models.Movie;
import com.andycodev.movies_backend.repositories.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("api/movies")
public class MovieController {

    @Autowired
    private MovieRepository movieRepository;

    //@GetMapping("/list") si deseo ampliar mi url
    @GetMapping
    public List<Movie> getAllMovies() {
        return movieRepository.findAll();
    }



}
