//
//  MainScreenViewController.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/6/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
import UIKit
class MainScreenViewController:UIViewController {
    //MARK:- outlets
    @IBOutlet weak var searchContactsTF: UITextField!
    @IBOutlet weak var contactListTableView: UITableView!
    @IBOutlet weak var addContactButton: UIBarButtonItem!
    lazy var mainScreenVM : MainScreenViewModel = {
        // TODO: are we destroying the single responsbility ? we might change the DB to singletone
        let localDatabase = LocalDatabase()
        let mainScreenVM = MainScreenViewModel(database: localDatabase)
        localDatabase.viewModel = mainScreenVM
        return mainScreenVM
    }()
    
    //MARK:- viewController method
    override func viewDidLoad() {
        mainScreenVM.contactList.addObserver(fireNow: false) { (arr) in
            self.contactListTableView.reloadData()
        }
    }
    
    
    //MARK:- actions
    @IBAction func addContactButtonAction(_ sender: Any) {
//        mainScreenVM.database.addContact(contact: "addedElement")
        mainScreenVM.database.saveToDatabase(contact: Contact(name: "amr", phoneNumber: "01009005103", owner: "1"))
        print(mainScreenVM.contactList.value)
    }
}


extension MainScreenViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    //MARK:- tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainScreenVM.contactList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
               // choose a name for your image
               let fileName = mainScreenVM.contactList.value[indexPath.row].image ?? ""
               // create the destination file url to save your image
               let fileURL = documentsDirectory.appendingPathComponent(fileName)
        cell.imageView?.image = UIImage(contentsOfFile: fileURL.path)
        cell.imageView?.circleImage()
        cell.textLabel?.text = mainScreenVM.contactList.value[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        self.view.frame.height / 6
    }
    
    //MARK:- searchBar method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainScreenVM.database.getContactsWith(string: searchText)
    }
    
    
}
