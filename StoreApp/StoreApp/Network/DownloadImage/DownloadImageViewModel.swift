//
//  DownloadImageViewModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

final class DownloadImageViewModel {
    //MARK: - Private properties
    private let service: DownloadImageService
    
    //MARK: - Initialization
    init(service: DownloadImageService = DownloadImageServiceImpl()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        service.downloadImage(url: url) { data, error in
            guard let imageData = data else {
                if let error = error {
                    completion(nil, error)
                }
                return
            }
            
            completion(imageData, nil)
        }
    }
}

