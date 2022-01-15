//
//  RegistrationVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import FirebaseFirestore

class RegistrationVC: UIViewController {

    
    @IBOutlet weak var usernameRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordConfirmation: MDCOutlinedTextField!
    
    let firestoreDatabase = Firestore.firestore()
    
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
    @IBAction func registerUser(_ sender: Any) {
        guard usernameRegistration.text?.isEmpty == false
                && passwordConfirmation.text?.isEmpty == false
                && passwordRegistration.text == passwordConfirmation.text
        else{
            if usernameRegistration.text?.isEmpty == true{
                usernameRegistration.leadingAssistiveLabel.text = "Invalid Username"
            }
            if passwordConfirmation.text != passwordRegistration.text{
                passwordRegistration.leadingAssistiveLabel.text = "Mismatch Password"
            }
                    return
            }
    
        registerUser(username: usernameRegistration.text!, password: passwordConfirmation.text!)
    }
    
    func registerUser(username: String, password: String){
        let documentReference = firestoreDatabase.document("playerDatabase/\(username)")
        documentReference.setData([username:password])
    }
}
