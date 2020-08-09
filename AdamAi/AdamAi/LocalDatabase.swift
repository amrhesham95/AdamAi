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
    }
    static let sharedInstance = LocalDatabase()
    var viewModel:MainScreenViewModel?
      
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
//        let image = UIImage(contentsOfFile: fileURL.path)
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
            viewModel?.contactList.value.append(contact)
            return true
        }
        
        return false

//        do {
//            try realm.write { () -> Bool in
//                realm.add(contact)
//                viewModel?.contactList.value.append(contact)
//                return true
//            }
//            return false
//        } catch _ {
//            return false
//        }
    

    }
    
    func addContact(contact: Contact) {
        self.localList.value.append(contact)
        self.viewModel?.contactList.value.append(contact)
    }
    
    func getAllContacts() -> Observable<Array<Contact>> {
        let allContacts = Observable(Array(self.localList.value))
        return allContacts
    }
    
    func getContactsWith(string:String){
        self.viewModel?.contactList.value = string.isEmpty ? localList.value : localList.value.filter {
            return $0.name.lowercased().hasPrefix(string.lowercased())
       }
        
        
    }
    
    
    
    
}
