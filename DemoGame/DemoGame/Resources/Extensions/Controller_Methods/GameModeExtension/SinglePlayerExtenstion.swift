//
//  SinglePlayerExtenstion.swift
//  DemoGame
//
//  Created by OPSolutions on 1/24/22.
//

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs

extension GameVC{
// MARK: - Single Player Name Initialization
    func initializePlayerNames_SP(){
        playerName.text = loggedInPlayer_SP
        playerName_Score.text = loggedInPlayer_SP
        player2Name.text = "RPSLS Bot"
        player2Name_Score.text = "RPSLS Bot"
    }
    
// MARK: - Single Player Tap Gesture
    func imageTapped_SP(tapGestureRecognizer: UITapGestureRecognizer){
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
            NSLog("Unrecognized Gesture")
        }
    }
    
// MARK: - Single Player Game Logic
    func botEngine(){
        let selectionDictionary = [0:"Rock", 1:"Paper", 2:"Scissors", 3:"Lizard", 4:"Spock"]
        let botSelectionDigit = Int.random(in: 0...4)
        botSelection = selectionDictionary[botSelectionDigit]!
        p2SelectedImage.image = UIImage(named: "\(botSelection).png")
    }
    
    func gameEngine_SP(playerInput: String, botInput: String){
        switch playerSelection {
        case "Rock":
            switch botSelection{
            case "Scissors":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Rock":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Paper":
            switch botSelection{
            case "Rock":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Paper":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Scissors":
            switch botSelection{
            case "Paper":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
            case "Lizard":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Lizard":
            switch botSelection{
            case "Paper":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot"
                botScoreValue += 1
                roundCounter += 1
            }
        case "Spock":
            switch botSelection{
            case "Rock":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "\(loggedInPlayer_SP)"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "Draw"
            default:
                roundResult = "RPSLS Bot"
                botScoreValue += 1
                roundCounter += 1
            }
        default:
            NSLog("Draw")
        }
        fightButton.isUserInteractionEnabled = true
        NSLog("Player: \(playerSelection) \n Bot: \(botSelection) \n Result: \(roundResult)")
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(botScoreValue)
        roundNumber.text = String(roundCounter)
        resultLabel.text = roundResult
    }
    
   
    
    func matchEnd_SP(counter: Int){
        if counter >= 10 && playerScoreValue != botScoreValue{
            matchResult = winnerSelect_SP()
            matchEndAlert()
        }
    }
    
    fileprivate func matchEndAlert() {
        let alertController = MDCAlertController(title: "Match Ended", message: matchResult)
        let action1 = MDCAlertAction(title:"Rematch") { (action) in self.matchReset_SP() }
        let action2 = MDCAlertAction(title:"Exit") { (action) in
            self.dismiss(animated: false, completion: nil)
            self.view.isUserInteractionEnabled = false}
        alertController.addAction(action2)
        alertController.addAction(action1)
        self.present(alertController, animated:true, completion: nil)
    }

    func winnerSelect_SP() -> String{
        if playerScoreValue > botScoreValue{
            matchResult = "\(loggedInPlayer_SP) Wins"
        }else{
            matchResult = "RSPLS Bot Wins"
        }
        return matchResult
    }
    
    func matchReset_SP(){
        playerScoreValue = 0
        roundCounter = 0
        botScoreValue = 0
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(botScoreValue)
        roundNumber.text = String(roundCounter)
    }
}
