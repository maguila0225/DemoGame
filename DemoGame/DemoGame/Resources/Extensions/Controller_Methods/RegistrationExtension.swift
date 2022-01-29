//
//  RegistrationExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit

extension RegistrationVC{
// MARK: - Screen Initialization Functions
    func initializeScreenElements(){
        title = "Create User"
        
        usernameRegistration.label.text = "Username"
        usernameRegistration.leadingAssistiveLabel.text = ""
        
        passwordRegistration.label.text = "Password"
        passwordRegistration.leadingAssistiveLabel.text = ""
        passwordRegistration.isSecureTextEntry = true
        
        passwordConfirmation.label.text = "Password"
        passwordConfirmation.leadingAssistiveLabel.text = ""
        passwordConfirmation.isSecureTextEntry = true
        
        backgroundImage.image = UIImage(named: bgImage)
        
        if self.traitCollection.userInterfaceStyle == .dark{
            registerButton.backgroundColor = .systemRed
        }
        else{
            registerButton.backgroundColor = .systemBlue
        }
    }

//MARK: - Register Attempt
    func registerAttempt(){
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
    
// MARK: - Screen Transition Function
    func registerUser(username: String, password: String){
        let documentReference = firestoreDatabase.document("playerDatabase/\(usernameRegistration.text!)")
        documentReference.getDocument { snapshot, error in
            if error == nil {
                guard snapshot?.data() == nil else{
                    self.gameAlert(alertTitle: "Registration Error", alertMessage: "User Already Exists")
                    NSLog("User Already Exists")
                    return
                }
                self.newPlayer.username = username
                self.newPlayer.password = password
                self.gameAlert(alertTitle: "Registration Successful", alertMessage: "Proceed to Log In")
                NSLog("\(self.usernameRegistration.text!):\(self.passwordConfirmation.text!) Registered")
                let encodedPlayer = self.encodePlayer(inputPlayer: self.newPlayer)
                documentReference.setData(encodedPlayer)
                NSLog("\(encodedPlayer)")
            }
        }
    }
   
    // MARK: - Page Clear Functions
        func pageClear(){
            usernameRegistration.text = ""
            passwordRegistration.text = ""
            passwordConfirmation.text = ""
        }
}

