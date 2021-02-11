//
//  ProfileViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 17.01.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameProfileLabel: UILabel!
    @IBOutlet weak var cityProfileLabel: UILabel!
    @IBOutlet weak var educationProfileLabel: UILabel!
    @IBOutlet weak var workplaceProfileLabel: UILabel!
    @IBOutlet weak var mainProfileAvatarImage: UIImageView!
    
    //Получили с сервера данные пользователя
    var name = "Михаил Подболотов"
    var city = "Москва"
    var education = "ВГИ ВолГУ"
    var workplace = "1C-Rarus"
    var avatar = UIImage(named: "avatar_profile")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameProfileLabel.text = name
        cityProfileLabel.text = city
        educationProfileLabel.text = education
        workplaceProfileLabel.text = workplace
        mainProfileAvatarImage.image = avatar
        
//        mainProfileAvatarImage.layer.cornerRadius = mainProfileAvatarImage.frame.width / 2

//        mainProfileAvatarImage.layer.shadowColor = UIColor.black.cgColor
//        mainProfileAvatarImage.layer.shadowOpacity = 0.5
//        mainProfileAvatarImage.layer.shadowRadius = 8
//        mainProfileAvatarImage.layer.shadowOffset = CGSize.zero
    }
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
