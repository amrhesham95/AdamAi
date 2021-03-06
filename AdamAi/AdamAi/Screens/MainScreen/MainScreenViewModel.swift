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
        self.database.delete(contact: contact)
    }
    
    func getUserName() -> String {
        let defaults = UserDefaults.standard
        var userName = defaults.string(forKey: "userName")
        userName?.append("'s contacts")
        return userName ?? ""
    }
    
}
