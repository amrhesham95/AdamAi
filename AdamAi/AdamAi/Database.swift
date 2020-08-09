//
//  Database.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
protocol Database {
    func getAllContacts() -> Observable<Array<Contact>>
    func getContactsWith(string:String)
    func addContact(contact: Contact)
    func saveToDatabase(contact:Contact) -> Bool
}
