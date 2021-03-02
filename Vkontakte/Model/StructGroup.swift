//
//  StructGroup.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import Foundation
import RealmSwift

// MARK: - Response Group
struct ResponseGroup: Codable {
    let response: ItemGroup
}

// MARK: - Items Group
struct ItemGroup: Codable {
    let count: Int
    let items: [VKGroup]
}

// MARK: - Item
class VKGroup: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name, screenName: String
    @objc dynamic var isClosed: Int
    @objc dynamic var type: String
    @objc dynamic var isAdmin, isMember, isAdvertiser: Int
    @objc dynamic var photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}
