//
//  DownloadImageService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

protocol DownloadImageService {
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

final class DownloadImageServiceImpl: DownloadImageService {
    
    //MARK: - Private properties
    private var provider: Request<DownloadImageRequestInfos>
    
    //MARK: - Initialization
    init(provider: Request<DownloadImageRequestInfos> = Request<DownloadImageRequestInfos>()) {
        self.provider = provider
    }
    
    //MARK: - Public methods
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        provider.requestData(target: .getImageWithURL(url)) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
    }
}



