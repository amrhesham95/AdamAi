//
//  LocalDatabase.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
class LocalDatabase:Database {
    private init() {
        self.localList.addObserver(fireNow: false) { [weak self] (contacts) in
            self?.viewModel?.contactList.value = (self?.localList.value)!
        }
    }
    static let sharedInstance = LocalDatabase()
    var viewModel:ViewModel?
      
       lazy var localList :Observable<Array<Contact>>={
           let realm = try! Realm()
           // here we put the owner from the userDefaults so each user see his contacts
           let result = realm.objects(Contact.self).filter("owner = '1'")
           let localList = Observable(Array(result))
           return localList
       }()
    
    func saveToDatabase(contact: Contact) ->Bool {
        let realm = try! Realm()
        
        // get the documents directory url
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = contact.id
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = contact.image,
          !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
        
        try? realm.write { () -> Bool in
            realm.add(contact)
            localList.value.append(contact)
            return true
        }
        
        return false
    }
    
    func getAllContacts() -> Observable<Array<Contact>> {
        let allContacts = Observable(Array(self.localList.value))
        return allContacts
    }
    
    func delete(contact:Contact) -> Bool{

        let realm = try! Realm()
        let objToBeDelete  = realm.objects(Contact.self).filter("id='\(contact.id)'")
        
        do {
            try realm.write {
              realm.delete(objToBeDelete)
            }
            let result = realm.objects(Contact.self).filter("owner = '1'")
            self.localList.value = Array(result)
            return true
        } catch let error {
            print(error)
            return false
        }
    
    }
    
    
    
    
}
