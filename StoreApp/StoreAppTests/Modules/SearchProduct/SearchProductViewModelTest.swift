//
//  SearchProductViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
@testable import StoreApp

private final class SearchProductServiceMock: SearchProductService {
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
    
    func search(typedValue: String, completion: @escaping (ListProductModel?, Error?) -> Void) {
        shouldThrowError ? completion(nil, NSError()) : completion(successAwnser  , nil)
    }
}

private class SearchProductDelegateMock: SearchProductViewModelDelegate {
    var showProductListCalls = 0
    var showErrorCalls = 0
    
    func showProductList(modelList: ListProductModel) {
        showProductListCalls += 1
    }
    
    func showError(title: String, description: String) {
        showErrorCalls += 1
    }
    
    
}

final class SearchProductViewModelTest: XCTestCase {
    private var sut: SearchProductViewModel!
    private var service: SearchProductServiceMock!
    private var delegate: SearchProductDelegateMock!
    
    override func setUp() {
        super.setUp()
        service = SearchProductServiceMock()
        delegate = SearchProductDelegateMock()
        sut = SearchProductViewModel(service: service)
    }
    
    func testSearchSuccess() {
        service.shouldThrowError = false
        sut.delegate = delegate
        sut.search(product: "")
        XCTAssertTrue(delegate.showErrorCalls == 0)
        XCTAssertTrue(delegate.showProductListCalls == 1)
    }
    
    func testSearchFailure() {
        service.shouldThrowError = true
        sut.delegate = delegate
        sut.search(product: "")
        XCTAssertTrue(delegate.showErrorCalls == 1)
        XCTAssertTrue(delegate.showProductListCalls == 0)
    }
}
