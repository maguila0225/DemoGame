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
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registerUser(_ sender: Any) {
        NSLog("User Registration Attempt")
        guard usernameRegistration.text?.isEmpty == false
                && passwordConfirmation.text?.isEmpty == false
                && passwordRegistration.text == passwordConfirmation.text
        else{
            if usernameRegistration.text?.isEmpty == true
                || passwordRegistration.text?.isEmpty == true{
                NSLog("Username/Password is Empty")
            }
            if passwordConfirmation.text != passwordRegistration.text{
                NSLog("Mismatch Password")
            }
            return
        }
        registerUser(username: usernameRegistration.text!, password: passwordConfirmation.text!)
        
    }
    
    func registerUser(username: String, password: String){
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameRegistration.text!)")
        documentReference.getDocument { snapshot, error in
            if error == nil {
                guard snapshot?.data() == nil else{
                    print(snapshot?.data() as Any)
                    NSLog("User Already Exists")
                    return
                }
                NSLog("\(self.usernameRegistration.text!):\(self.passwordConfirmation.text!)Registered")
                documentReference.setData([username:password])
            }
        }
    }
}

