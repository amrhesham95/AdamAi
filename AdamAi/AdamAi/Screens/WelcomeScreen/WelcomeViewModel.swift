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
    func authenticateUser(phoneNumber:String) -> Bool{
        if phoneNumber.count > 0 {
            print("Success")
            return true
        }else{
            print("Failed")
            return false
        }
    }
}
