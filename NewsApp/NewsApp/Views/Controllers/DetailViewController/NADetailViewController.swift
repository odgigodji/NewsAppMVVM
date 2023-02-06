//
//  NADetailViewController.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 04.02.23.
//

import UIKit


/// View Controller with detail info about Article
final class NADetailViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    var viewModel = NADetailViewModel()
    
    var detailView = NADetailView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Читать полную версию", style: .done, target: self, action: #selector(tap))
        detailView.set(article: viewModel.article!)

    }

    @objc func tap() {
        guard let urlString = viewModel.article?.url else { return }
        coordinator?.showWebViewController(with: urlString)
    }
    
}
