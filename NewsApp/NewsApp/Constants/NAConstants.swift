//
//  Constants.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import UIKit

/// API Constants
enum NAConstants: Any {
    
    static let baseUrl  = "https://newsapi.org/v2/everything"
//    static let apiKey   = "67f1fb7253984d74b74a1852f1adfd2d"
//    static let apiKey   = "d30c0c50f9ef48d5b0638565adceca4f"
    static let apiKey   = "44a9235eb8454f2182f5eea27a9542a3"
    static let searchIn = "title"
    static let pageSize = "20"
}

enum Images {
    static let newspaper = UIImage(systemName: "newspaper")
}
