//
//  ListProductsCoordinator.swift
//  StoreApp
//
//  Created by Matheus Leandro Martins on 12/03/21.
//

import UIKit

protocol ListProductsRedirects: class {
    func goToProductDetail(viewModel: ProductDetailViewModel)
}

final class ListProductsCoordinator: BaseCoordinator {
    // MARK: - Private properties
    private let navigationController: UINavigationController
    private var controller: ListProductsController?
    
    // MARK: - Initialization
    init(navigationController: UINavigationController, dataSource: ListProductModel) {
        self.navigationController = navigationController
        super.init()
        self.controller = ListProductsController(viewModel: ListProductsViewModel(dataSource: dataSource, coordinator: self))
    }
    
    // MARK: - Overrides
    override func start() {
        guard let controller = controller else { return }
        self.rootViewController = controller
        navigationController.pushViewController(controller, animated: true)
    }
}

// MARK: - ListProductsRedirects
extension ListProductsCoordinator: ListProductsRedirects {
    func goToProductDetail(viewModel: ProductDetailViewModel) {
        let detailController = ProductDetailController(viewModel: viewModel)
        navigationController.pushViewController(detailController, animated: true)
    }
}

