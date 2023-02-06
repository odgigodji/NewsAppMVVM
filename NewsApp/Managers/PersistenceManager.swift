//
//  PersistenceManager.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import Foundation

/// Manager for work with UserDefaults
final class NAPersistanceManager {
    static let userDefaults: UserDefaults = UserDefaults.standard
    
    static let shared = NAPersistanceManager()
    
    /// Save article in UD
    /// - Parameters:
    ///   - article: article for save
    ///   - key: key for encode
    static func save(article: NAArticle, with key: String) {
        let encoder = JSONEncoder()
        let article = article
        let jsonData = try! encoder.encode(article)
        
        userDefaults.set(jsonData, forKey: key)
    }
    
    
    /// get value from UserDefaults
    /// - Parameter key: key for search
    /// - Returns: Optional article
    static func getArticleBy(key: String) -> NAArticle? {
        if let data = userDefaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            guard let model = try? decoder.decode(NAArticle.self, from: data) else { return nil}
            return model
        }
        return nil
    }
    
}
