//
//  ViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
// MARK: - Global Log functions
func GlobalLog_Load (vc_Log: String){
    NSLog("View Controller \(vc_Log) Loaded")
}

func GlobalLog_Display (vc_Log: String){
    NSLog("View Controller \(vc_Log) Loaded")
}

func GlobalLog_Dismiss (vc_Log: String){
    NSLog("View Controller \(vc_Log) Loaded")
}

// MARK: - Log In Screen View Controller
class LogInVC: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImage.image = UIImage(named: "Logo.png")
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
        
    }
    override func  viewWillAppear(_ animated: Bool) {
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    @IBAction func logInAttempt(_ sender: Any) {
        NSLog("Log in Attempted")
    }
    @IBAction func registerButton(_ sender: Any) {
        screenTransition(vcIdentifier: "RegistrationVC",isFullScreen: true)
    }
}

extension LogInVC{
    public func screenTransition (vcIdentifier: String, isFullScreen: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        if isFullScreen == true {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
}

