//
//  ListProductsService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

protocol ListProductsService {
    func search(typedValue: String, offset: Int, limit: Int, completion: @escaping (ListProductModel?, Error?) -> Void)
}

final class ListProductsServiceImpl: ListProductsService {
    
    //MARK: - Private properties
    private let service: Request<ListProductsRequestInfos>
    
    //MARK: - Initialization
    init(service: Request<ListProductsRequestInfos> = Request<ListProductsRequestInfos>()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func search(typedValue: String, offset: Int, limit: Int, completion: @escaping (ListProductModel?, Error?) -> Void) {
        return service.requestObject(model: ListProductModel.self, .search(typedValue, offset, limit)) { modelList, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(modelList, nil)
            }
        }
    }
}

