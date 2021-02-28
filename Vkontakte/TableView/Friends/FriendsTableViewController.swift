//
//  FriendsTableViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 01.01.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var networkService: NetworkService!
    var friends: [VKFriend]?
    var sections = [String]()
    var chosenFriend: VKFriend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard friends != nil else { return }
        for friend in friends! {
            let char = friend.lastName.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkService.loadFriends(token: token) { [weak self] (friendResponse) in
            self?.friends = friendResponse.response.items
        }
        
        guard friends != nil else { return }
        for friend in friends! {
            let char = friend.lastName.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
        tableView.reloadData()
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
        var tempArr = [VKFriend]()
        for friend in friends! {
            if friend.lastName.prefix(1) == sections[section] {
                tempArr.append(friend)
                }
        }
        return tempArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            var tempArr = [VKFriend]()
            guard friends != nil else { return UITableViewCell() }
            for friend in friends! {
                if friend.lastName.prefix(1) == sections[indexPath.section] {
                    tempArr.append(friend)
                }
            }
            cell.friendLabel.text = "\(tempArr[indexPath.row].lastName) \(tempArr[indexPath.row].firstName)"
            cell.friendStatusLabel.text = "Online"
            cell.downLoadImage(from: tempArr[indexPath.row].photo50)
            cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
            cell.friendImage.layer.masksToBounds = true

            //            cell.friendLabel.text = "\(friends[indexPath.row].lastName) \(friends[indexPath.row].name)"
            //            cell.friendStatusLabel.text = "Online"
            //            let avatar = friends[indexPath.row].avatar != "" ? friends[indexPath.row].avatar : "img_friends"
            //            cell.friendImage.image = UIImage(named: avatar)
            //            cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
            //            cell.friendImage.layer.masksToBounds = true
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
       
        var tempArr = [VKFriend]()
        guard friends != nil else { return }
        for friend in friends! {
            if friend.lastName.prefix(1) == sections[indexPath.section] {
                tempArr.append(friend)
            }
        }

        chosenFriend = tempArr[indexPath.row]
        performSegue(withIdentifier: "toFriend", sender: self)
    }

}
