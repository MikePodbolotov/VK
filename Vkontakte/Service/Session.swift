//
//  Session.swift
//  UI_Vkontakte
//
//  Created by Михаил Подболотов on 12.02.2021.
//

import Foundation

class Session {
    static let dataSession = Session()
    
    private init(){}
    
    var token: String = ""
    var userId = Int()
}
