//
//  ViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logoImage = UIImageView(frame: CGRect(x: 10, y: 40, width: Int(self.view.frame.width) - 20, height: Int(self.view.frame.width) - 20))
        logoImage.image = UIImage(named: "Logo.png")
        view.addSubview(logoImage)
        
        let usernameTextField = MDCOutlinedTextField(frame: CGRect(x: 0, y: Int(self.view.frame.width) + 40 + 20, width: Int(self.view.frame.width), height: 50))
        
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        usernameTextField.sizeToFit()
        view.addSubview(usernameTextField)
        
        let passwordTextField = MDCOutlinedTextField(frame: CGRect(x: 0, y: Int(self.view.frame.width) + 40 + 20 + 80, width: Int(self.view.frame.width), height: 50))
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
        passwordTextField.sizeToFit()
        view.addSubview(passwordTextField)
    }
    @IBAction func logInAttempt(_ sender: Any) {
        NSLog("Log in Attempted")
    }
    @IBAction func registerButton(_ sender: Any) {
        NSLog("Register")
    }
}

