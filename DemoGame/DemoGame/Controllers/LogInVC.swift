//
//  ViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

// MARK: - LogInVC imported libraries
import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialDialogs
import Firebase
import IQKeyboardManager

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

// MARK: - LogInVC
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
        logoImage.image = UIImage(named: "Logo.png")
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
        
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        usernameTextField.text = ""
        passwordTextField.text = ""
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
            self.screenTransition(vcIdentifier: "SinglePlayerVC", isFullScreen: true)
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        screenTransition(vcIdentifier: "RegistrationVC",isFullScreen: true)
    }
}
// MARK: - LogInVC Functions
extension LogInVC{
    func screenTransition (vcIdentifier: String, isFullScreen: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        if isFullScreen == true {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
    func logInAlert(alertTitle: String, alertMessage: String){
        let alertController = MDCAlertController(title: alertTitle, message: alertMessage)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        self.present(alertController, animated:true, completion: nil)
    }
}

