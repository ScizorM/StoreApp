//
//  SearcProductRequestInfos.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

enum SearcProductRequestInfos {
    case search(String)
}

extension SearcProductRequestInfos: RequestInfos {
    var endpoint: String {
        switch self {
        case .search(let typedValue): return "search?q=\(typedValue)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
