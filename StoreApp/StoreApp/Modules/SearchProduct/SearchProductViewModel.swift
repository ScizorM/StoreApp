//
//  SeachProductsViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchProductViewModel {
    // MARK: - Private properties
    private let service: SearchProductService
    private let disposeBag = DisposeBag()
    
    private weak var coordinator: SearchProductRedirects?
    
    // MARK: - Public properties
    let isLoading = PublishRelay<Bool>()
    
    // MARK: - Initialization
    init(service: SearchProductService = SearchProductServiceImpl(), coordinator: SearchProductRedirects) {
        self.service = service
        self.coordinator = coordinator
    }

    // MARK: - Public methods
    func search(product: String) {
        isLoading.accept(true)
        service.search(typedValue: product).observeOn(MainScheduler.instance).subscribe (onNext: { [weak self] productList in
            self?.isLoading.accept(false)
            self?.goToProductList(productList: productList)
        }, onError: { [weak self] _ in
            self?.isLoading.accept(false)
            self?.showError(title: "Sorry =(", description: "We could not find any results with text typed")
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Private methods
    private func goToProductList(productList: ListProductModel) {
        coordinator?.goToListProducts(productList: productList)
    }
    
    private func showError(title: String, description: String) {
        coordinator?.showError(title: title, description: description)
    }
}
