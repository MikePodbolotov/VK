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
    
        static let shared = NetworkService()
    
        private init() {
    
        }
    
    // MARK: - loadGroups
    static func loadGroups(token: String, completion: @escaping (_ group: ResponseGroup) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token": token,
            "extended": 1,  //если указать в качестве этого параметра 1, то будет возвращена полная информация о группах пользователя. По умолчанию 0.
//            "count": 150,    //count - количество сообществ, информацию о которых нужно вернуть
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in

            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                    let groupResponse = try JSONDecoder().decode(ResponseGroup.self, from: data)
                    completion(groupResponse)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - loadGroupsSimple
//    static func loadGroupsSimple(token: String) {
//        let baseURL = "https://api.vk.com"
//        let path = "/method/groups.get"
//        let params: Parameters = [
//            "access_token": token,
//            "extended": 1,
//            "v": "5.130"]
//
//        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//            print("------- ГРУППЫ -------")
//            print(json)
//        }
//    }
    
    // MARK: - loadFriends
    static func loadFriends(token: String, completion: @escaping (_ friend: ResponseFriend) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token": token,
            "order": "name",    //order - порядок, в котором нужно вернуть список друзей
            "count": 200,         //count - количество друзей, которое нужно вернуть
            "fields": "nickname, domain, sex, bdate, city, country, online, last_seen, relation, photo_50",  //fields - список дополнительных полей, которые необходимо вернуть.
            //            name_case - падеж для склонения имени и фамилии пользователя
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let friendResponse = try JSONDecoder().decode(ResponseFriend.self, from: data)
                        completion(friendResponse)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - loadFriendsSimple
//    static func loadFriendsSimple(token: String) {
//        let baseURL = "https://api.vk.com"
//        let path = "/method/friends.get"
//        let params: Parameters = [
//            "access_token": token,
//            "order": "name",    //order - порядок, в котором нужно вернуть список друзей
//            "count": 10,         //count - количество друзей, которое нужно вернуть
//            "fields": "nickname, domain, sex, bdate, city, country, online, last_seen, relation, photo_50",  //fields - список дополнительных полей, которые необходимо вернуть.
//            //            name_case - падеж для склонения имени и фамилии пользователя
//            "v": "5.130"]
//
//        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//            print("------- ГРУППЫ -------")
//            print(json)
//        }
//    }
    
    // MARK: - loadPhotosGetAll
    static func loadPhotosGetAll(token: String, owner_id: String, completion: @escaping (_ photo: ResponsePhoto) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token": token,
            "owner_id": owner_id,   //owner_id - идентификатор пользователя или сообщества, фотографии которого нужно получить.
            "extended": 1,          //extended - 1 — возвращать расширенную информацию о фотографиях
            "count": 5,             //count - число фотографий, информацию о которых необходимо получить.
            "no_service_albums": 1, //no_service_albums - 0 — вернуть все фотографии, включая находящиеся в сервисных альбомах, таких как "Фотографии на моей стене" (по умолчанию); 1 — вернуть фотографии только из стандартных альбомов пользователя или сообщества.
            "photo_sizes": 1,       //photo_sizes - 1 — будут возвращены размеры фотографий в специальном формате
            "skip_hidden": 1,       //skip_hidden - 1 — не возвращать фотографии, скрытые из блока над стеной пользователя (параметр учитывается только при owner_id > 0, параметр no_service_albums игнорируется).
            "v": "5.130"]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let photoResponse = try JSONDecoder().decode(ResponsePhoto.self, from: data)
                        completion(photoResponse)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - loadPhotosGet
    static func loadPhotosGet(token: String, owner_id: String, completion: @escaping (_ photo: ResponsePhoto) -> ()) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": owner_id,
            "album_id": "profile",  //wall — фотографии со стены, profile — фотографии профиля, saved — сохраненные фотографии
            "rev": 1,               //антихронологический порядок
            "count": 5,             //по умолчанию 50, максимальное значение 1000
            "extended": 1,          //будут возвращены дополнительные поля likes, comments, tags, can_comment, reposts
            "v": "5.130"
        ]
        
        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let photoResponse = try JSONDecoder().decode(ResponsePhoto.self, from: data)
                        completion(photoResponse)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - loadPhotosSimple
//    static func loadPhotosSimple(token: String, owner_id: String) {
//        let baseURL = "https://api.vk.com"
//        let path = "/method/photos.get"
//        let params: Parameters = [
//            "access_token": token,
//            "owner_id": owner_id,   //owner_id - идентификатор пользователя или сообщества, фотографии которого нужно получить.
//            "rev": 0,               //rev - порядок сортировки фотографий. Возможные значения: 1 — антихронологический; 0 — хронологический.
//            "extended": 0,          //extended - 1 — возвращать расширенную информацию о фотографиях
//            "count": 25,            //count - число фотографий, информацию о которых необходимо получить.
//            "photo_sizes": 1,       //photo_sizes - 1 — будут возвращены размеры фотографий в специальном формате
//            "v": "5.130"]
//
//        NetworkService.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
//            guard let json = response.value else { return }
//            print("------- ФОТО -------")
//            print(json)
//        }
//    }
    
    // MARK: - searchGroupSimple
    static func searchGroupSimple(token: String, query: String) {
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
