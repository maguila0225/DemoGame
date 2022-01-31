//
//  RegistrationVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/15/22.
//

import UIKit
import MaterialComponents.MDCOutlinedTextField
import MaterialComponents.MaterialButtons
import FirebaseFirestore
import IQKeyboardManager

class RegistrationVC: UIViewController {
    
    // MARK: - RegistrationVC IBOutlet Declaration
    @IBOutlet weak var usernameRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordRegistration: MDCOutlinedTextField!
    @IBOutlet weak var passwordConfirmation: MDCOutlinedTextField!
    var backgroundImage = UIImageView()
    @IBOutlet weak var registerButton: MDCButton!
    // MARK: - Variable/Constant Declaration
    let vcIdentifier = "RegistrationVC"
    let firestoreDatabase = Firestore.firestore()
    var playerID: String = ""
    var newPlayer = Player()
    var bgImage = ""
    
    // MARK: - RegistrationVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        initializeScreenElements()
    }
    
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        setupBackground()
        pageClear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    
    // MARK: - RegistrationVC IBAction
    @IBAction func registerUser(_ sender: Any) {
        registerAttempt()
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
    
    
