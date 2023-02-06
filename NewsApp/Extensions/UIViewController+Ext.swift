//
//  UIViewController+Ext.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import UIKit

///extension for fast show alert
extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            let action = UIAlertAction(title: "ok", style: .default)
            alertVC.addAction(action)
            self.present(alertVC, animated: true)
        }
    }
}
