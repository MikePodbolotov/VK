//
//  StructFriend.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import Foundation
import RealmSwift

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
class VKFriend: Object, Codable {
    @objc dynamic var firstName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var sex: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var nickname: String?
    @objc dynamic var country: City?
    @objc dynamic var city: City?
    @objc dynamic var lastSeen: LastSeen?
//    @objc dynamic var relation: Int
    @objc dynamic var bdate: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case sex
        case photo50 = "photo_50"
        case online, nickname, country
        case lastSeen = "last_seen"
        case city, bdate
//        case relation
    }
    
    // primaryKey - Свойства первичного ключа обеспечивают уникальность для каждого значения при каждом задании свойства
    override class func primaryKey() -> String? {
        "id"
    }
    
    // ignoredProperties - указанные объекты не будут записываться в Realm
    override class func ignoredProperties() -> [String] {
        ["online", "lastSeen"]
    }
    
    // indexedProperties - Возвращает массив имен свойств для свойств, которые должны быть проиндексированы.
//    override class func indexedProperties() -> [String] {
//        <#code#>
//    }
}

// MARK: - City
class City: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
}

// MARK: - LastSeen
class LastSeen: Object, Codable {
    @objc dynamic var platform: Int = 0
    @objc dynamic var time: Int = 0
}

