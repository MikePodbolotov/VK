//
//  NetworkService.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 31.01.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
//    static let shared = NetworkService()
//    
//    private init() {
//        
//    }
    
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
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print("------- ГРУППЫ -------")
            print(json)
        }
    }
    
    static func loadFriends(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token": token,
            "order": "name",    //order - порядок, в котором нужно вернуть список друзей
            "count": 25,         //count - количество друзей, которое нужно вернуть
            "fields": "nickname, domain, sex, bdate, city, country, online, last_seen, relation, photo_50",  //fields - список дополнительных полей, которые необходимо вернуть.
//            name_case - падеж для склонения имени и фамилии пользователя
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print("------- ДРУЗЬЯ -------")
            print(json)
        }
    }
    
    static func loadPhotos(token: String, owner_id: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token": token,
            "owner_id": owner_id,   //owner_id - идентификатор пользователя или сообщества, фотографии которого нужно получить.
            "extended": 0,          //extended - 1 — возвращать расширенную информацию о фотографиях
            "count": 25,            //count - число фотографий, информацию о которых необходимо получить.
            "photo_sizes": 1,       //photo_sizes - 1 — будут возвращены размеры фотографий в специальном формате
            "skip_hidden": 1,       //skip_hidden - 1 — не возвращать фотографии, скрытые из блока над стеной пользователя (параметр учитывается только при owner_id > 0, параметр no_service_albums игнорируется).
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print("------- ФОТО -------")
            print(json)
        }
    }
    
    static func searchGroup(token: String, query: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        let params: Parameters = [
            "access_token": token,
            "q": query,         //q - текст поискового запроса.
            "type": "group",    //type - тип сообщества. Возможные значения: group, page, eventх
//            "country_id": 25,   //country_id - идентификатор страны. Положительное число
//            "city_id": 1,       //city_id - идентификатор города. При передаче этого параметра поле country_id игнорируется. Положительное число
            "sort": 1,          //sort - целое число от 0 до 5 (0 — сортировать по умолчанию)
            "count": 10,        //count - количество результатов поиска, которое необходимо вернуть.
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            guard let json = response.value else { return }
            print("------- ПОИСК ГРУПП -------")
            print(json)
        }
    }
}
