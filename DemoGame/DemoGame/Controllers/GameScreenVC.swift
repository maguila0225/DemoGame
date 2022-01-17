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
    let vcIdentifier = "SinglePlayerVC"
    let selectionDictionary = [0:"Rock", 1:"Paper", 2:"Scissors", 3:"Lizard", 4:"Spock"]
    var playerSelection: String = "Rock"
    var botSelection: String = "Rock"
    var roundResult: String = "Player Wins"
    var playerScoreValue: Int = 0
    var botScoreValue: Int = 0
    var roundCounter: Int = 0
    var matchResult: String = ""
    var gameMode: String = ""
    var usernameDataPass_GS = "Default Username"
    var multiplayerP2Name = "Default Username"
    
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
            let rockSelect = UITapGestureRecognizer(target: self, action: #selector(rockTapped(tapGestureRecognizer:)))
            rockButton.isUserInteractionEnabled = true
            rockButton.addGestureRecognizer(rockSelect)
            
            let paperSelect = UITapGestureRecognizer(target: self, action: #selector(paperTapped(tapGestureRecognizer:)))
            paperButton.isUserInteractionEnabled = true
            paperButton.addGestureRecognizer(paperSelect)
            
            let scissorsSelect = UITapGestureRecognizer(target: self, action: #selector(scissorsTapped(tapGestureRecognizer:)))
            scissorsButton.isUserInteractionEnabled = true
            scissorsButton.addGestureRecognizer(scissorsSelect)
            
            let lizardSelect = UITapGestureRecognizer(target: self, action: #selector(lizardTapped(tapGestureRecognizer:)))
            lizardButton.isUserInteractionEnabled = true
            lizardButton.addGestureRecognizer(lizardSelect)
            
            let spockSelect = UITapGestureRecognizer(target: self, action: #selector(spockTapped(tapGestureRecognizer:)))
            spockButton.isUserInteractionEnabled = true
            spockButton.addGestureRecognizer(spockSelect)
        }

    // MARK: - Tap Gesture Functions
    @objc func rockTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playerSelection = "Rock"
        p1SelectedImage.image = UIImage(named: "Rock.png")
    }
    @objc func paperTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playerSelection = "Paper"
        p1SelectedImage.image = UIImage(named: "Paper.png")
    }
    @objc func scissorsTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playerSelection = "Scissors"
        p1SelectedImage.image = UIImage(named: "Scissors.png")
    }
    @objc func lizardTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playerSelection = "Lizard"
        p1SelectedImage.image = UIImage(named: "Lizard.png")
    }
    @objc func spockTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        playerSelection = "Spock"
        p1SelectedImage.image = UIImage(named: "Spock.png")
    }
    
    // MARK: - Single Player Game Logic
    func botEngine(){
        let botSelectionDigit = Int.random(in: 0...4)
        botSelection = selectionDictionary[botSelectionDigit]!
        p2SelectedImage.image = UIImage(named: "\(botSelection).png")
    }
    func gameEngine(playerInput: String, botInput: String){
        switch playerSelection {
        case "Rock":
            switch botSelection{
            case "Scissors":
                roundResult = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "Player Wins"
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
                roundResult = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "Player Wins"
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
                roundResult = "Player Wins"
                playerScoreValue += 1
            case "Lizard":
                roundResult = "Player Wins"
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
                roundResult = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "Player Wins"
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
                roundResult = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "Player Wins"
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
    
    func winnerSelect() -> String{
        if playerScoreValue > botScoreValue{
            matchResult = "Player Wins"
        }else{
            matchResult = "RSPLS Bot Wins"
        }
        return matchResult
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
    
    func matchReset(){
        playerScoreValue = 0
        roundCounter = 0
        botScoreValue = 0
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(botScoreValue)
        roundNumber.text = String(roundCounter)
    }

}

                     
