//
//  DataService.swift
//  tmdb
//
//  Created by Sultan Karybaev on 12/14/19.
//  Copyright © 2019 Sultan Karybaev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    public private(set) var ALL_MOVIES: [Movie] = []
    
    static let instance = DataService()
    private let API_KEY = "87c71d453b64b7c2c6c1282dc2583cca"
    
    public func getTrendMovies(handler: @escaping ([Movie]) -> ()) {
        Alamofire.request("https://api.themoviedb.org/3/trending/all/day?api_key=\(API_KEY)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let movieArray = json["results"].array else { return }
                for movieJSON in movieArray {
                    let popularity = movieJSON["popularity"].doubleValue
                    let poster = movieJSON["backdrop_path"].stringValue
                    var title = movieJSON["title"].stringValue
                    if title == "" {
                        title = movieJSON["original_name"].stringValue
                    }
                    let id = movieJSON["id"].intValue
                    let movie = Movie(id: id, title: title, poster: poster, popularity: popularity)
                    self.ALL_MOVIES.append(movie)
                }
                self.ALL_MOVIES.sort { $0.popularity > $1.popularity }
                handler(self.ALL_MOVIES)
            case .failure(let error):
                print("DataService getUserMovieProfile error \(error.localizedDescription)")
            }
        }
    }
    
    public func getMovieDescription(movieId: Int, handler: @escaping (String) -> ()) {
        Alamofire.request("https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(API_KEY)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let description = json["overview"].stringValue
                handler(description)
            case .failure(let error):
                print("DataService getUserMovieProfile error \(error.localizedDescription)")
            }
        }
    }
    
}
