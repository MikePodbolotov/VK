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
    var urlArrayPhoto = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(friend.lastName) \(friend.firstName)"
        
//        NetworkService.loadPhotos(token: token, owner_id: String(friend.id)) { [self] (photoResponse) in
//            let tempArrayPhotos = photoResponse.response.items
//            for tempPhoto in tempArrayPhotos {
//                guard !tempPhoto.sizes.isEmpty else { return }
//                for urlPhoto in tempPhoto.sizes {
//                    urlArrayPhoto.append(urlPhoto.url)
//                }
//            }
//            print("Enter viewDidLoad. Count: \(tempArrayPhotos.count)")
//        }
        
        NetworkService.loadPhotos(token: token, owner_id: String(friend.id)) { [weak self] (photoResponse) in
            let tempArrayPhotos = photoResponse.response.items
            for tempPhoto in tempArrayPhotos {
                guard !tempPhoto.sizes.isEmpty else { return }
                for urlPhoto in tempPhoto.sizes {
                    self?.urlArrayPhoto.append(urlPhoto.url)
                }
            }
            DispatchQueue.main.async {
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
        print("Enter numberOfItemsInSection. Count = \(urlArrayPhoto.count)")
        return urlArrayPhoto.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendCollectionViewCell {
            cell.downLoadImage(from: urlArrayPhoto[indexPath.row])
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate


}
