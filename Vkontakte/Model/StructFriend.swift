//
//  StructFriend.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import Foundation

// MARK: - Response Friend
struct ResponseFriend: Codable {
    let response: ItemFriend
}

// MARK: - Items Friend
struct ItemFriend: Codable {
    let count: Int
    let items: [VKFriend]
}

// MARK: - Item
struct VKFriend: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let sex: Int
    let photo50: String
    let online: Int
    let nickname: String?
    let country: City?
    let city: City?
    let lastSeen: LastSeen?
    let relation: Int?
    let bdate: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case sex
        case photo50 = "photo_50"
        case online, nickname, country
        case lastSeen = "last_seen"
        case city, relation, bdate
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

//// MARK: - LastSeen
struct LastSeen: Codable {
    let platform, time: Int
}

