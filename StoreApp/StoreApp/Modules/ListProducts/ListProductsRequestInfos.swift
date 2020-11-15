//
//  ListProductsRequestInfos.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

enum ListProductsRequestInfos {
    case search(String, Int, Int)
}

extension ListProductsRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .search(let typedValue, _, _): return "search?q=\(typedValue)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .search(_, let offset, let limit): return [
            "offset" : offset,
            "limit" : limit
        ]
        }
    }
}
