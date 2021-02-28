//
//  StructGroup.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import Foundation

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
struct VKGroup: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

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
