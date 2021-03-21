//
//  ListProductsService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import RxSwift

protocol ListProductsService {
    func search(typedValue: String, offset: Int, limit: Int) -> Observable<ListProductModel>
}

final class ListProductsServiceImpl: ListProductsService {
    
    //MARK: - Private properties
    private let service: Request<ListProductsRequestInfos>
    
    //MARK: - Initialization
    init(service: Request<ListProductsRequestInfos> = Request<ListProductsRequestInfos>()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func search(typedValue: String, offset: Int, limit: Int) -> Observable<ListProductModel> {
        return service.requestObject(model: ListProductModel.self, .search(typedValue, offset, limit))
    }   
}

