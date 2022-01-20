//
//  RegistrationVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import MaterialComponents.MaterialButtons
import FirebaseFirestore
import IQKeyboardManager

class RegistrationVC: UIViewController {
    
// MARK: - RegistrationVC IBOutlet Declaration
    @IBOutlet weak var usernameRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordConfirmation: MDCOutlinedTextField!

// MARK: - Variable/Constant Declaration
    let vcIdentifier = "RegistrationVC"
    let firestoreDatabase = Firestore.firestore()
    var playerID: String = ""
    var newPlayer = Player()
    
// MARK: - RegistrationVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        title = "Create User"
        initializeScreenElements()
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        pageClear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    
// MARK: - RegistrationVC IBAction
    @IBAction func registerUser(_ sender: Any) {
        NSLog("User Registration Attempt")
        guard usernameRegistration.text?.isEmpty == false
                && passwordConfirmation.text?.isEmpty == false
                && passwordRegistration.text == passwordConfirmation.text
        else{
            if usernameRegistration.text?.isEmpty == true
                || passwordRegistration.text?.isEmpty == true{
                self.gameAlert(alertTitle: "Registration Error", alertMessage: "Empty Username/Password")
                NSLog("Empty Username/Password")
            }
            if passwordConfirmation.text != passwordRegistration.text{
                self.gameAlert(alertTitle: "Registration Error", alertMessage: "Mismatch Password")
                NSLog("Mismatch Password")
            }
            return
        }
        self.playerID = usernameRegistration.text!
        registerUser(username: usernameRegistration.text!, password: passwordConfirmation.text!)
    }
}


