//
//  DownloadImageMock.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import Foundation
@testable import StoreApp

final class DownloadImageMock: DownloadImageService {
    var shouldThrowError = false
    var urlSent = ""
    
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        urlSent = url.absoluteString
        shouldThrowError ? completion(nil, NSError()) : completion(Data(), nil)
    }
}

