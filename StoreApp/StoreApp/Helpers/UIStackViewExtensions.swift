//
//  UIStackViewExtensions.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
}
