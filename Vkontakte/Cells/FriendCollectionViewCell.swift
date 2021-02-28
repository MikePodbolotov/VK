//
//  FriendCollectionViewCell.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 01.01.2021.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var nameFriendLabel: UILabel!
    
    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.friendImage.image = uiImage
                }
            }
        }.resume()
    }
}
