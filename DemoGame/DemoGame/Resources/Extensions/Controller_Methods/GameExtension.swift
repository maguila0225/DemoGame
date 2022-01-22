//
//  GameExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs

extension GameVC{
    // MARK: - Add UI Element Subviews
    func addUIElementSubViews(){
        view.addSubview(playerName)
        view.addSubview(player2Name)
        view.addSubview(p1SelectedImage)
        view.addSubview(p2SelectedImage)
        view.addSubview(resultLabel)
        view.addSubview(playerName_Score)
        view.addSubview(roundName)
        view.addSubview(player2Name_Score)
        view.addSubview(playerScore)
        view.addSubview(roundNumber)
        view.addSubview(player2Score)
        view.addSubview(CYF)
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
        view.addSubview(lizardButton)
        view.addSubview(spockButton)
        view.addSubview(fightButton)
    }
    //MARK: - Subview Layout
    func subviewLayout(){
        let screenHeight = view.frame.size.height
        let screenWidth = view.frame.size.width
        textSubviewLayout(labelName: playerName,
                          xOrigin: 5,
                          yOrigin: 0.05 * screenHeight,
                          labelWidth: 0.5 * (screenWidth - 10),
                          labelHeight: 0.05 * screenHeight,
                          contents: "Player 1",
                          fontSize: 0.5 * screenHeight * 0.05)
        
        textSubviewLayout(labelName: player2Name,
                          xOrigin: playerName.right,
                          yOrigin: 0.05 * screenHeight,
                          labelWidth: 0.5 * (screenWidth - 10),
                          labelHeight: 0.05 * screenHeight,
                          contents: "Player 2",
                          fontSize: 0.5 * screenHeight * 0.05)
        
        imageSubviewLayout(displayName: p1SelectedImage,
                           xOrigin: 2.5,
                           yOrigin: playerName.bottom + 3,
                           displayWidth: 0.5 * (screenWidth - 10),
                           displayHeight: 0.5 * (screenWidth - 10),
                           imageName: "Rock.png")
        
        imageSubviewLayout(displayName: p2SelectedImage,
                           xOrigin: p1SelectedImage.right + 5,
                           yOrigin: playerName.bottom + 3,
                           displayWidth: 0.5 * (screenWidth - 10),
                           displayHeight: 0.5 * (screenWidth - 10),
                           imageName: "Spock.png")
        
        textSubviewLayout(labelName: resultLabel,
                          xOrigin: 5,
                          yOrigin: p1SelectedImage.bottom,
                          labelWidth: screenWidth - 10,
                          labelHeight: 0.1 * screenHeight,
                          contents: "RESULT",
                          fontSize: 0.5 * screenHeight * 0.1)
        
        textSubviewLayout(labelName: playerName_Score,
                          xOrigin: 5,
                          yOrigin: resultLabel.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "Player 1",
                          fontSize: 0.5 * screenHeight * 0.05)
        
        textSubviewLayout(labelName: roundName,
                          xOrigin: playerName_Score.right,
                          yOrigin: resultLabel.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "Round",
                          fontSize: 0.5 * screenHeight * 0.05)
        
        textSubviewLayout(labelName: player2Name_Score,
                          xOrigin: roundName.right,
                          yOrigin: resultLabel.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "Player 2",
                          fontSize: 0.5 * screenHeight * 0.05)
        
        textSubviewLayout(labelName: playerScore,
                          xOrigin: 5,
                          yOrigin: player2Name_Score.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "0",
                          fontSize: 0.5 * screenHeight * 0.1)
        
        textSubviewLayout(labelName: roundNumber,
                          xOrigin: playerScore.right,
                          yOrigin: player2Name_Score.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "0",
                          fontSize: 0.5 * screenHeight * 0.1)
        
        textSubviewLayout(labelName: player2Score,
                          xOrigin: roundNumber.right,
                          yOrigin: player2Name_Score.bottom,
                          labelWidth: (screenWidth - 10) / 3,
                          labelHeight: 0.05 * screenHeight,
                          contents: "0",
                          fontSize: 0.5 * screenHeight * 0.1)
        
        textSubviewLayout(labelName: CYF,
                          xOrigin: 5,
                          yOrigin: player2Score.bottom + (screenHeight * 0.13),
                          labelWidth: screenWidth - 10,
                          labelHeight: 0.05 * screenHeight,
                          contents: "CHOOSE YOUR FIGHTER",
                          fontSize: screenHeight * 0.04 * 0.7)
        
        imageSubviewLayout(displayName: rockButton,
                           xOrigin: 5,
                           yOrigin: CYF.bottom + 3,
                           displayWidth: (screenWidth - 10) / 5,
                           displayHeight: (screenWidth - 10) / 5,
                           imageName: "Rock.png")
        imageSubviewLayout(displayName: paperButton,
                           xOrigin: rockButton.right + 1,
                           yOrigin: CYF.bottom + 3,
                           displayWidth: (screenWidth - 10) / 5,
                           displayHeight: (screenWidth - 10) / 5,
                           imageName: "Paper.png")
        imageSubviewLayout(displayName: scissorsButton,
                           xOrigin: paperButton.right + 1,
                           yOrigin: CYF.bottom + 3,
                           displayWidth: (screenWidth - 10) / 5,
                           displayHeight: (screenWidth - 10) / 5,
                           imageName: "Scissors.png")
        imageSubviewLayout(displayName: lizardButton,
                           xOrigin: scissorsButton.right + 1,
                           yOrigin: CYF.bottom + 3,
                           displayWidth: (screenWidth - 10) / 5,
                           displayHeight: (screenWidth - 10) / 5,
                           imageName: "Lizard.png")
        imageSubviewLayout(displayName: spockButton,
                           xOrigin: lizardButton.right + 1,
                           yOrigin: CYF.bottom + 3,
                           displayWidth: (screenWidth - 10) / 5,
                           displayHeight: (screenWidth - 10) / 5,
                           imageName: "Spock.png")
        
        fightButton.frame = CGRect(x: 5,
                                   y: spockButton.bottom + 8,
                                   width: screenWidth - 10,
                                   height: screenHeight * 0.05)
        fightButton.setTitle("Fight", for: .normal)
        fightButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        fightButton.layer.cornerRadius = 12
        
    }
    //MARK: - Layout Functions
    func textSubviewLayout(labelName: UILabel, xOrigin: Double, yOrigin: Double, labelWidth: Double, labelHeight: Double, contents: String, fontSize: Double){
        labelName.frame = CGRect(x: xOrigin,
                                 y: yOrigin,
                                 width: labelWidth,
                                 height: labelHeight)
        labelName.text = contents
        labelName.font = UIFont(name: "Verdana-Bold", size: fontSize)
        labelName.textAlignment = .center
        
    }
    func imageSubviewLayout(displayName: UIImageView, xOrigin: Double, yOrigin: Double, displayWidth: Double, displayHeight: Double, imageName: String){
        displayName.frame = CGRect(x: xOrigin,
                                   y: yOrigin,
                                   width: displayWidth,
                                   height: displayHeight)
        displayName.image = UIImage(named: imageName)
        displayName.contentMode = .scaleAspectFit
    }
    //MARK: - Initialize Values
    func initializePlayerNames(){
        playerName.text = loggedInPlayer_G["username"] as? String
        playerName_Score.text = loggedInPlayer_G["username"] as? String
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
    
    func gameEngine(playerInput: String, botInput: String){
        switch playerSelection {
        case "Rock":
            switch botSelection{
            case "Scissors":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
                playerScoreValue += 1
            case "Lizard":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
            NSLog("Draw")
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
            matchResult = "\((loggedInPlayer_G["username"] as? String) ?? "Player") Wins"
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
