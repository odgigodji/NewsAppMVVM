//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import Foundation


/// protocol for NewViewModel
protocol ObservableViewModelProtocol {
    func createRequest(with searchTitle: String, page: Int)
    var cachedArticles: Dynamic<[NAArticle]> { get set }
    var articles: Dynamic<[NAArticle]> { get  set }
    var errorResponse: Dynamic<NAAllNewsResponse> { get set }
}

final class NewsViewModel: ObservableViewModelProtocol {
    
    /// cached articles from user defaults
    var cachedArticles: Dynamic<[NAArticle]> = Dynamic([])
    
    /// articles from web
    var articles: Dynamic<[NAArticle]> = Dynamic([])
    
    /// title for search news
    var searchTitle: String?
    
    /// response with status, number of news , all articles
    var allNewsResponse : NAAllNewsResponse?
    
    /// error
    var errorResponse: Dynamic<NAAllNewsResponse> = Dynamic(NAAllNewsResponse(status: "", totalResults: nil, code: "", message: "", articles: nil))
    
    /// bool flag show when articles from cache
    var isArticlesFromCache = true
    
    
    /// key for create array of cached articles
    var counterForKey = 0
    
    
    init(searchTitle: String?) {
        self.searchTitle = searchTitle
    }
    
    /// fetch all articles store in userDefaults
    func fetchCachedArticles() {
        counterForKey = UserDefaults.standard.integer(forKey: "counterForKey")
        for key in 0..<counterForKey {
            let keyString = String(key)
            guard let cachedArticle = NAPersistanceManager.getArticleBy(key: keyString) else { return }
            cachedArticles.value.append(cachedArticle)
        }
    }
    
    /// return articles to viewController
    /// - Returns: returns articles cache or fetched from web
    func getArticles() -> [NAArticle] {
        if isArticlesFromCache {
            return cachedArticles.value
        } else {
            return articles.value
        }
    }
    
    
    /// create array of ch
    /// - Parameter article: article for saving
    func saveInCache(article: NAArticle) {
        let keyString = String(counterForKey)
        print("COUNTERFOR KEYY = \(counterForKey)")
        NAPersistanceManager.save(article: article, with: keyString)
        cachedArticles.value.append(NAPersistanceManager.getArticleBy(key: keyString)!)
        
        UserDefaults.standard.set(counterForKey, forKey: "counterForKey")
        
        counterForKey = UserDefaults.standard.integer(forKey: "counterForKey")
        counterForKey += 1
        
        UserDefaults.standard.set(counterForKey, forKey: "counterForKey")
    }
    
    
    /// resaving article in userDefaults
    /// - Parameters:
    ///   - article: article for saving
    ///   - key: indexPath
    func saveInCache(article: NAArticle, with key: Int) {
        let keyString = String(key)
        NAPersistanceManager.save(article: article, with: keyString)
    }
    
    
    /// create first request
    /// - Parameters:
    ///   - searchTitle: title from searchBar
    ///   - page: first page
    func createRequest(with searchTitle: String, page: Int) {
        
        if searchTitle.isEmpty { return }
        self.searchTitle = searchTitle
        
        let request = NARequest(searchTitle: searchTitle, page: page)
        
        NAService.shared.execute(request, expecting: NAAllNewsResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.handleSuccessResult(responseModel: responseModel)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.handleErrorResult(error: error)
                }
            }
        }
    }
    
    
    /// mathod we call when page > 1
    /// - Parameter page: current page
    func createAnotherRequest(page: Int) {
        guard let searchTitle = searchTitle, !searchTitle.isEmpty else { return }
        
        let request = NARequest(searchTitle: searchTitle, page: page)
        NAService.shared.execute(request, expecting: NAAllNewsResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.handleSuccessResultAnotherRequest(responseModel: responseModel)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.handleErrorResult(error: error)
                }
            }
        }
    }
    
    
    private func handleSuccessResult(responseModel: NAAllNewsResponse) {
        if responseModel.status == "error" {
            self.errorResponse.value = responseModel
        } else {
            self.allNewsResponse = responseModel
            guard let articles = responseModel.articles else { return }
            self.articles.value =  articles
        }
    }
    
    private func handleSuccessResultAnotherRequest(responseModel: NAAllNewsResponse) {
        if responseModel.status == "error" {
            self.errorResponse.value = responseModel
        } else {
            self.allNewsResponse = responseModel
            guard let articles = responseModel.articles else { return }
            self.articles.value += articles
        }
    }
    
    private func handleErrorResult(error: Error) {
        let code = error.localizedDescription
        self.errorResponse.value = NAAllNewsResponse(status: nil, totalResults: nil, code: code, message: nil, articles: nil)
    }
    
}
