//
//  StructFriend.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import Foundation
import SwiftyJSON

// MARK: - Friend
class Friend {
    let firstName: String
//    let id: Int
    let lastName: String
//    let canAccessClosed, isClosed: Bool
//    let sex: Int
//    let photo50: String
    let online: Int
//    let nickname, domain: String
//    let country, city: String
//    let lastSeen: Int
//    let trackCode: String
//    let relation: Int?
//    let bdate: String?
    let avatar: String?

    
    init(from json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.online = json["online"].intValue
        self.avatar = ""
    }
    
}

//struct Friend {
//    var name: String
//    var lastName: String
//    var age: UInt8
//    var avatar: String //путь до картинки
//}
