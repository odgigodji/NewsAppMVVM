//
//  NADetailView.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import UIKit

/// Passive View for NADetailViewController
final class NADetailView: UIView {
    
    private var articleImageView = NAImageView(frame: .zero)
    private var titleLabel = UILabel(frame: .zero)
    private var descriptionLabel = UILabel(frame: .zero)
    private var sourceLabel = UILabel(frame: .zero)
    private var dateLabel = UILabel(frame: .zero)
    
    var topStackView = UIStackView(frame: .zero)
    var bottomStackView = UIStackView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        
        let padding = CGFloat(10)
        configureLabels()
        configureBottomStack(padding: padding)
        configureTopStackView(padding: padding)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// set all titles and ImageView
    /// - Parameter article: article for detail View
    func set(article: NAArticle) {
        if let urlToImage = article.urlToImage {
            articleImageView.viewModel.downloadImage(fromUrl: urlToImage)
        }
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        sourceLabel.text = "Источник: \(article.source.name)"
        dateLabel.text = "Опубликовано: \(formate(string: article.publishedAt))"
    }
    
    //MARK: - Private
    
    private func formate(string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let yourDate = formatter.date(from: string)
        formatter.dateFormat = "dd.MM.yyyy в HH:mm"
        formatter.locale     = Locale(identifier: "ru")
        formatter.timeZone   = .current

        guard let date = yourDate else { return "" }
        return formatter.string(from: date)
    }
    
    private func configureTopStackView(padding: CGFloat) {
        addSubview(topStackView)
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.axis          = .vertical
        topStackView.distribution  = .fill
        topStackView.spacing       = 3
        
        topStackView.addArrangedSubview(articleImageView)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(descriptionLabel)
       
        NSLayoutConstraint.activate([
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
            topStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: padding),
            topStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            topStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            topStackView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -padding)
        ])
    }
    
    private func configureBottomStack(padding: CGFloat) {
        addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomStackView.axis = .vertical
        bottomStackView.distribution  = .fill
        bottomStackView.spacing       = 3
        
        bottomStackView.addArrangedSubview(dateLabel)
        bottomStackView.addArrangedSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            bottomStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
    }
    
    private func configureLabels() {
        titleLabel.numberOfLines = 3
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        descriptionLabel.contentMode = .scaleToFill
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        
        sourceLabel.textColor = .gray
        sourceLabel.contentMode = .scaleAspectFill
        
        dateLabel.textColor = .gray
        dateLabel.contentMode = .scaleAspectFill
    }
}
