//
//  MainMenu_Extension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import AVFoundation
import AVKit

extension MainMenuVC{

    //MARK: - Initialize UI Elements
    func initializeUIElements(){
        title = "Main Menu"
        imageView.image = UIImage(named: "Logo.png")
        onePlayerButtonImage.image = UIImage(named: "Rock.png")
        onePlayerButtonText.text = "SINGLE PLAYER"
        multiplayerButtonImage.image = UIImage(named: "Scissors.png")
        multiplayerButtonText.text = "MULTIPLAYER"
        leaderboardButtonImage.image = UIImage(named: "Paper.png")
        leaderboardButtonText.text = "LEADERBOARD"
        rulesButtonImage.image = UIImage(named: "Spock.png")
        rulesButtonText.text = "RULES"
        self.view.isUserInteractionEnabled = true
    }
    
    //MARK: - Add Subviews
    func selectMenuTheme() -> String {
        if self.traitCollection.userInterfaceStyle == .dark{
            bgImage = "DarkModeBG.jpeg"
            themeColor = .systemRed
        }
        else{
            bgImage = "LightModeBG.jpeg"
            themeColor = .systemBlue
        }
        return bgImage
    }
    
    func addUIElementSubViews(){
        view.addSubview(curtains)
        curtains.addSubview(curtainsImage)
        curtains.addSubview(curtainsText)
        view.addSubview(backgroundImage)
        view.addSubview(signOutButton)
        view.addSubview(imageView)
        view.addSubview(onePlayerButton)
        view.addSubview(multiplayerButton)
        view.addSubview(leaderboardButton)
        view.addSubview(rulesButton)
        onePlayerButton.addSubview(onePlayerButtonImage)
        onePlayerButton.addSubview(onePlayerButtonText)
        multiplayerButton.addSubview(multiplayerButtonImage)
        multiplayerButton.addSubview(multiplayerButtonText)
        leaderboardButton.addSubview(leaderboardButtonImage)
        leaderboardButton.addSubview(leaderboardButtonText)
        rulesButton.addSubview(rulesButtonImage)
        rulesButton.addSubview(rulesButtonText)
        view.bringSubviewToFront(curtains)
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
        rulesButton.isUserInteractionEnabled = true
        rulesButton.addGestureRecognizer(profileSelect)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        switch tapGestureRecognizer{
        case singlePlayerSelect:
            gameMode = "Single Player"
            singlePlayerScreenTransition(gameMode: gameMode)
            NSLog("Single Player Button Tapped")
        case multiplayerSelect:
            gameMode = "Multiplayer"
            multiplayerQueue()
            NSLog("Multiplayer Button Tapped \(gameMode)")
        case leaderboardSelect:
            leaderboardScreenTransition()
            NSLog("Leaderboard Button Tapped")
        case profileSelect:
            presentRules()
            NSLog("Rules Button Tapped")
        default:
            NSLog("Unrecognized Gesture")
        }
    }
    // MARK: - Screen Layout
    func subviewLayout(){
        let size = view.frame.size.width/2
        layoutCurtains()
        layoutBackground()
        layoutLogo(size)
        layoutSignOutButton()
        layoutMenuButtons()
    }
    
    fileprivate func layoutCurtains() {
        curtains.frame = CGRect(x: 0,
                                y: 0,
                                width: view.frame.size.width,
                                height: view.frame.size.height)
        curtains.backgroundColor = .systemBackground
        
        curtainsImage.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        curtainsImage.center = curtains.center
        curtainsImage.image = UIImage(named: "Logo.png")
        curtainsText.text = "LOADING"
        curtainsText.frame = CGRect(x: (view.frame.size.width - 200) / 2,
                                    y: curtainsImage.bottom + 10,
                                    width: 200,
                                    height: 30)
        curtainsText.font = .systemFont(ofSize: 30, weight: .heavy)
        curtainsText.textAlignment = .center
    }
    
    fileprivate func layoutBackground() {
        backgroundImage.frame = CGRect(x: 0,
                                       y: 0,
                                       width: view.frame.size.width,
                                       height: view.frame.size.height)
        backgroundImage.image = UIImage(named: selectMenuTheme())
    }
    
    fileprivate func layoutLogo(_ size: CGFloat) {
        imageView.frame = CGRect(x: (view.width - size)/2,
                                 y: 0.1 * view.frame.size.height,
                                 width: size,
                                 height: size)
    }
    
    fileprivate func layoutSignOutButton() {
        signOutButton.frame = CGRect(x: view.frame.size.width * 0.003,
                                     y: view.frame.size.height * 0.05,
                                     width: view.frame.size.width * 0.30,
                                     height: view.frame.size.height * 0.05)
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.link, for: .normal)
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
    fileprivate func layoutMenuButtons() {
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
        
        initializeButtonSubviewLayout(base: rulesButton,
                                      image: rulesButtonImage,
                                      text: rulesButtonText,
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
        base.layer.borderColor = themeColor.cgColor
        base.layer.cornerRadius = 24
        base.backgroundColor = themeColor.withAlphaComponent(0.2)
        
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
//        text.textColor = .white
        
    }
    
    //MARK: - User Authentication
    @objc func signOut(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        UserDefaults.standard.set(false, forKey: "demoGameIsSignedIn")
        UserDefaults.standard.set(nil, forKey: "demoGameUsername")
        UserDefaults.standard.synchronize()
        vc.menuMusicPlayer = menuMusicPlayer
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func signedInCheck(){
        if signInCheck != true {
            NSLog("Main Menu Sign In Check: \(signInCheck)")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
            vc.modalPresentationStyle = .fullScreen
            vc.menuMusicPlayer = menuMusicPlayer
            present(vc, animated: false, completion: nil)
        } else {
            curtains.isHidden = true
        }
    }
    
    // MARK: - Load User Data from Firebase
    func loadUserDataFromFirebase(){
        guard demoGameUsername != nil else{
            return
        }
        let docRef = firestoreDatabase.collection("playerDatabase").document(demoGameUsername!)
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            self.loggedInPlayer_MM = data
            self.loggedInPlayer_SP = data["username"] as! String
            NSLog("singInCheck: \(self.signInCheck) \n demoGameUsername \(self.demoGameUsername ?? "no User")")
            NSLog("userData: \(self.loggedInPlayer_MM)")
        }
    }
    
    // MARK: - Screen Transition Functions
    func singlePlayerScreenTransition (gameMode: String) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        vc.modalPresentationStyle = .fullScreen
        vc.loggedInPlayer_SP = loggedInPlayer_SP
        vc.gameMode = gameMode
        vc.bgImage = bgImage
        menuMusicPlayer!.stop()
        self.present(vc, animated: true, completion: nil)
    }

    func leaderboardScreenTransition() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LeaderboardVC") as! LeaderboardVC
        vc.bgImage = bgImage
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Multiplayer Queue Function
    func multiplayerQueue(){
        curtains.isHidden = false
        self.view.isUserInteractionEnabled = false
        let documentReference = firestoreDatabase.document("multiplayerQueue/Lobby")
        documentReference.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            self.assignHostGuest(data: data)
        }
    }
    
    func assignHostGuest(data: [String :Any]){
        let documentReference = firestoreDatabase.document("multiplayerQueue/Lobby")
        var isConnected:Bool = false
        var i = 0
        
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
    
    func connectToRoom(){
        if self.role == "host"{
            initializeHost()
        }
        else if self.role == "guest"{
            initializeGuest()
        }
        else{
            NSLog("Error, no room/role assigend")
        }
    }
    
    //MARK: - Multiplayer Game Initialization Functions
    func initializeHost(){
        let collectionReference = firestoreDatabase.collection("multiplayerRoom")
        let hostName = self.loggedInPlayer_MM["username"] as! String
        self.multiplayerGame.room = self.room
        self.multiplayerGame.hostName = hostName
        let encodedGame = encodeGame(inputGame: self.multiplayerGame)
        collectionReference.document(self.room).setData(encodedGame)
        NSLog("connected to room: \(self.room) as \(self.role)")
        hostListner = listenForGuest(documentName: self.room)
    }
    
    func initializeGuest(){
        let guestUsername = self.loggedInPlayer_MM["username"] as! String
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.updateData(["guestName":guestUsername])
        NSLog("connected to room: \(self.room) as \(self.role)")
        guestListener = listenForHost(documentName: self.room)
    }
    
    func listenForGuest(documentName: String) -> ListenerRegistration{
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
                        docRef.updateData(["gameStatus":"Active"], completion: nil)
                        self.hostScreenTransition()
                    }
                }
            }
        return hostListener
    }
    
    func listenForHost(documentName: String) -> ListenerRegistration{
        let db = Firestore.firestore()
        let guestListener = db.collection("multiplayerRoom").whereField("room", isEqualTo: self.room)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .modified) {
                        self.guestScreenTransition()
                    }
                }
            }
        return guestListener
    }
    //MARK: - Screen Transition Functions (Multipalyer)
    func hostScreenTransition(){
        self.view.isUserInteractionEnabled = true
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        vc.modalPresentationStyle = .fullScreen
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            self.hostListner!.remove()
            self.curtains.isHidden = true
            vc.room = self.room
            vc.gameMode = self.gameMode
            vc.loggedInPlayer_G = self.loggedInPlayer_MM
            vc.gameRoomData = data
            vc.role = self.role
            vc.bgImage = self.bgImage
            self.menuMusicPlayer!.stop()
        }
        present(vc, animated: true, completion: nil)
    }
    
    func guestScreenTransition(){
        self.view.isUserInteractionEnabled = true
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "GameVC") as! GameVC
        vc.modalPresentationStyle = .fullScreen
        let docRef = firestoreDatabase.document("multiplayerRoom/\(self.room)")
        docRef.getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            self.curtains.isHidden = true
            self.guestListener!.remove()
            vc.room = self.room
            vc.gameMode = self.gameMode
            vc.loggedInPlayer_G = self.loggedInPlayer_MM
            vc.gameRoomData = data
            vc.role = self.role
            vc.bgImage = self.bgImage
            self.menuMusicPlayer!.stop()
        }
        present(vc, animated: true, completion: nil)
    }
    func presentRules(){
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Rules", ofType: "mp4")!))
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true)
        vc.player!.play()
        menuMusicPlayer!.stop()
    }
    
    func playBackgroundAudio(){
        if let menuMusicPlayer = menuMusicPlayer, menuMusicPlayer.isPlaying{
            print("Background audio is playing")
        }
        else {
            print("Start Audio")
            let urlString = Bundle.main.path(forResource: "Stardust", ofType: "mp3")
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                menuMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let menuMusicPlayer = menuMusicPlayer else{
                    return
                }
                menuMusicPlayer.volume = 0.5
                menuMusicPlayer.numberOfLoops = -1
                menuMusicPlayer.play()
            }
            catch{
                print("something went wrong with the audio player")
            }
        }
    }
}


