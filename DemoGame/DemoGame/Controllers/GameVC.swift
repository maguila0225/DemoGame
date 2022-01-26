//
//  GameVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/19/22.
//

import UIKit
import MaterialComponents
import FirebaseFirestore
import AVFAudio

class GameVC: UIViewController {
    // MARK: UI Element Declaration
    let playerName = UILabel()
    let player2Name = UILabel()
    let p1SelectedImage = UIImageView()
    let p2SelectedImage = UIImageView()
    let resultLabel = UILabel()
    let playerName_Score = UILabel()
    let roundName = UILabel()
    let player2Name_Score = UILabel()
    let playerScore = UILabel()
    let roundNumber = UILabel()
    let player2Score = UILabel()
    let CYF = UILabel()
    let rockButton = UIImageView()
    let paperButton = UIImageView()
    let scissorsButton = UIImageView()
    let lizardButton = UIImageView()
    let spockButton = UIImageView()
    let fightButton = MDCButton()
    
    //MARK: - Variables Passed in
    var gameMode: String = ""
    var role = ""
    var gameRoomData: [String: Any] = [:]
    var loggedInPlayer_G: [String: Any] = [:]
    let firestoreDatabase = Firestore.firestore()
    var loggedInPlayer_SP = ""
    
    //MARK: - Class variables
    let vcIdentifier = "GameVC"
    var playerSelection: String = "Rock"
    var playerScoreValue: Int = 0
    var player2Selection: String = "Rock"
    var player2ScoreValue: Int = 0
    var botSelection: String = "Rock"
    var botScoreValue: Int = 0
    var roundResult: String = "Result"
    var roundCounter: Int = 0
    var matchResult: String = ""
    var room: String = ""
    var screenUpdateListener: ListenerRegistration?
    var gameMusicPlayer: AVAudioPlayer?
    
    
    // MARK: - Gesture Recognizers
    var rockSelect = UIGestureRecognizer()
    var paperSelect = UIGestureRecognizer()
    var scissorsSelect = UIGestureRecognizer()
    var lizardSelect = UIGestureRecognizer()
    var spockSelect = UIGestureRecognizer()
    
    
    //MARK: - GameVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        addUIElementSubViews()
        initializeImageTapGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subviewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        initializePlayerName()
        initializeInputRoom()
        playGameAudio()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
        screenUpdateListener?.remove()
        gameMusicPlayer!.stop()
    }
    
}
