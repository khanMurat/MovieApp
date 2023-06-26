//
//  FavoriteModel.swift
//  MovieApp
//
//  Created by Murat on 20.06.2023.
//

import RealmSwift

class FavoriteMovie: Object {
    @objc dynamic var movieID : Int = 0
    @objc dynamic var isLiked = false
    @objc dynamic var title = ""
    @objc dynamic var imagepath = ""
}
