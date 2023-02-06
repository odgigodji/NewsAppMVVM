//
//  Coordinator.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 03.02.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
