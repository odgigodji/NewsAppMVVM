//
//  UIView + Ext.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 05.02.23.
//

import UIKit

extension UIView {
    
    /// pin to edge superview
    /// - Parameters:
    ///   - superview: superview
    ///   - padding: padding from edge
    func pinToEdges(of superview: UIView, with padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
   
    
    /// add subviews on superview
    /// - Parameter views: child views
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
