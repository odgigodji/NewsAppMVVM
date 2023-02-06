//
//  NAImageViewModel.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import UIKit


/// protocol for imageviewmodel
protocol NAImageViewModelObservable {
    var image: Dynamic<UIImage?> { get  set }
    func downloadImage(fromUrl url: String)
}

final class NAImageViewModel: NAImageViewModelObservable {
    
    var image: Dynamic<UIImage?> = Dynamic(Images.newspaper)
    
    func downloadImage(fromUrl url: String) {
        ImageManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image.value = image
            }
        }
    }
}
