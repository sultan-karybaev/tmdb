//
//  ViewController.swift
//  tmdb
//
//  Created by Sultan Karybaev on 12/14/19.
//  Copyright © 2019 Sultan Karybaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var movieArray: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var dataDict: [String: Data] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self        
        DataService.instance.getTrendMovies { (allMovies) in
            self.movieArray = allMovies
        }
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell else { return UITableViewCell() }
        let movie = movieArray[indexPath.row]
        //cell.mainImage = UIImage(data: <#T##Data#>)
        if let data = dataDict[movie.poster] {
            cell.mainImage.image = UIImage(data: data)
        } else {
            cell.mainImage.image = nil
            DownloadService.instance.getImage(indexPath: indexPath, path: "https://image.tmdb.org/t/p/w500\(movie.poster)") { (success, index, data) in
                if success {
                    guard let cell = tableView.cellForRow(at: index) as? MovieCell else { return }
                    cell.mainImage.image = UIImage(data: data)
                    self.dataDict[movie.poster] = data
                }
            }
        }
        cell.title.text = movie.title
        cell.popularity.text = "Popularity: \(movie.popularity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieVC = storyboard?.instantiateViewController(withIdentifier: "MovieVC") as? MovieVC else { return }
        movieVC.movie = movieArray[indexPath.row]
        movieVC.dataDict = dataDict
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
    
    
}


