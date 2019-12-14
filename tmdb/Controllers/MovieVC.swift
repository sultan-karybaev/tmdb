//
//  MovieVC.swift
//  tmdb
//
//  Created by Sultan Karybaev on 12/14/19.
//  Copyright © 2019 Sultan Karybaev. All rights reserved.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public var movie: Movie!
    public var dataDict: [String: Data] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        self.navigationItem.title = movie.title
        DataService.instance.getMovieDescription(movieId: movie.id) { (description) in
            self.descriptionLabel.text = description
        }
        if let data = dataDict[movie.poster] {
            self.mainImage.image = UIImage(data: data)
        } else {
            self.mainImage.image = nil
            DownloadService.instance.getImage(indexPath: IndexPath(), path: "https://image.tmdb.org/t/p/w500\(self.movie.poster)") { (success, index, data) in
                if success {
                    self.mainImage.image = UIImage(data: data)
                    self.dataDict[self.movie.poster] = data
                }
            }
        }
    }

}
