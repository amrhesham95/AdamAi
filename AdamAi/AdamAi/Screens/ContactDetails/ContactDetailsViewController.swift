//
//  ContactDetailsViewController.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/10/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var contactImageView: UIImageView!
    
    var contactDetailsViewModel:ContactDetailsViewModel!
       override func viewDidLoad() {
        super.viewDidLoad()
        initUI(contactDetailsViewModel: self.contactDetailsViewModel)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
       let success =  self.contactDetailsViewModel.delete(contact: self.contactDetailsViewModel.contact)
        if success{
            //navigate back
            self.navigationController?.popViewController(animated: true)
        }else{
            //couldn't delete let's see what can we do here
        }
    }
    
    func initUI(contactDetailsViewModel:ContactDetailsViewModel){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
               // choose a name for your image
        let fileName = self.contactDetailsViewModel.contact.id
               // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        contactImageView.image = UIImage(contentsOfFile: fileURL.path)
        nameTextField.text = contactDetailsViewModel.contact.name
        phoneNumberTextField.text = contactDetailsViewModel.contact.phoneNumber
        emailTextField.text = contactDetailsViewModel.contact.email
        nicknameTextField.text = contactDetailsViewModel.contact.nickName
        genderTextField.text = contactDetailsViewModel.contact.gender.description()
    }

}
