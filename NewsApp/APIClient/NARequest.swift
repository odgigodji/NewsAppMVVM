//
//  NARequest.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import Foundation

/// Single API Call
final class NARequest {
    
    /// title of article for search
    private var searchTitle: String?
    
    /// current page with list of articles
    private var page: Int?
    
    /// Constucted url for api request for string format
    var urlString: String {
        guard let searchTitle = searchTitle, let page = page else { return "no" }
        let string = "\(NAConstants.baseUrl)?q=\(searchTitle)&apiKey=\(NAConstants.apiKey)&searchIn=\(NAConstants.searchIn)&pageSize=\(NAConstants.pageSize)&page=\(page)"
        
        return string
    }
   
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString.encodeUrl)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    init(searchTitle: String , page: Int) {
        self.searchTitle = searchTitle
        self.page = page
    }
    
}
