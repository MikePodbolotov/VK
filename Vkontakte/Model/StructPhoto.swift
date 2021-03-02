//
//  StructPhoto.swift
//  Vkontakte
//
//  Created by Михаил Подболотов on 28.02.2021.
//

import Foundation
import RealmSwift

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
    let likes: Likes
    let sizes: [Size]
    let text: String
    let date: Int

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case likes
//        case albumID = "album_id"
//        case userID = "user_id"
        case sizes, text
        case date
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct Size: Codable {
    let type: String
    let url: String
    let width, height: Int
}
