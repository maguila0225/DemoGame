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
        imageView.contentMode = .scaleAspectFit
        onePlayerButtonImage.image = UIImage(named: "Rock.png")
        onePlayerButtonImage.contentMode = .scaleAspectFit
        onePlayerButtonText.text = "SINGLE PLAYER"
        onePlayerButtonText.textColor = .systemBlue
        multiplayerButtonImage.image = UIImage(named: "Scissors.png")
        multiplayerButtonImage.contentMode = .scaleAspectFit
        multiplayerButtonText.text = "MULTIPLAYER"
        multiplayerButtonText.textColor = .systemBlue
        leaderboardButtonImage.image = UIImage(named: "Spock.png")
        leaderboardButtonImage.contentMode = .scaleAspectFit
        leaderboardButtonText.text = "LEADERBOARD"
        leaderboardButtonText.textColor = .systemBlue
        profileButtonImage.image = UIImage(named: "Lizard.png")
        profileButtonImage.contentMode = .scaleAspectFit
        profileButtonText.text = "PLAYER PROFILE"
        profileButtonText.textColor = .systemBlue
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
            print("Single Player Button Tapped")
        case multiplayerSelect:
            let gameMode = "Multiplayer"
            multiplayerQueue()
            //        screenTransition(gameMode: gameMode)
            print("Multiplayer Button Tapped \(gameMode)")
        case leaderboardSelect:
            print("Leaderboard Button Tapped")
        case profileSelect:
            print("Profile Button Tapped")
        default:
            print("Unrecognized Gesture")
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
        
        text.frame = CGRect(x: image.right + 5,
                            y: 5,
                            width: base.width - image.width - 15,
                            height: base.height - 10)
        text.font = UIFont(name: "Verdana-Bold", size: base.height * 0.25)
        
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
                print("\(String(describing: error))")
                return
            }
            while (isConnected == false){
                print("i: \(i)")
                let hostName = "host" + String(i)
                if data.isEmpty {
                    documentReference.setData([hostName:"open"])
                    self.room = "room" + String(i)
                    self.role = "host"
                    print("assigned room: \(self.room) as role: \(self.role)")
                    isConnected = true
                }
                else{
                    let openCheck = data["host"+String(i)] as! String
                    print("openCheck: \(openCheck)")
                    if openCheck == "open"{
                        documentReference.updateData(["host"+String(i):"guest"])
                        self.room = "room" + String(i)
                        self.role = "guest"
                        print("assigned room: \(self.room) as role: \(self.role)")
                        isConnected = true
                    }
                    if openCheck == "guest"{
                        i = i + 1
                        let hostExists = data["host"+String(i)]
                        if hostExists == nil {
                            documentReference.updateData(["host"+String(i):"open"])
                            self.room = "room" + String(i)
                            self.role = "host"
                            print("assigned room: \(self.room) as role: \(self.role)")
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
            listenForGuest()
            // if guestStatus = Active make hostStatus: Active
            // pass multiplayerGame to GameVC
            // transition to GameVC
            
        }
        else if self.role == "guest"{
            initializeGuest()
            listenForHost()
            // if hostStatus: Active transition to GameVC
            
        }
        else{
            print("Error, no room/role assigend")
        }
    }
    
    func initializeHost(){
        let collectionReference = firestoreDatabase.collection("multiplayerRoom")
        let hostName = self.loggedInPlayer_MM["username"] as! String
        self.multiplayerGame.room = self.room
        self.multiplayerGame.hostName = hostName
        let encodedGame = encodeGame(inputGame: self.multiplayerGame)
        collectionReference.document(self.room).setData(encodedGame)
        print("connected to room: \(self.room) as \(self.role)")
    }
    
    func initializeGuest(){
        let guestUsername = self.loggedInPlayer_MM["username"] as! String
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.updateData(["guestName":guestUsername])
        docRef.updateData(["guestStatus":"Active"])
        print("connected to room: \(self.room) as \(self.role)")
    }
    
    func listenForGuest(){
        print("Waiting for guestStatus:Active ")
    }
    
    func listenForHost(){
        print("Waiting for hostStatus:Active ")
    }
    
}
