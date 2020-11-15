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
    
    func showLoading() {
        isUserInteractionEnabled = false
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        addSubviews(views: [activityIndicator])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        guard let activityIndicator = subviews.last as? UIActivityIndicatorView else { return }
        
        isUserInteractionEnabled = true
        activityIndicator.removeFromSuperview()
    }
}
