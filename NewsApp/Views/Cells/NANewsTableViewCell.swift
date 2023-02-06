//
//  NANewsTableViewCell.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 04.02.23.
//

import UIKit

final class NANewsTableViewCell: UITableViewCell {

    static let reuseID      = "NANewsTableViewCell"
    
    let articleImageView    = NAImageView(frame: .zero)
    let titleLabel          = UILabel(frame: .zero)
    let viewsCounterLabel   = UILabel(frame: .zero)
    
    var article : NAArticle?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set all views on cell
    /// - Parameter article: article from current cell
    func set(article: NAArticle) {
        if let urlToImage = article.urlToImage {
            articleImageView.viewModel.downloadImage(fromUrl: urlToImage)
        }
        titleLabel.text = article.title
        viewsCounterLabel.text = "Переходы: \(article.viewsCounter ?? 0)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
      }
    
    
    //MARK: - Private
    /// configure all UIElement
    private func configureUI() {
        let padding = CGFloat(10)
        
        configureImage(padding: padding)
        configureViewsCounterLabel(padding: padding)
        configureTitleLabel(padding: padding)
    }
    
    private func configureImage(padding: CGFloat) {
        addSubview(articleImageView)
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo:topAnchor, constant: padding),
            articleImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            articleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor)
        ])
    }
    
    private func configureViewsCounterLabel(padding: CGFloat) {
        addSubview(viewsCounterLabel)
        viewsCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        viewsCounterLabel.textColor = UIColor.gray
        
        NSLayoutConstraint.activate([
            viewsCounterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            viewsCounterLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureTitleLabel(padding: CGFloat) {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 4
        titleLabel.contentMode = .top
        titleLabel.font = UIFont.systemFont(ofSize: 18)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding + 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }

}
