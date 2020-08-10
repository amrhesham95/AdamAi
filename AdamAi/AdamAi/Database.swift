//
//  Database.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
protocol Database {
    var localList :Observable<Array<Contact>>{get set}
    func getAllContacts() -> Observable<Array<Contact>>
    func saveToDatabase(contact:Contact) -> Bool
}
