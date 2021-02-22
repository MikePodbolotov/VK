//
//  FriendsTableViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 01.01.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var networkService: NetworkService!
    var friends: [Friend]!
    var sections = [String]()
    var chosenFriend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        networkService = NetworkService()
//        friends = networkService.getFriends()
        
        NetworkService.shared.getFriendsWithSwiftyJSON(token: token) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let friendsArray):
                self.friends = friendsArray
                
                print(friendsArray.map { $0.lastName })
            case .failure(let error):
                print(error)
            }
        }
        
        for friend in friends {
            let char = friend.lastName.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toFriend" {
                if let destination = segue.destination as? FriendCollectionViewController {
                    destination.friend = chosenFriend
                }
                else if segue.identifier == "toFriend" {
                    
                }
            }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var tempArr = [Friend]()
        for friend in friends {
            if friend.lastName.prefix(1) == sections[section] {
                tempArr.append(friend)
                }
        }
        return tempArr.count
        
//        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            var tempArr = [Friend]()
            for friend in friends {
                if friend.lastName.prefix(1) == sections[indexPath.section] {
                    tempArr.append(friend)
                }
            }
            cell.friendLabel.text = "\(tempArr[indexPath.row].lastName) \(tempArr[indexPath.row].firstName)"
            cell.friendStatusLabel.text = "Online"
            let avatar = tempArr[indexPath.row].avatar != "" ? tempArr[indexPath.row].avatar : "img_friends"
            cell.friendImage.image = UIImage(named: avatar!)
            cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
            cell.friendImage.layer.masksToBounds = true
            
            //                cell.friendLabel.text = "\(friends[indexPath.row].lastName) \(friends[indexPath.row].name)"
            //                cell.friendStatusLabel.text = "Online"
            //                let avatar = friends[indexPath.row].avatar != "" ? friends[indexPath.row].avatar : "img_friends"
            //                cell.friendImage.image = UIImage(named: avatar)
            //                cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
            //                cell.friendImage.layer.masksToBounds = true
            //            Тень не работает %(
            //            cell.friendImage.layer.shadowColor = UIColor.black.cgColor
            //            cell.friendImage.layer.shadowOpacity = 0.5
            //            cell.friendImage.layer.shadowRadius = 8
            //            cell.friendImage.layer.shadowOffset = CGSize.zero
            //            cell.friendImage.layer.masksToBounds = false
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var tempArr = [Friend]()
        for friend in friends {
            if friend.lastName.prefix(1) == sections[indexPath.section] {
                tempArr.append(friend)
            }
        }
        
        chosenFriend = tempArr[indexPath.row]
        performSegue(withIdentifier: "toFriend", sender: self)
    }

}
