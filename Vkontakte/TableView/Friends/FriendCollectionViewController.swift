//
//  FriendCollectionViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 01.01.2021.
//

import UIKit

private let reuseIdentifier = "Cell"
let token = Session.dataSession.token

class FriendCollectionViewController: UICollectionViewController {

    var friends: [Friend]!
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        self.title = "\(friend.lastName) \(friend.name)"
    }

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendCollectionViewCell {
            let avatar = friend?.avatar != "" ? friend?.avatar : "img_friends"
            cell.friendImage.image = UIImage(named: avatar!)
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate


}
