//
//  LoginViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 27.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScroll))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            let result = checkUserCredentials()
            
            if !result {
                showAlert()
            }
        return result
    }
    
    func checkUserCredentials() -> Bool {
        return usernameTextField.text! == "" && passwordTextField.text! == ""
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка авторизации", message: "Неверный логин или пароль", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func didTapOnScroll() {
        view.endEditing(true)
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        // Получаем текст логина
//        let login = usernameTextField.text!
//        // Получаем текст-пароль
//        let password = passwordTextField.text!
//
//        // Проверяем, верны ли они
//        if login == "admin" && password == "12345" {
//            print("Успешная авторизация")
//            performSegue(withIdentifier: "to_TabBarController", sender: nil)
//        } else {
//            print("Неуспешная авторизация")
//        }
    }
    
}
