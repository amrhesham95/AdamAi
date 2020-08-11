//
//  ContactDetailsViewModel.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/11/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
class ContactDetailsViewModel{
    var contact:Contact
    var database:Database
    
    init(contact:Contact, database:Database) {
        self.contact = contact
        self.database = database
    }
    
    func delete(contact:Contact) -> Bool{
        let success = self.database.delete(contact: contact)
           return success
        
        }
}
