//
//  LogInExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
// MARK: - LogInVC Functions
extension LogInVC{
    // MARK: - Initialize Screen Elements
    func initializeScreenElements(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(screenTransitionRegister))
        logoImage.image = UIImage(named: "Logo.png")
        
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: - Log In Attempt
    func logInAttempt()
    {
        NSLog("Log in Attempted")
        guard usernameTextField.text?.isEmpty == false
                && passwordTextField.text?.isEmpty == false
        else{
            gameAlert(alertTitle: "Log In Error", alertMessage: "Empty username/Password")
            NSLog("Empty Username/Password")
            return
        }
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameTextField.text!)")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                self.gameAlert(alertTitle: "Log In Error", alertMessage: "Invalid User")
                NSLog("Invalid User")
                return
            }
            guard data["password"] as! String == self.passwordTextField.text!
            else{
                self.gameAlert(alertTitle: "Log In Error", alertMessage: "Incorrect Password")
                NSLog("Incorrect Password")
                return
            }
            NSLog("User: \(self.usernameTextField.text!) logged in")
            self.loggedInPlayer = data
            self.screenTransitionMainMenu()
        }
    }
    
    // MARK: - Screen Transition
    func screenTransitionMainMenu() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        vc.loggedInPlayer_SP = usernameTextField.text!
        vc.loggedInPlayer_MM = loggedInPlayer
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func screenTransitionRegister(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationVC")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Page Clear Function
    func pageClear(){
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
}
