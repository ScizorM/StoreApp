//
//  ProductDetailController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit
import RxSwift

final class ProductDetailController: UIViewController {
    //MARK: - Private properties
    private let customView = ProductDetailView()
    private let disposeBag = DisposeBag()
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
        customView.setupView(with: viewModel.feedView())
        viewModel.downloadImage()
        bindViewModel()
        bindCustomView()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Product Detail"
    }
    
    private func bindViewModel() {
        viewModel.getImage.observeOn(MainScheduler.instance).subscribe (onNext: { [weak self] imageData, hasError in
            self?.customView.setupImage(image: imageData, hasError: hasError)
        }).disposed(by: disposeBag)
        
        viewModel.tapOnCompleteDescription.observeOn(MainScheduler.instance).subscribe (onNext: { [weak self] title, description, url in
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
                UIApplication.shared.open(url)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
            alert.addAction(alertAction)
            alert.addAction(cancelAction)
            self?.navigationController?.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    private func bindCustomView() {
        customView.submitButton.rx.tap.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            self?.viewModel.openProductCompleteDescription()
        }).disposed(by: disposeBag)
    }
}
