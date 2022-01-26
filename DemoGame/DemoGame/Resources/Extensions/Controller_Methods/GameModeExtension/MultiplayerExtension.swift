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
import MaterialComponents.MaterialDialogs

extension GameVC{
    // MARK: - Multiplayer Name Initialization
    func initializePlayerNames_MP(){
        playerName.text = gameRoomData["hostName"] as? String
        playerName_Score.text = gameRoomData["hostName"] as? String
        player2Name.text = gameRoomData["guestName"] as? String
        player2Name_Score.text = gameRoomData["guestName"] as? String
    }
    
    // MARK: - Inpitialize Input Room
    func initializeInputRoom(){
        if gameMode == "Multiplayer"{
            let inputRoom = "input" + (gameRoomData["room"] as! String)
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
                            self.updateScreenElements(data)
                            self.callMatchEnd(data)
                        }
                    }
                }
            }
        return screenUpdateListener!
    }
    
    fileprivate func updateScreenElements(_ data: [String : Any]) {
        self.p1SelectedImage.image = UIImage(named: (data["hostSelection"] as! String) + ".png")
        self.p2SelectedImage.image = UIImage(named: (data["guestSelection"] as! String) + ".png")
        self.resultLabel.text = data["roundResult"] as? String
        self.roundNumber.text = data["roundNumber"] as? String
        self.playerScore.text = data["hostScore"] as? String
        self.player2Score.text = data["guestScore"] as? String
    }
    
    fileprivate func callMatchEnd(_ data: [String : Any]) {
        let round = (data["roundNumber"] as! NSString).intValue
        let p1Score = data["hostScore"] as! String
        let p2Score = data["guestScore"] as! String
        if round >= 10 && p1Score != p2Score && data["matchWinner"] != nil{
            self.matchEndDialog()
        }
    }
    
    func matchEndDialog(){
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            let alertController = MDCAlertController(title: "Match Winner", message: (data["matchWinner"] as! String))
            let action1 = MDCAlertAction(title:"Exit") { (action) in (self.dismiss(animated: false, completion: nil))}
            alertController.addAction(action1)
            self.present(alertController, animated:true, completion: nil)
        }
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
        let inputRoom = "input" + (gameRoomData["room"] as! String)
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
                hostWins()
            case "Lizard":
                hostWins()
            case "Rock":
                roundResult = "Draw"
            default:
                guestWins()
            }
        case "Paper":
            switch player2Selection{
            case "Rock":
                hostWins()
            case "Spock":
                hostWins()
            case "Paper":
                roundResult = "Draw"
            default:
                guestWins()
            }
        case "Scissors":
            switch player2Selection{
            case "Paper":
                hostWins()
            case "Lizard":
                hostWins()
            case "Scissors":
                roundResult = "Draw"
            default:
                guestWins()
            }
        case "Lizard":
            switch player2Selection{
            case "Paper":
                hostWins()
            case "Spock":
                hostWins()
            case "Lizard":
                roundResult = "Draw"
            default:
                guestWins()
            }
        case "Spock":
            switch player2Selection{
            case "Scissors":
                hostWins()
            case "Rock":
                hostWins()
            case "Spock":
                roundResult = "Draw"
            default:
                guestWins()
            }
        default:
            NSLog("Draw")
        }
        roundScoreUpdate(docRef)
    }
    
    fileprivate func hostWins() {
        roundResult = "\((gameRoomData["hostName"] as? String) ?? "Player")"
        playerScoreValue += 1
        roundCounter += 1
    }
    
    fileprivate func guestWins() {
        roundResult = "\((gameRoomData["guestName"] as? String) ?? "Player")"
        player2ScoreValue += 1
        roundCounter += 1
    }
    
    
    
    fileprivate func roundScoreUpdate(_ docRef: DocumentReference) {
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
        if roundCounter >= 10 && playerScoreValue != player2ScoreValue{
            let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
            if playerScoreValue > player2ScoreValue{
                docRef.updateData(["matchWinner":self.playerName.text!])
                updateHostWin()
            }
            else{
                docRef.updateData(["matchWinner":self.player2Name.text!])
                updateGuestWin()
            }
            
        }
    }
    
    func updateHostWin(){
        var p1Win: Int = 0
        var p2Loss: Int = 0
        let p1Name = gameRoomData["hostName"] as! String
        let p2Name = gameRoomData["guestName"] as! String
        let p1DocRef = firestoreDatabase.collection("playerDatabase").document(p1Name)
        let p2DocRef = firestoreDatabase.collection("playerDatabase").document(p2Name)
        p1DocRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            p1Win = (data["wins"] as! Int) + 1
            p1DocRef.updateData(["wins": p1Win])
        }
        p2DocRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            p2Loss = (data["losses"] as! Int) + 1
            p2DocRef.updateData(["losses": p2Loss])
        }
    }
    
    func updateGuestWin(){
        var p2Win: Int = 0
        var p1Loss: Int = 0
        let p1Name = gameRoomData["hostName"] as! String
        let p2Name = gameRoomData["guestName"] as! String
        let p1DocRef = firestoreDatabase.collection("playerDatabase").document(p1Name)
        let p2DocRef = firestoreDatabase.collection("playerDatabase").document(p2Name)
        p2DocRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            p2Win = (data["wins"] as! Int) + 1
            p2DocRef.updateData(["wins": p2Win])
        }
        p1DocRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            p1Loss = (data["losses"] as! Int) + 1
            p1DocRef.updateData(["losses": p1Loss])
        }
    }
}
