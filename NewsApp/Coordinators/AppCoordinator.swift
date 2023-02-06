//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var cachedCounter = 0
    var cachedArticles: [NAArticle]? = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NANewsTableViewController()
        let viewModel = NewsViewModel(searchTitle: nil)

        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: false)
    }
    
    
    func showDetailVC(with article: NAArticle) {
        let vc = NADetailViewController()
        vc.coordinator = self
        vc.viewModel = NADetailViewModel()
        
        vc.viewModel.article = article
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showWebViewController(with urlString: String) {
        let vc =  NAWebViewController()
        vc.urlString = urlString
        
        navigationController.pushViewController(vc, animated: true)
    }

}
