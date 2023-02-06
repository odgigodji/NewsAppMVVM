//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 04.02.23.
//

import UIKit


/// Manager for download Image
final class ImageManager {
    
    static let shared   = ImageManager()
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    /// download image from url
    /// - Parameters:
    ///   - urlString: string url
    ///   - completed: completion handler
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { completed(nil); return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
}
