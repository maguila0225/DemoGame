//
//  ViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialDialogs
import Firebase
import IQKeyboardManager

class LogInVC: UIViewController {
    let vcIdentifier: String = "LogInVC"
    
    // MARK: - LogInVC variable declaration
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    
    let firestoreDatabase = Firestore.firestore()
    // MARK: - LogInVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        initializeScreenElements()
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        pageClear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    // MARK: - LogInVC IBAction
    @IBAction func logInAttempt(_ sender: Any) {
        NSLog("Log in Attempted")
        guard usernameTextField.text?.isEmpty == false
                && passwordTextField.text?.isEmpty == false
        else{
            logInAlert(alertTitle: "Log In Error", alertMessage: "Empty username/Password")
            NSLog("Empty Username/Password")
            return
        }
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameTextField.text!)")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                self.logInAlert(alertTitle: "Log In Error", alertMessage: "Invalid User")
                NSLog("Invalid User")
                return
            }
            guard data[self.usernameTextField.text!] as! String == self.passwordTextField.text!
            else{
                self.logInAlert(alertTitle: "Log In Error", alertMessage: "Incorrect Password")
                NSLog("Incorrect Password")
                return
            }
            NSLog("User: \(self.usernameTextField.text!) logged in")
            self.screenTransition(vcIdentifier: "MainMenuVC")
            
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        screenTransition(vcIdentifier: "RegistrationVC")
    }
}
// MARK: - LogInVC Functions
extension LogInVC{
// MARK: - Initializing Functions
    func initializeScreenElements(){
        logoImage.image = UIImage(named: "Logo.png")
        
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
    }
//MARK: - Page Clear Function
    func pageClear(){
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    
// MARK: - Screen Transition
    func screenTransition(vcIdentifier: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        switch vcIdentifier{
        case "RegistrationVC":
            let vc = sb.instantiateViewController(withIdentifier: vcIdentifier) as! RegistrationVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case "MainMenuVC":
            let vc = sb.instantiateViewController(withIdentifier: vcIdentifier) as! MainMenuVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            vc.usernameDataPass_MM = usernameTextField.text!
        default:
            print("Invalid VC")
        }
    }

// MARK: - Alert Function
    func logInAlert(alertTitle: String, alertMessage: String){
        let alertController = MDCAlertController(title: alertTitle, message: alertMessage)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        self.present(alertController, animated:true, completion: nil)
    }
}
// MARK: - Global Log functions
func GlobalLog_Load (vc_Log: String){
    NSLog("View Controller \(vc_Log) Loaded")
}

func GlobalLog_Display (vc_Log: String){
    NSLog("View Controller \(vc_Log) Appeared")
}

func GlobalLog_Dismiss (vc_Log: String){
    NSLog("View Controller \(vc_Log) Disappeared")
}



