//
//  NANewsTableViewController.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import UIKit

/// Start controller with list of news and search controller
final class NANewsTableViewController: UITableViewController {
    
    weak var coordinator: AppCoordinator?
    var viewModel   = NewsViewModel(searchTitle: nil)
    var page        = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        configureSearchController()
        configureTableView()
        configureRefreshControl()
        
        viewModel.fetchCachedArticles()
    }
    
    /// Connect ViewController and ViewModel
    private func bindViewModel() {
        viewModel.articles.bind { (articles) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
        viewModel.errorResponse.bind { (_) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showErrorAlert()
            }
        }
        viewModel.cachedArticles.bind { (_) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    private func showErrorAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self      = self else { return }
            let errorResponse   = self.viewModel.errorResponse.value
            let title           = errorResponse.code
            let message         = errorResponse.message
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action          = UIAlertAction(title: "ok", style: .default)
            alertController.addAction(action)
            
            self.present(alertController, animated: true, completion: {
                self.viewModel.articles.value.removeAll()
                self.navigationItem.searchController?.searchBar.text = ""
            })
        }
    }
    
    //MARK: - configure UI
    private func configureTableView() {
        tableView.rowHeight     = 180
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.register(NANewsTableViewCell.self, forCellReuseIdentifier: NANewsTableViewCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Поиск новостей"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.hidesSearchBarWhenScrolling              = false
        navigationItem.searchController                         = searchController
    }
    
    private func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Обновляем новости")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        viewModel.createAnotherRequest(page: 1)
        refreshControl?.endRefreshing()
    }
}

// MARK: - Table view data source
extension NANewsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let articles = viewModel.getArticles()
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NANewsTableViewCell.reuseID) as? NANewsTableViewCell else {
            return UITableViewCell()
        }
        let articles = viewModel.getArticles()
        cell.set(article: articles[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articles = viewModel.getArticles()
        let article = articles[indexPath.row]
        handleViewsCounters(article: article, indexPath: indexPath)
        
        coordinator?.showDetailVC(with: article)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let heightOfDisplay = scrollView.frame.size.height
        
        if offsetY > contentHeight - heightOfDisplay, !viewModel.isArticlesFromCache {
            page += 1
            viewModel.createAnotherRequest(page: page)
            tableView.reloadData()
        }
    }
    
    //MARK: - Private
    private func handleViewsCounters(article: NAArticle, indexPath: IndexPath) {
        if !viewModel.cachedArticles.value.contains(article) {
            viewModel.saveInCache(article: article)
        } else {
            if article.viewsCounter == nil {
                viewModel.cachedArticles.value[indexPath.row].viewsCounter = 1
            } else {
                viewModel.cachedArticles.value[indexPath.row].viewsCounter! += 1
            }
            viewModel.saveInCache(article: viewModel.cachedArticles.value[indexPath.row], with: indexPath.row)
        }
    }
}


//MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension NANewsTableViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isArticlesFromCache = true
        viewModel.articles.value.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTitle = searchBar.text else { return }
        viewModel.isArticlesFromCache = false
        viewModel.createRequest(with: searchTitle, page: 1)
    }
}
