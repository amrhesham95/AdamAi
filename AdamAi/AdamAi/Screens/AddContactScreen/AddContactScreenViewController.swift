//
//  AddContactScreenViewController.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/8/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import Foundation
import UIKit
class AddContactScreenViewController:UIViewController{
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var saveContactButton: UIButton!
    
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    var imagePicker: ImagePicker!
    lazy var addContactScreenViewModel  = AddContactScreenViewModel(database: LocalDatabase.sharedInstance)
    
    
    override func viewDidLoad() {
        nameErrorLabel.isHidden = true
        phoneNumberErrorLabel.isHidden = true
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.contactImageView.isUserInteractionEnabled = true
        let imageGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        contactImageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    @objc func imageTapped() {
         self.imagePicker.present(from: self.view)
     }
    
    @IBAction func saveContactButtonAction(_ sender: UIButton) {
        let isSuccess = addContactScreenViewModel.saveContact(name: nameTextField.text, phoneNumber: phoneNumberTextField.text, email: emailTextField.text, nickname: nicknameTextField.text, image: contactImageView.image?.jpegData(compressionQuality: 1), gender:Gender(rawValue: self.genderPickerView.selectedRow(inComponent: 0))!)
        
        if isSuccess {
//             dissmiss
            self.navigationController?.popViewController(animated: true)
        }else{
            // show error
            nameErrorLabel.isHidden = addContactScreenViewModel.isNameValid
            phoneNumberErrorLabel.isHidden = addContactScreenViewModel.isPhoneNumberValid
        }
    }
    
 
    
    
}

extension AddContactScreenViewController: ImagePickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.addContactScreenViewModel.pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.addContactScreenViewModel.pickerData[row]
    }
    
    func didSelect(image: UIImage?) {
        self.contactImageView.image = image
    }
}

