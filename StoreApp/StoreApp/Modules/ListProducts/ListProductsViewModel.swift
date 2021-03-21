//
//  ListProductsViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class ListProductsViewModel {
    //MARK: - Private properties
    private var dataSource: ListProductModel
    private let service: ListProductsService
    private let imageDownloader: DownloadImageViewModel
    private let disposeBag = DisposeBag()
    
    private weak var coordinator: ListProductsRedirects?
    
    //MARK: - Initialization
    init(
        dataSource: ListProductModel,
        coordinator: ListProductsRedirects,
        service: ListProductsService = ListProductsServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel()
    ) {
        self.dataSource = dataSource
        self.coordinator = coordinator
        self.service = service
        self.imageDownloader = imageDownloader
    }
    
    //MARK: - Public methods
    func getNumberOfRows() -> Int {
        return dataSource.results.count
    }
    
    func getProductInfos(at index: Int) -> ProductModel {
        return dataSource.results[index]
    }
    
    func downloadImage(at index: Int) -> Observable<Data> {
        guard let url = URL(string: dataSource.results[index].thumbnail) else {
            return Observable.error(NSError())
        }
        
        return imageDownloader.downloadImage(url: url)
    }
    
    func goToProduct(at index: Int) {
        coordinator?.goToProductDetail(viewModel: ProductDetailViewModel(productInfos: dataSource.results[index]))
    }
}
