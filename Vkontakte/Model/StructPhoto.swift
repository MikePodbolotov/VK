//
//  StructPhoto.swift
//  Vkontakte
//
//  Created by Михаил Подболотов on 28.02.2021.
//

import Foundation

// MARK: - Response Photo
struct ResponsePhoto: Codable {
    let response: ItemPhoto
}

// MARK: - Items Photo
struct ItemPhoto: Codable {
    let count: Int
    let items: [VKPhoto]
}

// MARK: - Item
struct VKPhoto: Codable {
    let id, ownerID: Int
//    let albumID, userID: Int
    let sizes: [Size]
    let text: String
    let date: Int

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
//        case albumID = "album_id"
//        case userID = "user_id"
        case sizes, text
        case date
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}
