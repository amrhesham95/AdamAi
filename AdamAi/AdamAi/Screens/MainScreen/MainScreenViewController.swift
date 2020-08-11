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
        let localDatabase = LocalDatabase.sharedInstance
        let mainScreenVM = MainScreenViewModel(database: localDatabase)
        localDatabase.viewModel = mainScreenVM
        return mainScreenVM
    }()
    
    //MARK:- viewController method
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        mainScreenVM.contactList.addObserver(fireNow: false) { (arr) in
            self.contactListTableView.reloadData()
        }
        self.navigationItem.title = mainScreenVM.getUserName()
    }
    
    
    //MARK:- actions
    @IBAction func addContactButtonAction(_ sender: Any) {
        print(mainScreenVM.contactList.value)
         let addContactScreenViewController = (self.storyboard?.instantiateViewController(identifier: "AddContactScreenViewController")) ?? UIViewController()
                   self.navigationController?.pushViewController(addContactScreenViewController, animated: true)
    }
}


extension MainScreenViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    //MARK:- tableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainScreenVM.contactList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
               // choose a name for your image
        let fileName = mainScreenVM.contactList.value[indexPath.row].id
               // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        let contactCell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactCellView
        contactCell.contactNameLabel.text = mainScreenVM.contactList.value[indexPath.row].name
        contactCell.contactNumberLabel.text = mainScreenVM.contactList.value[indexPath.row].phoneNumber
        contactCell.contactImageView.image = UIImage(contentsOfFile: fileURL.path)
        return contactCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        self.view.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.mainScreenVM.delete(contact: self.mainScreenVM.contactList.value[indexPath.row])
        
        // if true remove from contactlist
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let contactDetailsViewController = ContactDetailsViewController(contactDetailsViewModel: ContactDetailsViewModel(contact: self.mainScreenVM.contactList.value[indexPath.row], database: self.mainScreenVM.database))
        
        let contactDetailsViewController = self.storyboard?.instantiateViewController(identifier: "ContactDetailsViewController") as! ContactDetailsViewController
        contactDetailsViewController.contactDetailsViewModel = ContactDetailsViewModel(contact: self.mainScreenVM.contactList.value[indexPath.row], database: self.mainScreenVM.database)
        
        self.navigationController?.pushViewController(contactDetailsViewController, animated: true)
    }
    
    //MARK:- searchBar method
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainScreenVM.getContactsWith(string: searchText)
    }
    
    
    
    
}
