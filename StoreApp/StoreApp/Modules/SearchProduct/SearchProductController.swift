//
//  SearchProductController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

final class SearchProductController: UIViewController {
    // MARK: - Private propertie
    private let viewModel: SearchProductViewModel
    private lazy var customView = SearchProductView(delegate: self)
    
    // MARK: - Initialization
    init(viewModel: SearchProductViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModel.delegate = self
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
    }
}
                                     
// MARK: - SearchProductViewDelegatex
extension SearchProductController: SearchProductViewDelegate {
    func didTapOnSubmit(typedValue: String) {
        viewModel.search(product: typedValue)
    }
}

extension SearchProductController: SearchProductViewModelDelegate {
    func showProductList(modelList: ListProductModel) {
        DispatchQueue.main.async { [weak self] in
            let listController = ListProductsController(viewModel: ListProductsViewModel(dataSource: modelList))
            self?.navigationController?.pushViewController(listController, animated: true)
        }
    }
    
    func showError(title: String, description: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
            alert.addAction(alertAction)
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
