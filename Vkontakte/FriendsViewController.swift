//
//  FriendsViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 31.01.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var characterPicker: CharacterPicker!
    
    var friends: [VKFriend]?
    var sections = [String]()
    var chosenFriend: VKFriend!
    
    private var friendsRealm: Results<VKFriend>? {
        let friendsRealm: Results<VKFriend>? = realmManager?.getObjects()
        return friendsRealm?.sorted(byKeyPath: "lastName", ascending: true)
    }
    
    private let phoneOnLine = false
    
    private let networkManager = NetworkService.shared
    private let realmManager = RealmManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if phoneOnLine {
            NetworkService.loadFriends(token: token) { [weak self] (friendResponse) in
                self?.friends = friendResponse.response.items
                
                guard let friends = self?.friends else { return }
                
                DispatchQueue.main.async {
                    try? self?.realmManager?.add(objects: friends)
                    
                    for friend in friends {
                        let char = friend.lastName.prefix(1)
                        
                        let boolValue = self?.sections.contains(String(char)) ?? false
                        if boolValue {
                            continue
                        }
                        self?.sections.append(String(char))
                    }
                    self?.sections.sort(by: <)
                    self?.characterPicker.chars = self?.sections ?? [""]
                    self?.characterPicker.setupUi()

                    self?.tableView.reloadData()
                }
            }
        } else {
            guard let friends = friendsRealm else { return }
            
            DispatchQueue.main.async {
                for friend in friends {
                    let char = friend.lastName.prefix(1)
                    
                    let boolValue = self.sections.contains(String(char))
                    if boolValue {
                        continue
                    }
                    self.sections.append(String(char))
                }
                self.sections.sort(by: <)
                self.characterPicker.chars = self.sections
                self.characterPicker.setupUi()
                
                self.tableView.reloadData()
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var tempArr = [VKFriend]()
        
        if phoneOnLine {
            
            for friend in friends! {
                if friend.lastName.prefix(1) == sections[section] {
                    tempArr.append(friend)
                }
            }
        } else {
            
            for friend in friendsRealm! {
                if friend.lastName.prefix(1) == sections[section] {
                    tempArr.append(friend)
                }
            }
        }
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            var tempArr = [VKFriend]()
            
            if phoneOnLine {
                
                guard friends != nil else { return UITableViewCell() }
                for friend in friends! {
                    if friend.lastName.prefix(1) == sections[indexPath.section] {
                        tempArr.append(friend)
                    }
                }
                cell.friendLabel.text = "\(tempArr[indexPath.row].lastName) \(tempArr[indexPath.row].firstName)"
                cell.friendStatusLabel.text = tempArr[indexPath.row].online == 0 ? "Offline" : "Online"
                cell.frinedStatusImage.image = tempArr[indexPath.row].online == 0 ? UIImage(named: "scribble") : UIImage(named: "pencil")
                cell.downLoadImage(from: tempArr[indexPath.row].photo50)
                cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
                cell.friendImage.layer.masksToBounds = true
                
            } else {
                
                guard friendsRealm != nil else { return UITableViewCell() }
                for friend in friendsRealm! {
                    if friend.lastName.prefix(1) == sections[indexPath.section] {
                        tempArr.append(friend)
                    }
                }
                cell.friendLabel.text = "\(tempArr[indexPath.row].lastName) \(tempArr[indexPath.row].firstName)"
                cell.friendStatusLabel.text = "Offline"
                cell.downLoadImage(from: tempArr[indexPath.row].photo50)
                cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
                cell.friendImage.layer.masksToBounds = true
            
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
