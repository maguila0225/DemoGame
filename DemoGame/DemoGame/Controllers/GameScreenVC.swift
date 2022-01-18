//
//  SinglePlayerVCViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialDialogs

class GameScreenVC: UIViewController {
    
    //MARK: - Screen Output Declaration
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var p1SelectedImage: UIImageView!
    @IBOutlet weak var playerName_Score: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    
    @IBOutlet weak var player2Name: UILabel!
    @IBOutlet weak var p2SelectedImage: UIImageView!
    @IBOutlet weak var player2Name_Score: UILabel!
    @IBOutlet weak var player2Score: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var roundNumber: UILabel!
    
    // MARK: - User Input Declaration
    @IBOutlet weak var rockButton: UIImageView!
    @IBOutlet weak var paperButton: UIImageView!
    @IBOutlet weak var scissorsButton: UIImageView!
    @IBOutlet weak var lizardButton: UIImageView!
    @IBOutlet weak var spockButton: UIImageView!
    @IBOutlet weak var fightButton: MDCButton!
    
    // MARK: -  Variables/Constants
    
    //MARK: - Variables Passed in
    var gameMode: String = ""
    var usernameDataPass_GS = "Default Username"
    var multiplayerP2Name = "Default Username"
    
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
    
    // MARK: - SinglePlayerVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        initializeImages()
        initializePlayerNames()
        initializeImageTapGestures()
    }
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    
    // MARK: - SinglePlayerVC IBAction
    @IBAction func startFightButton(_ sender: Any) {
        
        if gameMode == "Single Player"{
            botEngine()
            gameEngine(playerInput: playerSelection, botInput: botSelection)
            matchEnd(counter: roundCounter)
        }
        else if gameMode == "Multiplayer"{
            
        }
    }
}

// MARK: - SinglePlayerVC functions
extension GameScreenVC{
    // MARK: - Screen Initialize Functions
    func initializeImages(){
        p1SelectedImage.image = UIImage(named: "Rock.png")
        p2SelectedImage.image = UIImage(named: "Rock.png")
        rockButton.image = UIImage(named: "Rock.png")
        paperButton.image = UIImage(named: "Paper.png")
        scissorsButton.image = UIImage(named: "Scissors.png")
        lizardButton.image = UIImage(named: "Lizard.png")
        spockButton.image = UIImage(named: "Spock.png")
    }
    
    func initializePlayerNames(){
        playerName.text = usernameDataPass_GS
        playerName_Score.text = usernameDataPass_GS
        switch gameMode{
        case "Single Player":
            player2Name.text = "RPSLS Bot"
            player2Name_Score.text = "RPSLS Bot"
        case "Multiplayer":
            player2Name.text = multiplayerP2Name
            player2Name_Score.text = multiplayerP2Name
        default:
            player2Name.text = "Player 2"
            player2Name_Score.text = "Player 2"
        }
    }
    
    func initializeImageTapGestures(){
        rockSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        rockButton.isUserInteractionEnabled = true
        rockButton.addGestureRecognizer(rockSelect)
        
        paperSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        paperButton.isUserInteractionEnabled = true
        paperButton.addGestureRecognizer(paperSelect)
        
        scissorsSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        scissorsButton.isUserInteractionEnabled = true
        scissorsButton.addGestureRecognizer(scissorsSelect)
        
        lizardSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        lizardButton.isUserInteractionEnabled = true
        lizardButton.addGestureRecognizer(lizardSelect)
        
        spockSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        spockButton.isUserInteractionEnabled = true
        spockButton.addGestureRecognizer(spockSelect)
    }
    
    // MARK: - Tap Gesture Functions
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        switch tapGestureRecognizer{
        case rockSelect:
            playerSelection = "Rock"
            p1SelectedImage.image = UIImage(named: "Rock.png")
        case paperSelect:
            playerSelection = "Paper"
            p1SelectedImage.image = UIImage(named: "Paper.png")
        case scissorsSelect:
            playerSelection = "Scissors"
            p1SelectedImage.image = UIImage(named: "Scissors.png")
        case lizardSelect:
            playerSelection = "Lizard"
            p1SelectedImage.image = UIImage(named: "Lizard.png")
        case spockSelect:
            playerSelection = "Spock"
            p1SelectedImage.image = UIImage(named: "Spock.png")
        default:
            print("Unrecognized Gesture")
        }
    }
    
    // MARK: - Single Player Game Logic
    func botEngine(){
        let selectionDictionary = [0:"Rock", 1:"Paper", 2:"Scissors", 3:"Lizard", 4:"Spock"]
        let botSelectionDigit = Int.random(in: 0...4)
        botSelection = selectionDictionary[botSelectionDigit]!
        p2SelectedImage.image = UIImage(named: "\(botSelection).png")
    }
    
    func gameEngine(playerInput: String, botInput: String){
        switch playerSelection {
        case "Rock":
            switch botSelection{
            case "Scissors":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Rock":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Paper":
            switch botSelection{
            case "Rock":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Paper":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Scissors":
            switch botSelection{
            case "Paper":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
            case "Lizard":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Lizard":
            switch botSelection{
            case "Paper":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Spock":
            switch botSelection{
            case "Rock":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "\(usernameDataPass_GS) Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        default:
            print("Draw")
        }
        NSLog("Player: \(playerSelection) \n Bot: \(botSelection) \n Result: \(roundResult)")
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(botScoreValue)
        roundNumber.text = String(roundCounter)
        resultLabel.text = roundResult
    }
    
    func matchEnd(counter: Int){
        if counter >= 10 && playerScoreValue != botScoreValue{
            matchResult = winnerSelect()
            let alertController = MDCAlertController(title: "Match Ended", message: matchResult)
            let action1 = MDCAlertAction(title:"Rematch") { (action) in self.matchReset() }
            let action2 = MDCAlertAction(title:"Exit") { (action) in (self.dismiss(animated: false, completion: nil))}
            alertController.addAction(action2)
            alertController.addAction(action1)
            self.present(alertController, animated:true, completion: nil)
        }
    }
    
    func winnerSelect() -> String{
        if playerScoreValue > botScoreValue{
            matchResult = "\(usernameDataPass_GS) Wins"
        }else{
            matchResult = "RSPLS Bot Wins"
        }
        return matchResult
    }
    
    func matchReset(){
        playerScoreValue = 0
        roundCounter = 0
        botScoreValue = 0
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(botScoreValue)
        roundNumber.text = String(roundCounter)
    }
    
}


