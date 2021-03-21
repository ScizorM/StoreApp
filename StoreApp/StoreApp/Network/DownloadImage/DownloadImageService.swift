//
//  DownloadImageService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift

protocol DownloadImageService {
    func downloadImage(url: URL) -> Observable<Data>
}

final class DownloadImageServiceImpl: DownloadImageService {
    
    //MARK: - Private properties
    private var provider: Request<DownloadImageRequestInfos>
    
    //MARK: - Initialization
    init(provider: Request<DownloadImageRequestInfos> = Request<DownloadImageRequestInfos>()) {
        self.provider = provider
    }
    
    //MARK: - Public methods
    func downloadImage(url: URL) -> Observable<Data> {
        return provider.requestData(target: .getImageWithURL(url))
    }
}



