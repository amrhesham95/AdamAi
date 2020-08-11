//
//  AddContactScreenViewModel.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/8/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
class AddContactScreenViewModel {
    
    var database:Database
    var isNameValid = true
    var isPhoneNumberValid = true
    var pickerData = [String]()
    init(database:Database) {
        self.database = database

        for element in Gender.allCases{
            pickerData.append(element.description())
        }
    }
    
    func saveContact(name:String?, phoneNumber:String?, email:String?, nickname:String?, image:Data?, gender:Gender) -> Bool{
        // if validate true
        let contact = Contact(name: name!, phoneNumber: phoneNumber!, email: email, nickname: nickname, image: image, gender: gender)
        
        if validateContact(contact: contact){
            database.saveToDatabase(contact: contact)
            return true
        }
        return false
        // then in viewController show or hide error
    }
    
    func validateContact(contact:Contact) -> Bool {
        if ( (contact.name.count > 0) && (contact.phoneNumber.count > 0) ){
            return true
        }
        if contact.name.count < 1 {
            isNameValid = false
        }else{
            isNameValid = true
        }
        if contact.phoneNumber.count < 1 {
            isPhoneNumberValid = false
        }else{
            isPhoneNumberValid = true
        }
        return false
    }
}
