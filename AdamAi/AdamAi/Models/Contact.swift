//
//  Contact.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/5/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objc enum Gender: Int, RealmEnum {
   case NOTSET
   case MALE
   case FEMALE
}
class Contact:Object {
    @objc dynamic var name:String
    @objc dynamic var phoneNumber:String
    @objc dynamic var email:String?
    @objc dynamic var nickName:String?
    @objc dynamic var image:String?
    @objc dynamic var kkk:String?
    @objc dynamic var gender = Gender.NOTSET
//    if we choose ly the following we cannot change it later as it constant
//    let gender = RealmOptional<Gender>()
    @objc dynamic var owner:String
    init(name:String, phoneNumber:String, owner:String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.owner = owner
        super.init()
    }
    required init() {
        self.name = ""
        self.phoneNumber = ""
        self.owner = ""
    }
    
}
