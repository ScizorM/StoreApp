//
//  UIButtonExtensions.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

extension UIButton {
    func showLoading() {
        isUserInteractionEnabled = false
        titleLabel?.layer.opacity = 0.0
        let activityIndicator = UIActivityIndicatorView(style: .white)
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
        titleLabel?.layer.opacity = 1.0
    }

}
