//
//  ViewController.swift
//  AdamAi
//
//  Created by Amr Hesham on 8/5/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    lazy var welcomeVM = WelcomeViewModel(textFieldPlaceHolder: "Enter your name", loginBtnTitle: "Login")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnAction(_ sender: UIButton) {
        welcomeVM.authenticateUser(phoneNumber: phoneNumberTF.text ?? "")
    }
    
    func initUI(){
        phoneNumberTF.placeholder = welcomeVM.textFieldPlaceHolder
        loginBtn.setTitle(welcomeVM.loginBtnTitle, for: .normal)
    }
    
}

