//
//  NetworkService.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 31.01.2021.
//

import Foundation

class NetworkService {
    func getFriends() -> [Friend] {
        return [
            Friend(name: "Иван", lastName: "Иванов", age: 38, avatar: "avatar_1"),
            Friend(name: "Денис", lastName: "Иванов", age: 16, avatar: ""),
            Friend(name: "Мария", lastName: "Иванова", age: 8, avatar: ""),
            Friend(name: "Елена", lastName: "Иванова", age: 38, avatar: ""),
            Friend(name: "Петр", lastName: "Петров", age: 30, avatar: "avatar_2"),
            Friend(name: "Дмитрий", lastName: "Петухов", age: 20, avatar: ""),
            Friend(name: "Евгений", lastName: "Попов", age: 40, avatar: ""),
            Friend(name: "Евгений", lastName: "Павлов", age: 35, avatar: ""),
            Friend(name: "Дон", lastName: "Пончик", age: 30, avatar: ""),
            Friend(name: "Артем", lastName: "Кузнецов", age: 35, avatar: "avatar_4"),
            Friend(name: "Денис", lastName: "Сидоров", age: 36, avatar: ""),
            Friend(name: "Оксана", lastName: "Сидорова", age: 26, avatar: ""),
            Friend(name: "Денис", lastName: "Смирнов", age: 46, avatar: ""),
            Friend(name: "Ольга", lastName: "Смирнова", age: 46, avatar: ""),
            Friend(name: "Майкл", lastName: "Медведь", age: 36, avatar: ""),
            Friend(name: "Лариса", lastName: "Лиса", age: 27, avatar: "avatar_3"),
            Friend(name: "Ли", lastName: "Дьенк", age: 40, avatar: ""),
            Friend(name: "Ким", lastName: "Цой", age: 35, avatar: "avatar_4"),
            Friend(name: "Анита", lastName: "Цой", age: 36, avatar: ""),
            Friend(name: "Жан", lastName: "Кристоф", age: 26, avatar: ""),
            Friend(name: "Дункан", lastName: "Маклауд", age: 46, avatar: ""),
            Friend(name: "Ольга", lastName: "Лалетина", age: 46, avatar: ""),
            Friend(name: "Марина", lastName: "Гончар", age: 36, avatar: ""),
            Friend(name: "Павел", lastName: "Гончар", age: 27, avatar: "avatar_3")]
    }
    
    static func loadGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
//        let params: Parameters [
//        "access_token": token,
//        "extended": 1,
//        "v": "5.124"]
        
    }
}
