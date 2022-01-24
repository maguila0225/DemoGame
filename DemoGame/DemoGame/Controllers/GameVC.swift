//
//  GameVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/19/22.
//

import UIKit
import MaterialComponents
import FirebaseFirestore

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
    var loggedInPlayer_G: [String: Any] = [:]
    let firestoreDatabase = Firestore.firestore()
    
    //MARK: - Class variables
    let vcIdentifier = "GameVC"
    var playerSelection: String = "Rock"
    var player2Selection: String = "Rock"
    var botSelection: String = "Rock"
    var roundResult: String = "Result"
    var playerScoreValue: Int = 0
    var botScoreValue: Int = 0
    var roundCounter: Int = 0
    var matchResult: String = ""
    var screenUpdateListener: ListenerRegistration?
    var room: String = ""

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
        fightButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subviewLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        initializePlayerNames()
        let screenListener = addScreenUpdateListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
        
    }
    
    //MARK: - IBAction
    @objc func buttonClicked(){
        NSLog("button Clicked")
        if gameMode == "Single Player"{
            botEngine()
            gameEngine(playerInput: playerSelection, botInput: botSelection)
            matchEnd(counter: roundCounter)
        }
        else if gameMode == "Multiplayer"{
            NSLog("Multiplayer")
        }
    }
}
