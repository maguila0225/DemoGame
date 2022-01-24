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
    var loggedInPlayer_SP = ""
    var loggedInPlayer: [String: Any] = [:]
    
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
        logInAttempt()
    }
}



