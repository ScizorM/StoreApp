//
//  DownloadImageMock.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import Foundation
import RxSwift
@testable import StoreApp

final class DownloadImageMock: DownloadImageService {
    var shouldThrowError = false
    var urlSent = ""
    
    func downloadImage(url: URL) -> Observable<Data> {
        urlSent = url.absoluteString
        return shouldThrowError ? Observable.error(NSError()) : Observable.just(Data())
    }
}

