//
//  MainMenuVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import FirebaseFirestore

class MainMenuVC: UIViewController {
    // MARK: - UI Element Declaration
    let imageView = UIImageView()
    let onePlayerButton = UIView()
    let onePlayerButtonImage = UIImageView()
    let onePlayerButtonText = UILabel()
    let multiplayerButton = UIView()
    let multiplayerButtonImage = UIImageView()
    let multiplayerButtonText = UILabel()
    let leaderboardButton = UIView()
    let leaderboardButtonImage = UIImageView()
    let leaderboardButtonText = UILabel()
    let profileButton = UIView()
    let profileButtonImage = UIImageView()
    let profileButtonText = UILabel()
    
    // MARK: - Gesture Recognizer Declaration
    var singlePlayerSelect = UIGestureRecognizer()
    var multiplayerSelect = UIGestureRecognizer()
    var leaderboardSelect = UIGestureRecognizer()
    var profileSelect = UIGestureRecognizer()
    
    // MARK: - Class Variable/Constant Declaration
    let vcIdentifier: String = "MainMenuVC"
    var loggedInPlayer_MM: [String: Any] = [:]
    let firestoreDatabase = Firestore.firestore()
    var room: String = ""
    var role: String = ""
    var multiplayerGame = MultiplayerGame()

    // MARK: - MainMenuVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Menu"
        GlobalLog_Load(vc_Log: vcIdentifier)
        initializeUIElements()
        addUIElementSubViews()
        initializeImageTapGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subviewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
}
