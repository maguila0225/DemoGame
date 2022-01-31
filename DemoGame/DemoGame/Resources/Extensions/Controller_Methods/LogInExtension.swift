//
//  LogInExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import AVFoundation

// MARK: - LogInVC Functions
extension LogInVC{
    // MARK: - Initialize Screen Elements
    func initializeScreenElements(){
        logoImage.image = UIImage(named: "Logo.png")
        
        usernameTextField.label.text = "Username"
        usernameTextField.leadingAssistiveLabel.text = ""
        
        passwordTextField.label.text = "Password"
        passwordTextField.leadingAssistiveLabel.text = ""
        passwordTextField.isSecureTextEntry = true
        spinner.isHidden = true
        spinner.backgroundColor = .systemBackground.withAlphaComponent(0.9)
        spinner.sizeToFit()
        if self.traitCollection.userInterfaceStyle == .dark{
            bgImage = "DarkModeBG.jpeg"
            logInButton.backgroundColor = .systemRed
            spinner.tintColor = .systemRed
        }
        else{
            bgImage = "LightModeBG.jpeg"
            logInButton.backgroundColor = .systemBlue
            spinner.tintColor = .systemBlue
        }
        backgroundImage.image = UIImage(named: bgImage)
    }
    
    // MARK: - Log In Attempt
    func logInAttempt()
    {
        spinner.startAnimating()
        spinner.isHidden = false
        NSLog("Log in Attempted")
        guard usernameTextField.text?.isEmpty == false
                && passwordTextField.text?.isEmpty == false
        else{
            spinner.isHidden = true
            gameAlert(alertTitle: "Log In Error", alertMessage: "Empty username/Password")
            NSLog("Empty Username/Password")
            return
        }
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameTextField.text!)")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                self.spinner.isHidden = true
                self.gameAlert(alertTitle: "Log In Error", alertMessage: "Invalid User")
                NSLog("Invalid User")
                return
            }
            guard data["password"] as! String == self.passwordTextField.text!
            else{
                self.spinner.isHidden = true
                self.gameAlert(alertTitle: "Log In Error", alertMessage: "Incorrect Password")
                NSLog("Incorrect Password")
                return
            }
            NSLog("User: \(self.usernameTextField.text!) logged in")
            self.loggedInPlayer = data
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            UserDefaults.standard.set(self.usernameTextField.text, forKey: "demoGameUsername")
            UserDefaults.standard.synchronize()
            NSLog("Login Screen: isSignedIn: \(UserDefaults.standard.set(true, forKey: "demoGameIsSignedIn"))")
            self.screenTransitionMainMenu()
        }
    }
    
    // MARK: - Screen Transition
    func screenTransitionMainMenu() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        vc.spinner = spinner
        vc.menuMusicPlayer = menuMusicPlayer
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }

    func screenTransitionRegister(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        vc.bgImage = bgImage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    //MARK: - Page Clear Function
    func pageClear(){
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
}
