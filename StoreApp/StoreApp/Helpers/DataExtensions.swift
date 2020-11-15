//
//  DataExtensions.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

extension Data {
    //MARK: - Support method, to debug requests
    func mapToJSON() throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: [])
        } catch {
            fatalError()
        }
    }
}

