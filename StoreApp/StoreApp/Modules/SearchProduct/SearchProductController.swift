//
//  SearchProductController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit
import RxSwift

final class SearchProductController: BaseViewController {
    // MARK: - Private propertie
    private let viewModel: SearchProductViewModel
    private let disposeBag = DisposeBag()
    private lazy var customView = SearchProductView()
    
    
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
        bindViewModel()
        bindCustomView()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
    }
    
    private func bindViewModel() {
        viewModel.isLoading.observeOn(MainScheduler.instance).subscribe (onNext: { [weak self] isLoading in
            self?.customView.handleLoading(isLoading: isLoading)
        }).disposed(by: disposeBag)
    }
    
    private func bindCustomView() {
        customView.submitButton.rx.tap.observeOn(MainScheduler.instance).subscribe ({ [weak self] _ in
            guard let text = self?.customView.searchTextField.text else { return }
            self?.viewModel.search(product: text)
        }).disposed(by: disposeBag)
    }
}

