//
//  ListProductsViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
@testable import StoreApp

private final class ListProductsServiceMock: ListProductsService {
    var shouldThrowError = false
    let successAwnser = ListProductModel(query: "Teste",
                                         paging: PaginationModel(total: 10, offset: 0, limit: 10, primaryResults: 10),
                                         results: [ProductModel(title: "Test product",
                                                                seller: nil,
                                                                price: 1250.0,
                                                                availableQuantity: 10,
                                                                condition: "new",
                                                                url: "teste.com",
                                                                thumbnail: "teste.com",
                                                                acceptMercadoPago: true),
                                                   ProductModel(title: "Test product 2",
                                                                          seller: nil,
                                                                          price: 1250.0,
                                                                          availableQuantity: 10,
                                                                          condition: "new",
                                                                          url: "teste.com",
                                                                          thumbnail: "teste.com",
                                                                          acceptMercadoPago: true),
                                                   ProductModel(title: "Test product 3",
                                                                          seller: nil,
                                                                          price: 1250.0,
                                                                          availableQuantity: 10,
                                                                          condition: "new",
                                                                          url: "teste.com",
                                                                          thumbnail: "teste.com",
                                                                          acceptMercadoPago: true)])
    
    func search(typedValue: String, offset: Int, limit: Int, completion: @escaping (ListProductModel?, Error?) -> Void) {
        shouldThrowError ? completion(nil, NSError()) : completion(successAwnser  , nil)
    }
}

final class ListProductsViewModelTest: XCTestCase {
    private var sut: ListProductsViewModel!
    private var service: ListProductsServiceMock!
    private var imageDownloader: DownloadImageMock!
    
    override func setUp() {
        super.setUp()
        service = ListProductsServiceMock()
        imageDownloader = DownloadImageMock()
        sut = ListProductsViewModel(dataSource: service.successAwnser, service: service, imageDownloader: DownloadImageViewModel(service: imageDownloader))
    }
    

    func testGetNumberOfRows() {
        XCTAssertTrue(sut.getNumberOfRows() == 3)
    }
    
    func testGetProductInfos() {
        XCTAssertTrue(sut.getProductInfos(at: 0).title == "Test product")
    }
    
    func testDownloadImageSuccess() {
        imageDownloader.shouldThrowError = false
        var imageData: Data?
        var erros = 0
        sut.downloadImage(at: 0) { data, hasError in
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
        sut.downloadImage(at: 0) { data, hasError in
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
}

