//
//  DownloadService.swift
//  tmdb
//
//  Created by Sultan Karybaev on 12/14/19.
//  Copyright © 2019 Sultan Karybaev. All rights reserved.
//

import Foundation

class DownloadService {
    
    static let instance = DownloadService()
    
    public func getImage(indexPath: IndexPath, path: String, handler: @escaping( (Bool, IndexPath, Data) -> () )) {
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: URL(string: path)!)
                DispatchQueue.main.async {
                    handler(true, indexPath, data)
                }
            } catch let error {
                debugPrint("DownloadService.swift \(error.localizedDescription)")
            }
        }
    }
}
