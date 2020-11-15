//
//  ListProductModel.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import Foundation

struct ListProductModel: Codable {
    let query: String
    let paging: PaginationModel
    let results: [ProductModel]?
}

struct PaginationModel: Codable {
    let total: Int
    let offset: Int
    let limit: Int
    let primaryResults: Int
    
    enum CodingKeys: String, CodingKey {
        case total
        case offset
        case limit
        case primaryResults = "primary_results"
    }
}

struct ProductModel: Codable {
    let title: String
    let seller: SellerModel?
    let price: Double
    let availableQuantity: Int
    let condition: String
    let url: String
    let thumbnail: String
    let acceptMercadoPago: Bool
    
    enum CodingKeys: String, CodingKey {
        case title
        case seller
        case price
        case availableQuantity = "available_quantity"
        case condition
        case url = "permalink"
        case thumbnail
        case acceptMercadoPago = "accepts_mercadopago"
    }
}

struct SellerModel: Codable {
    let sellerStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case sellerStatus = "power_seller_status"
    }
}
