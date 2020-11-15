//
//  ViewConfiguration.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

protocol ViewConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
    func setupViewConfiguration()
}

extension ViewConfiguration {
    func setupViewConfiguration() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}
