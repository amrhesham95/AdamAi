//
//  ViewController.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/5/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class WelcomeViewController: UIViewController {
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    lazy var welcomeVM = WelcomeViewModel(textFieldPlaceHolder: "Enter your name", loginBtnTitle: "Login")
    var imagePicker: ImagePicker!
    @IBOutlet weak var addPictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        if self.welcomeVM.isLoggedIn(){
            let contactListViewController = (self.storyboard?.instantiateViewController(identifier: "ContactListViewController")) ?? UIViewController()
            self.navigationController?.pushViewController(contactListViewController, animated: true)
            
        }
     
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
    }
    @IBAction func loginBtnAction(_ sender: UIButton) {
        let loginSuccess = welcomeVM.authenticateUser(phoneNumber: phoneNumberTF.text ?? "",imageData:userImageView.image?.jpegData(compressionQuality: 1))
        if loginSuccess {
            //navigate
            let contactListViewController = (self.storyboard?.instantiateViewController(identifier: "ContactListViewController")) ?? UIViewController()
            self.navigationController?.pushViewController(contactListViewController, animated: true)
        }else{
            // show error
            let alertController = UIAlertController(title: "Missing data!", message: "Please enter your name and image", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
    }
    
    func initUI(){
        phoneNumberTF.placeholder = welcomeVM.textFieldPlaceHolder
        loginBtn.setTitle(welcomeVM.loginBtnTitle, for: .normal)
    }
  
    
    @IBAction func addPictureButtonAction(_ sender: UIButton) {
        self.imagePicker.present(from: self.view)

    }
}

extension WelcomeViewController:ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        self.userImageView.image = image
    }
}
