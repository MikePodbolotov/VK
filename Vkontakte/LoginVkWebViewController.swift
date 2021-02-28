//
//  LoginVkWebViewController.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 12.02.2021.
//

import UIKit
import WebKit

class LoginVkWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7758916"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
}

extension LoginVkWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map {$0.components(separatedBy: "=")}
            .reduce([String: String]()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        Session.dataSession.token = token
        
//        NetworkService.loadGroupsSimple(token: token)
//        NetworkService.loadFriendsSimple(token: token)
//        NetworkService.loadPhotosSimple(token: token, owner_id: "1654070")
//        NetworkService.searchGroup(token: token, query: "Туманный Альбион")
        
        NetworkService.loadGroups(token: token) { [weak self] (groupResponse) in

            let gropVC = MyGroupTableViewController()
            gropVC.groups = groupResponse.response.items

            self?.navigationController?.pushViewController(gropVC, animated: true)
        }
        
        NetworkService.loadFriends(token: token) { [weak self] (friendResponse) in
            
            let friendVC = FriendsTableViewController()
            friendVC.friends = friendResponse.response.items
            
            self?.navigationController?.pushViewController(friendVC, animated: true)
        }
        
//        NetworkService.loadPhotos(token: token, owner_id: "1654070") { [weak self] (photoResponse) in
//
//            let photosResponse = photoResponse.response.items
//            print(photoResponse)
//        }

        decisionHandler(.cancel)
        performSegue(withIdentifier: "segueToMainScreen", sender: self)
    }
}

