//
//  SearchProductCoordinator.swift
//  StoreApp
//
//  Created by Matheus Leandro Martins on 12/03/21.
//

import UIKit

protocol SearchProductRedirects: class {
    func goToListProducts(productList: ListProductModel)
    func showError(title: String, description: String)
}

final class SearchProductCoordinator: BaseCoordinator {
    // MARK: - Private properties
    private let navigationController: UINavigationController
    private lazy var controller = SearchProductController(viewModel: SearchProductViewModel(coordinator: self))
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Overrides
    override func start() {
        self.rootViewController = controller
        navigationController.setViewControllers([controller], animated: true)
    }
}

extension SearchProductCoordinator: SearchProductRedirects {
    func goToListProducts(productList: ListProductModel) {
        let productListCoordinator = ListProductsCoordinator(navigationController: navigationController, dataSource: productList)
        coordinate(to: productListCoordinator, parent: self)
    }
    
    func showError(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
        alert.addAction(alertAction)
        navigationController.present(alert, animated: true, completion: nil)
    }
}
