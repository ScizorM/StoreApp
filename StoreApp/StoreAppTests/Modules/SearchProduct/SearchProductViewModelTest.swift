//
//  SearchProductViewModelTest.swift
//  StoreAppTests
//
//  Created by Scizor on 15/11/20.
//

import XCTest
import Foundation
import RxSwift
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
    
    func search(typedValue: String) -> Observable<ListProductModel> {
        return shouldThrowError ? Observable.error(NSError()) : Observable.just(successAwnser)
    }
}

private final class SearchProductCoordinatorMock: SearchProductRedirects {
    var goToListProductsCalls = 0
    var showErrorCalls = 0
    func goToListProducts(productList: ListProductModel) {
        goToListProductsCalls += 1
    }
    
    func showError(title: String, description: String) {
        showErrorCalls += 1
    }
    
    
}

final class SearchProductViewModelTest: XCTestCase {
    private var sut: SearchProductViewModel!
    private var service: SearchProductServiceMock!
    private var coordinator: SearchProductCoordinatorMock!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        service = SearchProductServiceMock()
        coordinator = SearchProductCoordinatorMock()
        sut = SearchProductViewModel(service: service, coordinator: coordinator)
    }
    
    func testSearchSuccess() {
        service.shouldThrowError = false
        var isLoadingCalls = 0
        
        sut.isLoading.subscribe ({ _ in
            isLoadingCalls += 1
        }).disposed(by: disposeBag)

        sut.search(product: "")
        
        XCTAssertTrue(coordinator.showErrorCalls == 0)
        XCTAssertTrue(coordinator.goToListProductsCalls == 1)
        XCTAssertTrue(isLoadingCalls == 2)
    }
    
    func testSearchFailure() {
        service.shouldThrowError = true
        var isLoadingCalls = 0
        
        sut.isLoading.subscribe ({ _ in
            isLoadingCalls += 1
        }).disposed(by: disposeBag)
        
        sut.search(product: "")
        
        XCTAssertTrue(coordinator.showErrorCalls == 1)
        XCTAssertTrue(coordinator.goToListProductsCalls == 0)
        XCTAssertTrue(isLoadingCalls == 2)
    }
}
