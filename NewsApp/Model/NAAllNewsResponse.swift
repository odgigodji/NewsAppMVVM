//
//  NAAllNewsResponse.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import Foundation


/// all news response model for api call
struct NAAllNewsResponse: Codable {
    
    let status: String?
    let totalResults: Int?
    
    let code: String?
    let message: String?
    
    let articles: [NAArticle]?
}
