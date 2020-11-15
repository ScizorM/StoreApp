//
//  SearchProductController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

final class SearchProductController: UIViewController {
    // MARK: - Private propertie
    private lazy var customView = SearchProductView(delegate: self)
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
    }
}
                                     
// MARK: - SearchProductViewDelegate
extension SearchProductController: SearchProductViewDelegate {
    func didTapOnSubmit(typedValue: String) {
        print(typedValue)
    }
}
