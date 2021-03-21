//
//  DownloadImageViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift

final class DownloadImageViewModel {
    //MARK: - Private properties
    private let service: DownloadImageService
    
    //MARK: - Initialization
    init(service: DownloadImageService = DownloadImageServiceImpl()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func downloadImage(url: URL) -> Observable<Data> {
        return service.downloadImage(url: url)
    }
}

