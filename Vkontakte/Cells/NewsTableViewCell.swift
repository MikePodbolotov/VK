//
//  NewsTableViewCell.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 05.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
    static let identifier = "news"
    
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func configure(newsText: String) {
        newsLabel.text = newsText
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
