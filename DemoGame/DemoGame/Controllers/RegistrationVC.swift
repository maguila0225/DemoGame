//
//  RegistrationVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField

class RegistrationVC: UIViewController {

    
    @IBOutlet weak var usernameRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordConfirmation: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameRegistration.label.text = "Username"
        usernameRegistration.leadingAssistiveLabel.text = ""
        
        passwordRegistration.label.text = "Password"
        passwordRegistration.leadingAssistiveLabel.text = ""
        passwordRegistration.isSecureTextEntry = true
        
        passwordConfirmation.label.text = "Password"
        passwordConfirmation.leadingAssistiveLabel.text = ""
        passwordConfirmation.isSecureTextEntry = true

    }
    override func  viewWillAppear(_ animated: Bool) {
        usernameRegistration.text = ""
        passwordRegistration.text = ""
        passwordConfirmation.text = ""
        
    }
    @IBAction func registerButton(_ sender: Any) {
        NSLog("Register Attempt")
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
}
