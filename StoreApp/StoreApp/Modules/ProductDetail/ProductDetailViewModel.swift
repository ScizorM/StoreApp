//
//  ProductDetailViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductDetailViewModel {
    //MARK: - Private properties
    private let productInfos: ProductModel
    private let imageDownloader: DownloadImageViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - Public properties
    let tapOnCompleteDescription = PublishRelay<(title: String, description: String, url: URL)>()
    let getImage = PublishRelay<(imageData: Data?, hasError: Bool)>()
    
    //MARK: - Initialization
    init(productInfos: ProductModel, imageDownloader: DownloadImageViewModel = DownloadImageViewModel()) {
        self.productInfos = productInfos
        self.imageDownloader = imageDownloader
    }
    
    //MARK: - Public methods
    func feedView() -> ProductModel {
        return productInfos
    }
    
    func openProductCompleteDescription() {
        guard let url = URL(string: productInfos.url) else { return }
        tapOnCompleteDescription.accept((title: "Warning", description: "By tapping on ok you are going to be redirect to an website", url: url))
    }
    
    func downloadImage() {
        guard let url = URL(string: productInfos.thumbnail) else {
            getImage.accept((imageData: nil, hasError: true))
            return
        }
        
        imageDownloader.downloadImage(url: url).subscribe (onNext: { [weak self] data in
            self?.getImage.accept((imageData: data, hasError: false))
        }, onError: { [weak self] _ in
            self?.getImage.accept((imageData: nil, hasError: true))
        }).disposed(by: disposeBag)

    }
}
