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
class VKPhoto: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var likes: Likes?
    @objc dynamic var text: String = ""
    @objc dynamic var date: Int = 0
//    let albumID, userID: Int
    
    var sizes = List<Size>()

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case likes
        case sizes, text
        case date
//        case albumID = "album_id"
//        case userID = "user_id"
    }
}

// MARK: - Likes
class Likes: Object, Codable {
    @objc dynamic var userLikes: Int = 0
    @objc dynamic var count: Int = 0

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
}
