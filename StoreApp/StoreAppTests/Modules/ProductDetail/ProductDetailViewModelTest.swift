//
//  ProductDetailViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
import RxSwift
@testable import StoreApp

final class ProductDetailViewModelTest: XCTestCase {
    private var sut: ProductDetailViewModel!
    private var imageDownloader: DownloadImageMock!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        imageDownloader = DownloadImageMock()
        sut = ProductDetailViewModel(productInfos: ProductModel(title: "Test product",
                                                                seller: nil,
                                                                price: 1250.0,
                                                                availableQuantity: 10,
                                                                condition: "new",
                                                                url: "teste.com",
                                                                thumbnail: "teste.com",
                                                                acceptMercadoPago: true),
                                     imageDownloader: DownloadImageViewModel(service: imageDownloader))
    }
    
    func testFeedView() {
        XCTAssertTrue(sut.feedView().title == "Test product")
    }
    
    func testDownloadImageSuccess() {
        imageDownloader.shouldThrowError = false
        var imageData: Data?
        var erros = 0
        
        sut.getImage.subscribe (onNext: { data, hasError in
            imageData = data
        }, onError: { _ in
            erros += 1
        }).disposed(by: disposeBag)
        
        sut.downloadImage()
        
        XCTAssertTrue(imageData != nil)
        XCTAssertTrue(erros == 0)
    }
    
    func testDownloadImageFailure() {
        imageDownloader.shouldThrowError = true
        var imageData: Data?
        var erros = 0
        
        sut.getImage.subscribe (onNext: { data, hasError in
            if hasError { erros += 1 }
            imageData = data
        }).disposed(by: disposeBag)
        
        sut.downloadImage()
        
        
        XCTAssertTrue(imageData == nil)
        XCTAssertTrue(erros == 1)
    }
    
    func testOpenProductCompleteDescription() {
        var openProductCompleteDescriptionCalls = 0
        
        sut.tapOnCompleteDescription.subscribe (onNext: { _, _, _ in
            openProductCompleteDescriptionCalls += 1
        }).disposed(by: disposeBag)
        
        sut.openProductCompleteDescription()
        XCTAssertTrue(openProductCompleteDescriptionCalls == 1)
    }
}

