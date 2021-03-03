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

    var friend: VKFriend!
    var photos = [VKPhoto]()
    var urlArrayPhoto = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(friend.lastName) \(friend.firstName)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkService.loadPhotosGet(token: token, owner_id: String(friend.id)) { [weak self] (photoResponse) in
            
            DispatchQueue.main.async {
                self?.photos = photoResponse.response.items
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendCollectionViewCell {
            
            let photo = photos[indexPath.row]
            if let url = photo.sizes.first?.url {
                cell.downLoadImage(from: url)
            }
            
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate


}
