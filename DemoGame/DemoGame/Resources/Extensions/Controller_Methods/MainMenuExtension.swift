//
//  MainMenu_Extension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import FirebaseFirestore

extension MainMenuVC{
    //MARK: - Initialize UI Elements
    func initializeUIElements(){
        imageView.image = UIImage(named: "Logo.png")
        onePlayerButtonImage.image = UIImage(named: "Rock.png")
        onePlayerButtonText.text = "SINGLE PLAYER"
        multiplayerButtonImage.image = UIImage(named: "Scissors.png")
        multiplayerButtonText.text = "MULTIPLAYER"
        leaderboardButtonImage.image = UIImage(named: "Spock.png")
        leaderboardButtonText.text = "LEADERBOARD"
        profileButtonImage.image = UIImage(named: "Lizard.png")
        profileButtonText.text = "PLAYER PROFILE"
    }
    //MARK: - Add Subviews
    func addUIElementSubViews(){
        view.addSubview(imageView)
        view.addSubview(onePlayerButton)
        view.addSubview(multiplayerButton)
        view.addSubview(leaderboardButton)
        view.addSubview(profileButton)
        onePlayerButton.addSubview(onePlayerButtonImage)
        onePlayerButton.addSubview(onePlayerButtonText)
        multiplayerButton.addSubview(multiplayerButtonImage)
        multiplayerButton.addSubview(multiplayerButtonText)
        leaderboardButton.addSubview(leaderboardButtonImage)
        leaderboardButton.addSubview(leaderboardButtonText)
        profileButton.addSubview(profileButtonImage)
        profileButton.addSubview(profileButtonText)
    }
    //MARK: - Add Tap Gestures
    func initializeImageTapGestures(){
        
        singlePlayerSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        onePlayerButton.isUserInteractionEnabled = true
        onePlayerButton.addGestureRecognizer(singlePlayerSelect)
        
        multiplayerSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        multiplayerButton.isUserInteractionEnabled = true
        multiplayerButton.addGestureRecognizer(multiplayerSelect)
        
        leaderboardSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        leaderboardButton.isUserInteractionEnabled = true
        leaderboardButton.addGestureRecognizer(leaderboardSelect)
        
        profileSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileButton.isUserInteractionEnabled = true
        profileButton.addGestureRecognizer(profileSelect)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        switch tapGestureRecognizer{
        case singlePlayerSelect:
            let gameMode = "Single Player"
            screenTransition(gameMode: gameMode)
            NSLog("Single Player Button Tapped")
        case multiplayerSelect:
            let gameMode = "Multiplayer"
            multiplayerQueue()
            //        screenTransition(gameMode: gameMode)
            NSLog("Multiplayer Button Tapped \(gameMode)")
        case leaderboardSelect:
            NSLog("Leaderboard Button Tapped")
        case profileSelect:
            NSLog("Profile Button Tapped")
        default:
            NSLog("Unrecognized Gesture")
        }
    }
    
    func subviewLayout(){
        let size = view.frame.size.width/2
        imageView.frame = CGRect(x: (view.width - size)/2,
                                 y: 0.1 * view.frame.size.height,
                                 width: size,
                                 height: size)
        
        initializeButtonSubviewLayout(base: onePlayerButton,
                                      image: onePlayerButtonImage,
                                      text: onePlayerButtonText,
                                      y: imageView.bottom + 3)
        
        initializeButtonSubviewLayout(base: multiplayerButton,
                                      image: multiplayerButtonImage,
                                      text: multiplayerButtonText,
                                      y: onePlayerButton.bottom + 3)
        
        initializeButtonSubviewLayout(base: leaderboardButton,
                                      image: leaderboardButtonImage,
                                      text: leaderboardButtonText,
                                      y: multiplayerButton.bottom + 3)
        
        initializeButtonSubviewLayout(base: profileButton,
                                      image: profileButtonImage,
                                      text: profileButtonText,
                                      y: leaderboardButton.bottom + 3)
    }
    
    func initializeButtonSubviewLayout(base: UIView, image: UIImageView, text: UILabel, y: Double){
        let displayHeight = view.frame.size.height
        let displayWidth = view.frame.size.width
        
        base.frame = CGRect(x: 5,
                            y: y,
                            width: displayWidth - 10,
                            height: displayHeight / 9)
        base.layer.borderWidth = 3
        base.layer.borderColor = UIColor.systemBlue.cgColor
        base.layer.cornerRadius = 24
        
        image.frame = CGRect(x: base.width * 0.08,
                             y: 5,
                             width: base.height - 10,
                             height: base.height - 10)
        image.contentMode = .scaleAspectFit
        
        text.frame = CGRect(x: image.right + 5,
                            y: 5,
                            width: base.width - image.width - 15,
                            height: base.height - 10)
        text.font = UIFont(name: "Verdana-Bold", size: base.height * 0.25)
        text.textColor = .systemBlue
        
    }
    
    // MARK: - Screen Transition Function
    func screenTransition (gameMode: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        vc.modalPresentationStyle = .fullScreen
        vc.loggedInPlayer_G = loggedInPlayer_MM
        vc.gameMode = gameMode
        self.present(vc, animated: true, completion: nil)
    }
    
    func multiplayerQueue(){
        var isConnected:Bool = false
        var i = 0
        
        let documentReference = firestoreDatabase.document("multiplayerQueue/Lobby")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            assignHostGuest(data: data)
        }
        func assignHostGuest(data: [String :Any])
        {
            while (isConnected == false){
                let hostName = "host" + String(i)
                if data.isEmpty {
                    documentReference.setData([hostName:"open"])
                    self.room = "room" + String(i)
                    self.role = "host"
                    NSLog("assigned room: \(self.room) as role: \(self.role)")
                    isConnected = true
                }
                else{
                    let openCheck = data["host"+String(i)] as! String
                    if openCheck == "open"{
                        documentReference.updateData(["host"+String(i):"guest"])
                        self.room = "room" + String(i)
                        self.role = "guest"
                        NSLog("assigned room: \(self.room) as role: \(self.role)")
                        isConnected = true
                    }
                    if openCheck == "guest"{
                        i = i + 1
                        let hostExists = data["host"+String(i)]
                        if hostExists == nil {
                            documentReference.updateData(["host"+String(i):"open"])
                            self.room = "room" + String(i)
                            self.role = "host"
                            NSLog("assigned room: \(self.room) as role: \(self.role)")
                            isConnected = true
                        }
                    }
                }
            }
            self.connectToRoom()
        }
        
    }
    func connectToRoom(){
        if self.role == "host"{
            initializeHost()
            // if guestStatus = Active make hostStatus: Active
            // pass multiplayerGame to GameVC
            // transition to GameVC
            
        }
        else if self.role == "guest"{
            initializeGuest()
            // if hostStatus: Active transition to GameVC
            
        }
        else{
            NSLog("Error, no room/role assigend")
        }
    }
    
    func initializeHost(){
        let collectionReference = firestoreDatabase.collection("multiplayerRoom")
        let hostName = self.loggedInPlayer_MM["username"] as! String
        self.multiplayerGame.room = self.room
        self.multiplayerGame.hostName = hostName
        let encodedGame = encodeGame(inputGame: self.multiplayerGame)
        collectionReference.document(self.room).setData(encodedGame)
        NSLog("connected to room: \(self.room) as \(self.role)")
        listenForGuest(documentName: self.room)
    }
    
    func initializeGuest(){
        let guestUsername = self.loggedInPlayer_MM["username"] as! String
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.updateData(["guestName":guestUsername])
        NSLog("connected to room: \(self.room) as \(self.role)")
        listenForHost(documentName: self.room)
    }
    
    func listenForGuest(documentName: String){
        let db = Firestore.firestore()
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        let hostListener = db.collection("multiplayerRoom").whereField("room", isEqualTo: self.room)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .modified) {
                        print("update the host now")
                        docRef.updateData(["gameStatus":"Active"], completion: nil)
                        print("do host screen transition now")
                        self.hostScreenTransition()
                    }
                }
            }
    }
    
    func listenForHost(documentName: String){
        let db = Firestore.firestore()
        let guestListener = db.collection("multiplayerRoom").whereField("room", isEqualTo: self.room)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .modified) {
                        print("gameStatus is updated")
                        print("do guest screen transition now")
                        self.guestScreenTransition()
                    }
                }
            }
    }
    func hostScreenTransition(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func guestScreenTransition(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
