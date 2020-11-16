//
//  ProductDetailViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
@testable import StoreApp

private class ProductDetailViewModelDelegateMock: ProductDetailViewModelDelegate {
    var openProductCompleteDescriptionCalls = 0
    
    func openProductCompleteDescription(title: String, descrption: String, url: URL) {
        openProductCompleteDescriptionCalls += 1
    }
    
    
}

final class ProductDetailViewModelTest: XCTestCase {
    private var sut: ProductDetailViewModel!
    private var imageDownloader: DownloadImageMock!
    private var delegate: ProductDetailViewModelDelegateMock!
    
    override func setUp() {
        super.setUp()
        imageDownloader = DownloadImageMock()
        delegate = ProductDetailViewModelDelegateMock()
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
        sut.downloadImage() { data, hasError in
            if let data = data {
                imageData = data
            }
            
            if hasError {
                erros += 1
            }
        }
        
        XCTAssertTrue(imageData != nil)
        XCTAssertTrue(erros == 0)
    }
    
    func testDownloadImageFailure() {
        imageDownloader.shouldThrowError = true
        var imageData: Data?
        var erros = 0
        sut.downloadImage() { data, hasError in
            if let data = data {
                imageData = data
            }
            
            if hasError {
                erros += 1
            }
        }
        
        XCTAssertTrue(imageData == nil)
        XCTAssertTrue(erros == 1)
    }
    
    func testOpenProductCompleteDescription() {
        sut.delegate = delegate
        sut.openProductCompleteDescription()
        XCTAssertTrue(delegate.openProductCompleteDescriptionCalls == 1)
    }
}

