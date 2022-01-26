//
//  MainMenuVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import FirebaseFirestore
import AVFoundation

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
    let rulesButton = UIView()
    let rulesButtonImage = UIImageView()
    let rulesButtonText = UILabel()
    
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
    var hostListner: ListenerRegistration?
    var guestListener: ListenerRegistration?
    var gameMode: String = ""
    var loggedInPlayer_SP = ""
    var menuMusicPlayer: AVAudioPlayer?
    
    // MARK: - MainMenuVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        playBackgroundAudio()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    
}
