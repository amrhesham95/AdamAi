//
//  MainScreenViewModel.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
class MainScreenViewModel:ContactsListViewModel {
    var contactList:Observable<Array<Contact>>
    var database:Database
    init(database:Database) {
        self.database = database
        contactList = self.database.getAllContacts()
    }
    
    func getContactsWith(string:String){
     self.contactList.value = string.isEmpty ? self.database.localList.value : self.database.localList.value.filter {
         return $0.name.lowercased().hasPrefix(string.lowercased()) || $0.phoneNumber.hasPrefix(string)
    }
    }
    
    func delete(contact:Contact){
        let success = self.database.delete(contact: contact)
//        if success{
//            self.contactList.value = self.database.getAllContacts().value
//
//        }
    
    }
    
}
