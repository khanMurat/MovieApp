//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import Foundation

struct HomeViewModel {
    
    var movie : Movie
    
    var movieName : String {
        return movie.originalTitle
    }
    
    var movieImage : URL? {
        return URL(string: Constants.IMAGE_PATH+movie.posterPath)
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
