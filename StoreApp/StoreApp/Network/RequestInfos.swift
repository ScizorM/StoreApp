//
//  RequestInfos.swift
//  StoreApp
//
//  Created by Scizor on 14/11/20.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol RequestInfos {
    
    var baseURL: URL { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }

}

public extension RequestInfos {
    var baseURL: URL {
        return URL(string: "https://api.mercadolibre.com/sites/MLA/")!
    }
}
