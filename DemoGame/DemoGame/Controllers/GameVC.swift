//
//  GameVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/19/22.
//

import UIKit
import MaterialComponents

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
    var gameMode: String = "Single Player"
    var multiplayerP2Name = "Default Username"
    var loggedInPlayer_G: [String: Any] = [:]
    
    //MARK: - Class variables
    let vcIdentifier = "SinglePlayerVC"
    var playerSelection: String = "Rock"
    var botSelection: String = "Rock"
    var roundResult: String = "Player Wins"
    var playerScoreValue: Int = 0
    var botScoreValue: Int = 0
    var roundCounter: Int = 0
    var matchResult: String = ""

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
        NSLog("\(loggedInPlayer_G)")
        addUIElementSubViews()
        initializeImageTapGestures()
        fightButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subviewLayout()
        initializePlayerNames()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        
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
