//
//  RegistrationVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

// MARK: - RegistrationVC imported libraries
import UIKit
import MaterialComponents.MDCOutlinedTextField
import MaterialComponents.MaterialButtons
import FirebaseFirestore
import IQKeyboardManager

// MARK: - RegistrationVC
class RegistrationVC: UIViewController {
    
// MARK: - RegistrationVC variable declaration
    @IBOutlet weak var usernameRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordConfirmation: MDCOutlinedTextField!
    let vcIdentifier = "RegistrationVC"
    let firestoreDatabase = Firestore.firestore()

// MARK: - RegistrationVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
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
        GlobalLog_Display(vc_Log: vcIdentifier)
        usernameRegistration.text = ""
        passwordRegistration.text = ""
        passwordConfirmation.text = ""
        
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
                self.registrationAlert(alertTitle: "Registration Error", alertMessage: "Empty Username/Password")
                NSLog("Empty Username/Password")
            }
            if passwordConfirmation.text != passwordRegistration.text{
                self.registrationAlert(alertTitle: "Registration Error", alertMessage: "Mismatch Password")
                NSLog("Mismatch Password")
            }
            return
        }
        registerUser(username: usernameRegistration.text!, password: passwordConfirmation.text!)

    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - RegistrationVC functions
extension RegistrationVC{

    func registerUser(username: String, password: String){
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameRegistration.text!)")
        documentReference.getDocument { snapshot, error in
            if error == nil {
                guard snapshot?.data() == nil else{
                    self.registrationAlert(alertTitle: "Registration Error", alertMessage: "User Already Exists")
                    NSLog("User Already Exists")
                    return
                }
                self.registrationAlert(alertTitle: "Registration Successful", alertMessage: "Proceed to Log In")
                NSLog("\(self.usernameRegistration.text!):\(self.passwordConfirmation.text!)Registered")
                documentReference.setData([username:password])
            }
        }
    }

    func registrationAlert(alertTitle: String, alertMessage: String){
        let alertController = MDCAlertController(title: alertTitle, message: alertMessage)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        self.present(alertController, animated:true, completion: nil)
    }
}
