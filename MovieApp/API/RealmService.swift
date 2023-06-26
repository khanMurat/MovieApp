//
//  RealmService.swift
//  MovieApp
//
//  Created by Murat on 20.06.2023.
//

import UIKit
import RealmSwift

class RealmService {
    
    let realm = try? Realm()
    
     func addFavorite(id:Int,movie:Movie) {
        
        let favMovie = FavoriteMovie()
        favMovie.movieID = id
        favMovie.isLiked = movie.didLike
         favMovie.imagepath = movie.posterPath
         favMovie.title = movie.title
        
        try! realm?.write {
                  realm?.add(favMovie)
        }
    }
    
    func removeFavorite(id:Int) {
        guard let data = realm?.objects(FavoriteMovie.self).filter("movieID == %@", id).first else { return }
        try! realm?.write{
            data.isLiked = false
        }
    }
    
    func filteredFavorites() -> Results<FavoriteMovie>? {
          let favorites = realm?.objects(FavoriteMovie.self)
          let favorited = favorites?.where {
              $0.isLiked == true
          }
          return favorited
      }
    func getAllFavorites() -> Results<FavoriteMovie>? {
        let allFavorites = realm?.objects(FavoriteMovie.self)
        return allFavorites
    }
    
    func checkIfMovieLiked(movie:Movie,completion:@escaping (Bool)->Void){
        
        let favoriteMovies = filteredFavorites()
        
        let isLiked = favoriteMovies?.contains(where: { $0.movieID == movie.id && $0.isLiked }) ?? false
        
        completion(isLiked)
    }
}
