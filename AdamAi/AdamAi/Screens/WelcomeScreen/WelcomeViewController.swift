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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
    }
    @IBAction func loginBtnAction(_ sender: UIButton) {
        let loginSuccess = welcomeVM.authenticateUser(phoneNumber: phoneNumberTF.text ?? "")
        if loginSuccess {
            //navigate
            let contactListVC = (self.storyboard?.instantiateViewController(identifier: "ContactListViewController")) ?? UIViewController()
            self.navigationController?.pushViewController(contactListVC, animated: true)
        }else{
            // show error
        }
    }
    
    func initUI(){
        phoneNumberTF.placeholder = welcomeVM.textFieldPlaceHolder
        loginBtn.setTitle(welcomeVM.loginBtnTitle, for: .normal)
    }
    
}

