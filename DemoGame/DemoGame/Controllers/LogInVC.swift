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
import AVFoundation

class LogInVC: UIViewController {
    let vcIdentifier: String = "LogInVC"
    
    // MARK: - LogInVC variable declaration
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var loggedInPlayer_SP = ""
    var loggedInPlayer: [String: Any] = [:]
    var menuMusicPlayer: AVAudioPlayer?
    
    let firestoreDatabase = Firestore.firestore()
    // MARK: - LogInVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        initializeScreenElements()
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        playBackgroundAudio()
        pageClear()
        spinner.isHidden = true
        spinner.stopAnimating()
    }

    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    // MARK: - LogInVC IBAction
    @IBAction func logInAttempt(_ sender: Any) {
        logInAttempt()
    }
}



