//
//  DownloadImageRequestInfos.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

enum DownloadImageRequestInfos {
    case getImageWithURL(URL)
}

//MARK: - TargetType
extension DownloadImageRequestInfos: RequestInfos {
    var endpoint: String {
        return ""
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var baseURL: URL {
        switch self {
        case .getImageWithURL(let url): return url
        }
    }
}

