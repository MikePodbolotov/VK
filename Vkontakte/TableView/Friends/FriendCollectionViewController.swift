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

//    var friends: [VKFriend]!
    var friend: VKFriend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(friend.lastName) \(friend.firstName)"
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
//            let avatar = friend?.avatar != "" ? friend?.avatar : "img_friends"
            cell.friendImage.image = UIImage(named: "img_friends")
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate


}
