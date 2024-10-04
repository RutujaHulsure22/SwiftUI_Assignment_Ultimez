//
//  Product.swift
//  SwiftUI_Assignment_Ultimez
//
//  Created by Coditas on 02/10/24.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let price: String
    let name: String
    let createdAt: String 
    let imageIDs: [String]
    let imageURLs: [String]
    let imageURLsThumbnails: [String]

    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case price
        case name
        case createdAt = "created_at"
        case imageIDs = "image_ids"
        case imageURLs = "image_urls"
        case imageURLsThumbnails = "image_urls_thumbnails"
    }
}

