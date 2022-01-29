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
            self.screenTransitionMainMenu()
        }
    }
    
    // MARK: - Screen Transition
    func screenTransitionMainMenu() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        vc.loggedInPlayer_SP = usernameTextField.text!
        vc.loggedInPlayer_MM = loggedInPlayer
        vc.menuMusicPlayer = menuMusicPlayer
        vc.bgImage = bgImage
        vc.spinner = spinner
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func screenTransitionRegister(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        vc.bgImage = bgImage
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: - Page Clear Function
    func pageClear(){
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    //MARK: - AudioPlayer
    func playBackgroundAudio(){
        if let menuMusicPlayer = menuMusicPlayer, menuMusicPlayer.isPlaying{
            print("Background audio is playing")
        }
        else {
            let urlString = Bundle.main.path(forResource: "Stardust", ofType: "mp3")
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                menuMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let menuMusicPlayer = menuMusicPlayer else{
                    return
                }
                menuMusicPlayer.volume = 0.5
                menuMusicPlayer.numberOfLoops = -1
                menuMusicPlayer.play()
            }
            catch{
                print("something went wrong with the audio player")
            }
        }
    }
}
