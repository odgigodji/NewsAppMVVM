//
//  NAArticle.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import Foundation

/// article model for api call
struct NAArticle: Codable, Hashable {

    let source: NASource
    
    let description: String
    let title: String
    let urlToImage: String?
    let url: String
    let publishedAt: String
    let content: String?
    
    var viewsCounter: Int?
}
