//
//  SeachProductsViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

protocol SearchProductViewModelDelegate: class {
    func showProductList(modelList: ListProductModel)
    func showError(title: String, description: String)
    func isLoading(shouldShowLoading: Bool)
}

final class SearchProductViewModel {
    // MARK: - Private properties
    private let service: SearchProductService
    
    // MARK: - Public properties
    weak var delegate: SearchProductViewModelDelegate?
    
    // MARK: - Initialization
    init(service: SearchProductService = SearchProductServiceImpl()) {
        self.service = service
    }
    
    func search(product: String) {
        delegate?.isLoading(shouldShowLoading: true)
        service.search(typedValue: product) { [weak self] modelList, error in
            guard let modelList = modelList else {
                self?.delegate?.isLoading(shouldShowLoading: false)
                self?.delegate?.showError(title: "Sorry =(", description: "We could not find any results with text typed")
                return
            }
            self?.delegate?.isLoading(shouldShowLoading: false)
            self?.delegate?.showProductList(modelList: modelList)
        }
    }
}
