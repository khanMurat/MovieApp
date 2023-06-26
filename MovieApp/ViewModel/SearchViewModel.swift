//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import Foundation

struct FavoriteViewModel {
    
    var favorites : FavoriteMovie
    
    var isLiked : Bool {
        return favorites.isLiked
    }
    
    var id : Int {
        return favorites.movieID
    }
    
    var title : String {
        
        return favorites.title
        
    }
    
    var image : URL? {
        
        return URL(string: Constants.IMAGE_PATH+favorites.imagepath)
        
    }

    init(favorites: FavoriteMovie) {
        self.favorites = favorites
    }
}
