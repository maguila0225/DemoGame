//
//  MultiplayerExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/24/22.
//

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs
import FirebaseFirestore

extension GameVC{
    // MARK: - Multiplayer Name Initialization
    func initializePlayerNames_MP(){
        playerName.text = loggedInPlayer_G["hostName"] as? String
        playerName_Score.text = loggedInPlayer_G["hostName"] as? String
        player2Name.text = loggedInPlayer_G["guestName"] as? String
        player2Name_Score.text = loggedInPlayer_G["guestName"] as? String
    }
    
    // MARK: - Inpitialize Input Room
    func initializeInputRoom(){
        if gameMode == "Multiplayer"{
            let inputRoom = "input" + (loggedInPlayer_G["room"] as! String)
            let collectionReference = firestoreDatabase.collection("multiplayerRoom")
            collectionReference.document(inputRoom).setData(["guestInputCheck":"Empty"])
            collectionReference.document(inputRoom).updateData(["hostInputCheck":"Empty"])
        }
    }
    
    // MARK: - Add Screen Update Listener
    func addScreenUpdateListener() -> ListenerRegistration{
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        screenUpdateListener = firestoreDatabase.collection("multiplayerRoom").whereField("room", isEqualTo: self.room)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .modified) {
                        docRef.getDocument{ snapshot, error in
                            guard let data = snapshot?.data(), error == nil else{
                                NSLog("\(String(describing: error))")
                                return
                            }
                            self.p1SelectedImage.image = UIImage(named: (data["hostSelection"] as! String) + ".png")
                            self.p2SelectedImage.image = UIImage(named: (data["guestSelection"] as! String) + ".png")
                            self.resultLabel.text = data["roundResult"] as? String
                            self.roundNumber.text = data["roundNumber"] as? String
                            self.playerScore.text = data["hostScore"] as? String
                            self.player2Score.text = data["guestScore"] as? String
                        }
                    }
                }
            }
        return screenUpdateListener!
    }
    
    //MARK: - Gesture Recognizer
    func imageTapped_MP(tapGestureRecognizer: UITapGestureRecognizer){
        switch role{
        case "host":
            hostImageTapped(tapGestureRecognizer)
        case "guest":
            guestImageTapped(tapGestureRecognizer)
        default:
            NSLog("Invalid Role")
        }
    }
    
    fileprivate func hostImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
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
            NSLog("Invalid Selection")
        }
    }
    
    fileprivate func guestImageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        switch tapGestureRecognizer{
        case rockSelect:
            player2Selection = "Rock"
            p2SelectedImage.image = UIImage(named: "Rock.png")
        case paperSelect:
            player2Selection = "Paper"
            p2SelectedImage.image = UIImage(named: "Paper.png")
        case scissorsSelect:
            player2Selection = "Scissors"
            p2SelectedImage.image = UIImage(named: "Scissors.png")
        case lizardSelect:
            player2Selection = "Lizard"
            p2SelectedImage.image = UIImage(named: "Lizard.png")
        case spockSelect:
            player2Selection = "Spock"
            p2SelectedImage.image = UIImage(named: "Spock.png")
        default:
            NSLog("Invalid Selection")
        }
    }
    //MARK: - Multipalyer Game Logic
    func gameEngine_MP(){
        updatePlayerInputs()
    }

    func updatePlayerInputs(){
        let inputRoom = "input" + (loggedInPlayer_G["room"] as! String)
        let docRef = firestoreDatabase.document("multiplayerRoom/\(inputRoom)")
        switch role{
        case "host":
            hostUpdateScreen(docRef)
        case "guest":
            guestUpdateScreen(docRef)
        default:
            NSLog("Invalid Role")
        }
    }
    
    fileprivate func hostUpdateScreen(_ docRef: DocumentReference) {
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            if (data["guestInputCheck"] as! String) == "Empty"{
                docRef.updateData(["hostInputCheck":self.playerSelection])
            } else {
                self.updateHostInput(docRef: self.firestoreDatabase.document("multiplayerRoom/\(self.room)"))
                self.player2Selection = (data["guestInputCheck"] as! String)
                self.updateGuestInput(docRef: self.firestoreDatabase.document("multiplayerRoom/\(self.room)"))
                docRef.updateData(["hostInputCheck":"Empty"])
                docRef.updateData(["guestInputCheck":"Empty"])
                self.multiplayerGameEngine(playerInput: self.playerSelection, player2Input: self.player2Selection)
            }
        }
    }
    
    fileprivate func guestUpdateScreen(_ docRef: DocumentReference) {
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            if (data["hostInputCheck"] as! String) == "Empty"{
                docRef.updateData(["guestInputCheck":self.player2Selection])
            } else {
                self.updateGuestInput(docRef: self.firestoreDatabase.document("multiplayerRoom/\(self.room)"))
                self.playerSelection = (data["hostInputCheck"] as! String)
                self.updateHostInput(docRef: self.firestoreDatabase.document("multiplayerRoom/\(self.room)"))
                docRef.updateData(["hostInputCheck":"Empty"])
                docRef.updateData(["guestInputCheck":"Empty"])
                self.multiplayerGameEngine(playerInput: self.playerSelection, player2Input: self.player2Selection)
            }
            
        }
    }
    
    func updateHostInput(docRef: DocumentReference){
        switch playerSelection{
        case "Rock":
            docRef.updateData(["hostSelection":"Rock"])
        case "Paper":
            docRef.updateData(["hostSelection":"Paper"])
        case "Scissors":
            docRef.updateData(["hostSelection":"Scissors"])
        case "Lizard":
            docRef.updateData(["hostSelection":"Lizard"])
        case "Spock":
            docRef.updateData(["hostSelection":"Spock"])
        default:
            NSLog("Invalid Selection")
        }
    }
    func updateGuestInput(docRef: DocumentReference){
        switch player2Selection{
        case "Rock":
            docRef.updateData(["guestSelection":"Rock"])
        case "Paper":
            docRef.updateData(["guestSelection":"Paper"])
        case "Scissors":
            docRef.updateData(["guestSelection":"Scissors"])
        case "Lizard":
            docRef.updateData(["guestSelection":"Lizard"])
        case "Spock":
            docRef.updateData(["guestSelection":"Spock"])
        default:
            NSLog("Invalid Selection")
        }
    }
    

    func multiplayerGameEngine(playerInput: String, player2Input: String){
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            self.gameLogic(docRef: docRef, data: data)
            }
        
    }
    fileprivate func gameLogic(docRef: DocumentReference, data: [String:Any]) {
        playerScoreValue = Int((data["hostScore"] as! NSString).intValue)
        player2ScoreValue = Int((data["guestScore"] as! NSString).intValue)
        roundCounter = Int((data["roundNumber"] as! NSString).intValue)
        switch playerSelection {
        case "Rock":
            switch player2Selection{
            case "Scissors":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Rock":
                roundResult = "Draw"
            default:
                roundResult = "\((loggedInPlayer_G["guestName"] as? String) ?? "Player")"
                player2ScoreValue += 1
                roundCounter += 1
            }
        case "Paper":
            switch player2Selection{
            case "Rock":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Paper":
                roundResult = "Draw"
            default:
                roundResult = "\((loggedInPlayer_G["guestName"] as? String) ?? "Player")"
                player2ScoreValue += 1
                roundCounter += 1
            }
        case "Scissors":
            switch player2Selection{
            case "Paper":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Scissors":
                roundResult = "Draw"
            default:
                roundResult = "\((loggedInPlayer_G["guestName"] as? String) ?? "Player")"
                player2ScoreValue += 1
                roundCounter += 1
            }
        case "Lizard":
            switch player2Selection{
            case "Paper":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Lizard":
                roundResult = "Draw"
            default:
                roundResult = "\((loggedInPlayer_G["guestName"] as? String) ?? "Player")"
                player2ScoreValue += 1
                roundCounter += 1
            }
        case "Spock":
            switch player2Selection{
            case "Scissors":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Rock":
                roundResult = "\((loggedInPlayer_G["hostName"] as? String) ?? "Player")"
                playerScoreValue += 1
                roundCounter += 1
            case "Spock":
                roundResult = "Draw"
            default:
                roundResult = "\((loggedInPlayer_G["guestName"] as? String) ?? "Player")"
                player2ScoreValue += 1
                roundCounter += 1
            }
        default:
            NSLog("Draw")
        }
        NSLog("Player: \(playerSelection) \n Bot: \(player2Selection) \n Result: \(roundResult)")
        playerScore.text = String(playerScoreValue)
        player2Score.text = String(player2ScoreValue)
        roundNumber.text = String(roundCounter)
        resultLabel.text = roundResult
        let p1Score = String(playerScoreValue)
        let p2Score = String(player2ScoreValue)
        let roundCounterText = String(roundCounter)
        docRef.updateData(["hostScore":p1Score])
        docRef.updateData(["guestScore":p2Score])
        docRef.updateData(["roundNumber":roundCounterText])
        docRef.updateData(["roundResult":roundResult])
    }
}
