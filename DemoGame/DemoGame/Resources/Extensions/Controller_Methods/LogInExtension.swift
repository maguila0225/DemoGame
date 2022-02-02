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
        themeSelect()
        backgroundImage.image = UIImage(named: bgImage)
        layoutCurtains()
        curtains.isHidden = true
    }
    
    fileprivate func themeSelect() {
        if self.traitCollection.userInterfaceStyle == .dark{
            bgImage = "DarkModeBG.jpeg"
            logInButton.backgroundColor = .systemRed
        }
        else{
            bgImage = "LightModeBG.jpeg"
            logInButton.backgroundColor = .systemBlue
        }
    }
    
    func layoutCurtains(){
        curtains.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        curtains.backgroundColor = .systemBackground
        curtainsImage.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        curtainsImage.center = curtains.center
        curtainsImage.image = UIImage(named: "Logo.png")
        curtainsText.text = "LOADING"
        curtainsText.frame = CGRect(x: (view.frame.size.width - 200) / 2,
                                    y: curtainsImage.bottom + 10,
                                    width: 200,
                                    height: 30)
        curtainsText.font = .systemFont(ofSize: 30, weight: .heavy)
        curtainsText.textAlignment = .center
        view.addSubview(curtains)
        curtains.addSubview(curtainsImage)
        curtains.addSubview(curtainsText)
        
        view.bringSubviewToFront(curtains)
    }
    
    // MARK: - Log In Attempt
    func logInAttempt()
    {
        curtains.isHidden = false
        NSLog("Log in Attempted")
        guard usernameTextField.text?.isEmpty == false
                && passwordTextField.text?.isEmpty == false
        else{
            curtains.isHidden = true
            gameAlert(alertTitle: "Log In Error", alertMessage: "Empty username/Password")
            NSLog("Empty Username/Password")
            return
        }
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameTextField.text!)")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                self.curtains.isHidden = true
                self.gameAlert(alertTitle: "Log In Error", alertMessage: "Invalid User")
                NSLog("Invalid User")
                return
            }
            guard data["password"] as! String == self.passwordTextField.text!
            else{
                self.curtains.isHidden = true
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
        vc.menuMusicPlayer = menuMusicPlayer
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: false)
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
