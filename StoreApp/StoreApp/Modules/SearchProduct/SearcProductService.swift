//
//  SearcProductsService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import RxSwift

protocol SearchProductService {
    func search(typedValue: String) -> Observable<ListProductModel>
}

final class SearchProductServiceImpl: SearchProductService {
    
    //MARK: - Private properties
    private let service: Request<SearcProductRequestInfos>
    
    //MARK: - Initialization
    init(service: Request<SearcProductRequestInfos> = Request<SearcProductRequestInfos>()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func search(typedValue: String) -> Observable<ListProductModel> {
        return service.requestObject(model: ListProductModel.self, .search(typedValue))
    }
}
