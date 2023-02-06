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
    var scrollView = UIScrollView()
    
    override func loadView() {
        super.loadView()
//        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Читать полную версию", style: .done, target: self, action: #selector(tap))
        detailView.set(article: viewModel.article!)
        configureScrollView()
        configureDetailView()
    }
    
    //MARK: - Private
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .yellow
        
        scrollView.pinToEdges(of: view)
    }
    
    private func configureDetailView() {
        scrollView.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        detailView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }

    @objc func tap() {
        guard let urlString = viewModel.article?.url else { return }
        coordinator?.showWebViewController(with: urlString)
    }
    
}
