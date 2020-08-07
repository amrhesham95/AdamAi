//
//  MainScreenViewModel.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
class MainScreenViewModel {
    var contactList:Observable<Array<Contact>>
    var database:Database
    init(database:Database) {
        self.database = database
        contactList = self.database.getAllContacts()
    }
}
