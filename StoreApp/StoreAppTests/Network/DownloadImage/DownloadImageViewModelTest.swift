//
//  DownloadImageViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
import RxSwift
@testable import StoreApp

final class DownloadImageViewModelTest: XCTestCase {
    private var sut: DownloadImageViewModel!
    private var service: DownloadImageMock!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        service = DownloadImageMock()
        sut = DownloadImageViewModel(service: service)
    }
    
    func testDownloadImageSuccess() {
        service.shouldThrowError = false
        var hasError: Bool = true
        sut.downloadImage(url: URL(string: "google.com")!).subscribe (onNext: { _ in
            hasError = false
        }, onError: { _ in
            hasError = true
        }).disposed(by: disposeBag)

        
        XCTAssertTrue(hasError == false)
        XCTAssertTrue(service.urlSent == "google.com")
    }
    
    func testDownloadImageFailure() {
        service.shouldThrowError = true
        var hasError: Bool = false
        sut.downloadImage(url: URL(string: "google.com")!).subscribe (onNext: { _ in
            hasError = false
        }, onError: { _ in
            hasError = true
        }).disposed(by: disposeBag)
        
        XCTAssertTrue(hasError == true)
    }
}

