//
//  ProductDetailViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

protocol ProductDetailViewModelDelegate: class {
    func openProductCompleteDescription(title: String, descrption: String, url: URL)
}

final class ProductDetailViewModel {
    //MARK: - Private properties
    private let productInfos: ProductModel
    private let imageDownloader: DownloadImageViewModel
    
    //MARK: - Public properties
    weak var delegate: ProductDetailViewModelDelegate?
    
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
        delegate?.openProductCompleteDescription(title: "Warning", descrption: "By tapping on ok you are going to be redirect to an website", url: url)
    }
    
    func downloadImage(completion: @escaping(_ imageData: Data?, _ hasError: Bool) -> Void) {
        guard let url = URL(string: productInfos.thumbnail) else {
            completion(nil, true)
            return
        }
        
        imageDownloader.downloadImage(url: url) { imageData, error in
            guard let imageData = imageData else {
                completion(nil, true)
                return
            }

            completion(imageData, false)
        }
    }
}
