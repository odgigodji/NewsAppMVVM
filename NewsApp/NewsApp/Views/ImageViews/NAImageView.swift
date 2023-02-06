//
//  NAImageView.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 04.02.23.
//

import UIKit


/// custom class for imageView
final class NAImageView: UIImageView {
    
    var viewModel = NAImageViewModel()

    let placeholderImage    = Images.newspaper
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// connect NAImageView and NAImageViewModel
    func bindViewModel() {
        viewModel.image.bind { image in
            self.image = image
        }
        configure()
    }
    
    
    /// configure image
    private func configure() {
        layer.cornerRadius  = 10
        contentMode         = .scaleAspectFill
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
