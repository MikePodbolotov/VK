//
//  FriendsViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 31.01.2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterPicker: CharacterPicker!
    
    var networkService: NetworkService!
    var friends: [Friend]!
    var sections = [String]()
    var chosenFriend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        networkService = NetworkService()
        friends = networkService.getFriends()
        
        for friend in friends {
            let char = friend.lastName.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
        characterPicker.chars = sections
        characterPicker.setupUi()
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

    @IBAction func characterPicked(_ sender: CharacterPicker) {
        let selectedChar = characterPicker.selectedChar
        var indexPath = IndexPath(item: 0, section: 0)
        for (index, section) in sections.enumerated() {
            if selectedChar == section {
                indexPath = IndexPath(item: 0, section: index)
            }
        }
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func panGestureAction(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: characterPicker)
        let coef = Int(characterPicker.frame.height) / sections.count
        
        let letterIndex = Int(location.y) / coef
        
        if letterIndex < sections.count && letterIndex >= 0 {
            characterPicker.selectedChar = sections[letterIndex]
        }
    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            var tempArr = [Friend]()
            for friend in friends {
                if friend.lastName.prefix(1) == sections[indexPath.section] {
                    tempArr.append(friend)
                }
            }
            cell.friendLabel.text = "\(tempArr[indexPath.row].lastName) \(tempArr[indexPath.row].name)"
            cell.friendStatusLabel.text = "Online"
            let avatar = tempArr[indexPath.row].avatar != "" ? tempArr[indexPath.row].avatar : "img_friends"
            cell.friendImage.image = UIImage(named: avatar)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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
