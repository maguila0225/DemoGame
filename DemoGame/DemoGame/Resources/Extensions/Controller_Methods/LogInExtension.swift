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
    func screenTransitionMainMenu() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        vc.loggedInPlayer_MM = loggedInPlayer
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func screenTransitionRegister(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}
