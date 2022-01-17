//
//  SinglePlayerVCViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import MaterialComponents.MaterialAppBar

// MARK: - SinglePlayerVC
class SinglePlayerVC: UIViewController {
    // MARK: - SinglePlayerVC Declaration
    
    //MARK: - Screen Output Declaration
    @IBOutlet weak var p1SelectedImage: UIImageView!
    @IBOutlet weak var p2SelectedImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerName_Score: UILabel!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var botScore: UILabel!
    
    // MARK: - User Input Declaration
    @IBOutlet weak var rockButton: UIImageView!
    @IBOutlet weak var paperButton: UIImageView!
    @IBOutlet weak var scissorsButton: UIImageView!
    @IBOutlet weak var lizardButton: UIImageView!
    @IBOutlet weak var spockButton: UIImageView!
    @IBOutlet weak var fightButton: MDCButton!
    
    // MARK: -  Variables/Constants
    let vcIdentifier = "SinglePlayerVC"
    var playerSelection: String = "Rock"
    let selectionDictionary = [0:"Rock", 1:"Paper", 2:"Scissors", 3:"Lizard", 4:"Spock"]
    var botSelection: String = "Rock"
    var result: String = "Player Wins"
    var playerScoreValue: Int = 0
    var botScoreValue: Int = 0
    var roundCounter: Int = 0
    
    // MARK: - SinglePlayerVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        
        p1SelectedImage.image = UIImage(named: "Rock.png")
        p2SelectedImage.image = UIImage(named: "Spock.png")
        rockButton.image = UIImage(named: "Rock.png")
        paperButton.image = UIImage(named: "Paper.png")
        scissorsButton.image = UIImage(named: "Scissors.png")
        lizardButton.image = UIImage(named: "Lizard.png")
        spockButton.image = UIImage(named: "Spock.png")

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
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    // MARK: - SinglePlayerVC IBAction
    @IBAction func startFightButton(_ sender: Any) {
        let botSelectionDigit = Int.random(in: 0...4)
        botSelection = selectionDictionary[botSelectionDigit]!
        p2SelectedImage.image = UIImage(named: "\(botSelection).png")
        gameEngine(playerInput: playerSelection, botInput: botSelection)
    }
    
}
// MARK: - SinglePlayerVC functions
extension SinglePlayerVC{
    func screenTransition (vcIdentifier: String, isFullScreen: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        if isFullScreen == true {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
    
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
    
    func gameEngine(playerInput: String, botInput: String){
        switch playerSelection {
        case "Rock":
            switch botSelection{
            case "Scissors":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Rock":
                result = "Draw"
                roundCounter += 1
            default:
                result = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Paper":
            switch botSelection{
            case "Rock":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Paper":
                result = "Draw"
                roundCounter += 1
            default:
                result = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Scissors":
            switch botSelection{
            case "Paper":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                result = "Draw"
                roundCounter += 1
            default:
                result = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Lizard":
            switch botSelection{
            case "Paper":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                result = "Draw"
                roundCounter += 1
            default:
                result = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Spock":
            switch botSelection{
            case "Rock":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                result = "Player Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                result = "Draw"
                roundCounter += 1
            default:
                result = "RPSLS Bot Wins"
                botScoreValue += 1
                roundCounter += 1
            }
        default:
            print("Draw")
        }
        NSLog("Player: \(playerSelection) \n Bot: \(botSelection) \n Result: \(result)")
        playerScore.text = String(playerScoreValue)
        botScore.text = String(botScoreValue)
        resultLabel.text = result
    }
    
}

