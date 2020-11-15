//
//  RequestInfos.swift
//  StoreApp
//
//  Created by Scizor on 14/11/20.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

protocol RequestInfos {
    
    var baseURL: URL { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }
    
    var parameterEncoding: ParameterEncoding { get }

}

extension RequestInfos {
    var baseURL: URL {
        return URL(string: "https://api.mercadolibre.com/sites/MLA/")!
    }
    
    var parameterEncoding: ParameterEncoding {
        return ParameterEncodingImpl()
    }
}
