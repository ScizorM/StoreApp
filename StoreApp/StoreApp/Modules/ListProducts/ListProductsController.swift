//
//  ListProductsController.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit
import RxSwift

final class ListProductsController: BaseViewController {
    //MARK: - Private properties
    private let viewModel: ListProductsViewModel
    private let disposeBag = DisposeBag()
    private lazy var customView = ListProductsView(delegate: self, dataSource: self)
    
    //MARK: - Inititalization
    init(viewModel: ListProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        customView.reloadData()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search Results"
    }
}

//MARK: - UITableViewDelegate
extension ListProductsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToProduct(at: indexPath.row)
    }
}

//MARK: - UITableViewDataSource
extension ListProductsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier) as? ProductCell else { return UITableViewCell() }
        cell.setupInfos(with: viewModel.getProductInfos(at: indexPath.row))
        viewModel.downloadImage(at: indexPath.row).observeOn(MainScheduler.instance).subscribe (onNext: { imageData in
            cell.setupImage(image: imageData, hasError: false)
        }, onError: { (_) in
            cell.setupImage(image: nil, hasError: true)
        }).disposed(by: disposeBag)
    
        return cell
    }
}
