//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import UIKit


struct DetailViewModel {
    
    var movie : Movie
    
    var didLike : Bool {
        return movie.didLike
    }
    
    var buttonImg : UIImage? {
        
        return didLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    var buttonColor : UIColor {
        
        return didLike ? .red : .white
    }
    
    var movieName : String {
        
        return movie.originalTitle
    }
    
    var movieImage : URL? {
        
        return URL(string: Constants.IMAGE_PATH+movie.posterPath)
    }
    
    var releaseDate : String {
        
        return movie.releaseDate
    }
    
    var totalView : Double {
        
        return movie.popularity
    }
    
    var voteAverage : Double {
        
        return movie.voteAverage
    }
    
    var overView : String {
        return movie.overview
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
