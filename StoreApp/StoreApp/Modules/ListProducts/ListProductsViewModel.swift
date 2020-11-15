//
//  ListProductsViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

final class ListProductsViewModel {
    //MARK: - Private properties
    private var dataSource: ListProductModel
    private let service: ListProductsService
    private let imageDownloader: DownloadImageViewModel
    
    //MARK: - Initialization
    init(
        dataSource: ListProductModel,
        service: ListProductsService = ListProductsServiceImpl(),
        imageDownloader: DownloadImageViewModel = DownloadImageViewModel()
    ) {
        self.dataSource = dataSource
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
    
    func downloadImage(at index: Int, completion: @escaping(_ imageData: Data?, _ hasError: Bool) -> Void) {
        guard let url = URL(string: dataSource.results[index].thumbnail) else {
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
