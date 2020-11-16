//
//  ProductDetailController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

final class ProductDetailController: UIViewController {
    //MARK: - Private properties
    private let customView = ProductDetailView()
    private let viewModel: ProductDetailViewModel
    
    //MARK: -  Initialization
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cycle view
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegates()
        customView.setupView(with: viewModel.feedView())
        viewModel.downloadImage { [weak self] imageDate, hasError in
            DispatchQueue.main.async {
                self?.customView.setupImage(image: imageDate, hasError: hasError)
            }
        }
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Product Detail"
    }

    private func setupDelegates() {
        customView.delegate = self
        viewModel.delegate = self
    }
}

//MARK: - ProductDetailViewDelegate
extension ProductDetailController: ProductDetailViewDelegate {
    func didTapOnSubmitButton() {
        viewModel.openProductCompleteDescription()
    }
}

//MARK: - ProductDetailViewModelDelegate
extension ProductDetailController: ProductDetailViewModelDelegate {
    func openProductCompleteDescription(title: String, descrption: String, url: URL) {
        let alert = UIAlertController(title: title, message: descrption, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            UIApplication.shared.open(url)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
