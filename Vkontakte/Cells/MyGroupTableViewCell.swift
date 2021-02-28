//
//  MyGroupTableViewCell.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.01.2021.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var myGroupLabel: UILabel!
    @IBOutlet weak var myGroupImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        myGroupLabel.text = ""
        myGroupImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func downLoadImage(from stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                let uiImage = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.myGroupImage.image = uiImage
                }
                
            }
        }.resume()
    }
}
