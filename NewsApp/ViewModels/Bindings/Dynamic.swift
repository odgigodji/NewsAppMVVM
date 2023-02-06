//
//  Dynamic.swift
//  NewsApp
//
//  Created by Nikita Evdokimov on 04.02.23.
//

import Foundation


/// Custom type for connect viewModel and View
class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}

