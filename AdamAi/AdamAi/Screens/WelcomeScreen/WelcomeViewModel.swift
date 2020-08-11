//
//  WelcomeViewModel.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/5/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
class WelcomeViewModel {
    
    var textFieldPlaceHolder:String
    var loginBtnTitle:String
    init(textFieldPlaceHolder:String, loginBtnTitle:String) {
        self.textFieldPlaceHolder = textFieldPlaceHolder
        self.loginBtnTitle = loginBtnTitle
    }
    func authenticateUser(phoneNumber:String, imageData:Data?) -> Bool{
        if phoneNumber.count > 0 && imageData != nil{
            let user = User(phoneNumber: phoneNumber)
            let defaults = UserDefaults.standard
            defaults.set(phoneNumber, forKey: "userName")
            // could be used later to save and get the image just like we do with the contact
            defaults.set(user.id, forKey:"imagePath")
            print("Success")
            return true
        }else{
            return false
        }
    }
    
    func isLoggedIn() -> Bool {
        let defaults = UserDefaults.standard
        let userName = defaults.string(forKey: "userName")
        
        if userName != nil{
            return true
        }else{
            return false
        }
    }
}
