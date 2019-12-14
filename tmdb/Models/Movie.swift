//
//  Movie.swift
//  tmdb
//
//  Created by Sultan Karybaev on 12/14/19.
//  Copyright © 2019 Sultan Karybaev. All rights reserved.
//

import Foundation

struct Movie {
    
    public private(set) var id: Int = 0
    public private(set) var title: String = ""
    public private(set) var poster: String = ""
    public private(set) var popularity: Double = 0.0
    
    init(id: Int, title: String, poster: String, popularity: Double) {
        self.id = id
        self.title = title
        self.poster = poster
        self.popularity = popularity
    }
}
