//
//  Contact.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/5/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
enum Gender{
    case MALE
    case FEMALE
}
struct Contact {
    var name:String
    var phoneNumber:String
    var email:String?
    var nickName:String?
    var image:String?
    var gender:Gender?
   
}
