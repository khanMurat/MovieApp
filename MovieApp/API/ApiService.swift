//
//  ApiService.swift
//  MovieApp
//
//  Created by Murat on 19.06.2023.
//

import Foundation
import Alamofire

class ApiService {
    
    
    static func fetchMovies(with page:Int,completion : @escaping (Result<Movies,Error>) -> Void){
        
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)"
        
        AF.request(urlString).response { response in
            
            switch response.result {
                
            case .success(let data):
                
                guard let data = data else {return}
                do{
                    let decodedData = try JSONDecoder().decode(Movies.self, from: data)
                    
                    completion(.success(decodedData))
                }catch{
                    print("error")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func searchMovie(text:String,completion : @escaping (Result<Movies,Error>)->Void) {
        
       let urlString = "https://api.themoviedb.org/3/search/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&query=\(text)&page=1&include_adult=false"
        
        AF.request(urlString).response { response in
            
            switch response.result {
                
            case .success(let data):
                
                guard let data = data else {return}
                do{
                    let decodedData = try JSONDecoder().decode(Movies.self, from: data)
                    print(decodedData)
                    completion(.success(decodedData))
                }catch{
                    print("DEBUG:ERROR")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
