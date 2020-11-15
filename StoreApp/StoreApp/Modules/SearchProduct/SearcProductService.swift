//
//  SearcProductsService.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

protocol SearchProductService {
    func search(typedValue: String, completion: @escaping (ListProductModel?, Error?) -> Void)
}

final class SearchProductServiceImpl: SearchProductService {
    
    //MARK: - Private properties
    private let service: Request<SearcProductRequestInfos>
    
    //MARK: - Initialization
    init(service: Request<SearcProductRequestInfos> = Request<SearcProductRequestInfos>()) {
        self.service = service
    }
    
    //MARK: - Public methods
    func search(typedValue: String, completion: @escaping (ListProductModel?, Error?) -> Void) {
        return service.requestObject(model: ListProductModel.self, .search(typedValue)) { modelList, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(modelList, nil)
            }
        }
    }
}
