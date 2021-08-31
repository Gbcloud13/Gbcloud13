//
//  AppDelegate.swift
//  ProjectC
//
//  Created by Goutham Basavoju on 8/31/21.
//

import Foundation

// MARK: - CustomModel
struct CustomModel: Codable {
    let data: WelcomeData?
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let children: [Child]?
    
    enum CodingKeys: String, CodingKey {
        case children
    }
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - ChildData
struct ChildData: Codable {
    let title, imageUrl: String?
    let numComments: Int?
    let score: Int?
    let thumbnailWidth, thumbnailHeight: Int?
    
    enum CodingKeys: String, CodingKey {
        case numComments = "num_comments"
        case imageUrl = "url"
        case score, title
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
    }
}
