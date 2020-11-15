//
//  UIViewExtensions.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
