//
//  MainMenuVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import MaterialComponents.MaterialAppBar

class MainMenuVC: UIViewController {
// MARK: - UI Element Declaration
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let onePlayerButtonView: UIView = {
        let onePlayerButtonView = UIView()
        onePlayerButtonView.backgroundColor = .systemBackground
        return onePlayerButtonView
    }()
    let rockView: UIImageView = {
       let rockView = UIImageView()
        rockView.image = UIImage(named: "Rock.png")
        rockView.contentMode = .scaleAspectFit
        return rockView
    }()
    let singlePlayerTextView: UILabel = {
        let singlePlayerTextView = UILabel()
        singlePlayerTextView.text = "SINGLE PLAYER"
        singlePlayerTextView.textColor = .systemBlue
        return singlePlayerTextView
    }()
    
    let MultiplayerButtonView: UIView = {
        let MultiplayerButtonView = UIView()
        MultiplayerButtonView.backgroundColor = .systemBackground
        return MultiplayerButtonView
    }()
    
    let scissorsView: UIImageView = {
       let scissorsView = UIImageView()
        scissorsView.image = UIImage(named: "Scissors.png")
        scissorsView.contentMode = .scaleAspectFit
        return scissorsView
    }()
    
    let MultiplayerTextView: UILabel = {
        let MultiplayerTextView = UILabel()
        MultiplayerTextView.text = "MULTIPLAYER"
        MultiplayerTextView.textColor = .systemBlue
        return MultiplayerTextView
    }()
    
    let LeaderboardView: UIView = {
        let LeaderboardView = UIView()
        LeaderboardView.backgroundColor = .systemBackground
        return LeaderboardView
    }()
    
    let spockView: UIImageView = {
       let spockView = UIImageView()
        spockView.image = UIImage(named: "Spock.png")
        spockView.contentMode = .scaleAspectFit
        return spockView
    }()
    
    let LeaderboardTextView: UILabel = {
        let LeaderboardTextView = UILabel()
        LeaderboardTextView.text = "LEADERBOARD"
        LeaderboardTextView.textColor = .systemBlue
        return LeaderboardTextView
    }()
    
    let ProfileView: UIView = {
        let ProfileView = UIView()
        ProfileView.backgroundColor = .systemBackground
        return ProfileView
    }()
    
    let lizardView: UIImageView = {
       let lizardView = UIImageView()
        lizardView.image = UIImage(named: "Lizard.png")
        lizardView.contentMode = .scaleAspectFit
        return lizardView
    }()
    
    let ProfileTextView: UILabel = {
        let ProfileTextView = UILabel()
        ProfileTextView.text = "PLAYER PROFILE"
        ProfileTextView.textColor = .systemBlue
        return ProfileTextView
    }()
// MARK: - Class Variable Declaration
    let vcIdentifier: String = "MainMenuVC"
    var usernameDataPass_MM: String = "Default Username"

// MARK: - Gesture Recognizer Declaration
    var singlePlayerSelect = UIGestureRecognizer()
    var multiplayerSelect = UIGestureRecognizer()
    var leaderboardSelect = UIGestureRecognizer()
    var profileSelect = UIGestureRecognizer()

// MARK: - MainMenuVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Menu"
        GlobalLog_Load(vc_Log: vcIdentifier)
        addElementSubViews()
        initializeImageTapGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        elementLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
    }
                          
    override func viewDidDisappear(_ animated: Bool) {
            GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }

}
// MARK: - MainMenuVC functions
extension MainMenuVC{
    
    //MARK: - UI Element Initialization Functions
    func addElementSubViews(){
        view.addSubview(imageView)
        view.addSubview(onePlayerButtonView)
        view.addSubview(MultiplayerButtonView)
        view.addSubview(LeaderboardView)
        view.addSubview(ProfileView)
        onePlayerButtonView.addSubview(rockView)
        onePlayerButtonView.addSubview(singlePlayerTextView)
        MultiplayerButtonView.addSubview(scissorsView)
        MultiplayerButtonView.addSubview(MultiplayerTextView)
        LeaderboardView.addSubview(spockView)
        LeaderboardView.addSubview(LeaderboardTextView)
        ProfileView.addSubview(lizardView)
        ProfileView.addSubview(ProfileTextView)
    }
    
    func elementLayout(){
        let size = view.frame.size.width/2
        imageView.frame = CGRect(x: (view.width - size)/2,
                                 y: 0.1 * view.frame.size.height,
                                 width: size,
                                 height: size)
        
        onePlayerButtonView.frame = CGRect(x: 0,
                                  y: imageView.bottom + 20,
                                  width: view.width,
                                           height: view.height / 7.5)
        onePlayerButtonView.layer.cornerRadius = 24
        onePlayerButtonView.layer.borderColor = UIColor.link.cgColor
        onePlayerButtonView.layer.borderWidth = 5
        
        rockView.frame = CGRect(x: 0.09 * onePlayerButtonView.width,
                                y: 5,
                                width: onePlayerButtonView.height - 10,
                                height: onePlayerButtonView.height - 10)
        
        singlePlayerTextView.frame = CGRect(x: rockView.right + 10,
                                y: 5,
                                width: onePlayerButtonView.width - rockView.width - 30,
                                height: onePlayerButtonView.height - 10)
        singlePlayerTextView.font = UIFont(name: "Verdana-Bold",size: onePlayerButtonView.height/5)
        
        
        MultiplayerButtonView.frame = CGRect(x: 0,
                                  y: onePlayerButtonView.bottom + 20,
                                  width: view.width,
                                             height: view.height / 7.5)
        MultiplayerButtonView.layer.cornerRadius = 24
        MultiplayerButtonView.layer.borderColor = UIColor.link.cgColor
        MultiplayerButtonView.layer.borderWidth = 5
        
        scissorsView.frame = CGRect(x: 0.09 * onePlayerButtonView.width,
                                y: 5,
                                width: MultiplayerButtonView.height - 10,
                                height: MultiplayerButtonView.height - 10)
        
        MultiplayerTextView.frame = CGRect(x: scissorsView.right + 10,
                                y: 5,
                                width: MultiplayerButtonView.width - scissorsView.width - 30,
                                height: MultiplayerButtonView.height - 10)
        MultiplayerTextView.font = UIFont(name: "Verdana-Bold",size: MultiplayerButtonView.height/5)
        
        LeaderboardView.frame = CGRect(x: 0,
                                  y: MultiplayerButtonView.bottom + 20,
                                  width: view.width,
                                       height: view.height / 7.5)
        LeaderboardView.layer.cornerRadius = 24
        LeaderboardView.layer.borderColor = UIColor.link.cgColor
        LeaderboardView.layer.borderWidth = 5
        
        spockView.frame = CGRect(x: 0.09 * onePlayerButtonView.width,
                                y: 5,
                                width: LeaderboardView.height - 10,
                                height: LeaderboardView.height - 10)
        
        LeaderboardTextView.frame = CGRect(x: spockView.right + 10,
                                y: 5,
                                width: LeaderboardView.width - spockView.width - 30,
                                height: LeaderboardView.height - 10)
        LeaderboardTextView.font = UIFont(name: "Verdana-Bold",size: LeaderboardView.height/5)
        
        ProfileView.frame = CGRect(x: 0,
                                  y: LeaderboardView.bottom + 20,
                                  width: view.width,
                                   height: view.height / 7.5)
        ProfileView.layer.cornerRadius = 24
        ProfileView.layer.borderColor = UIColor.link.cgColor
        ProfileView.layer.borderWidth = 5
        
        lizardView.frame = CGRect(x: 0.09 * onePlayerButtonView.width,
                                y: 5,
                                width: ProfileView.height - 10,
                                height: ProfileView.height - 10)
        
        ProfileTextView.frame = CGRect(x: lizardView.right + 10,
                                y: 5,
                                width: ProfileView.width - lizardView.width - 30,
                                height: ProfileView.height - 10)
        ProfileTextView.font = UIFont(name: "Verdana-Bold",size: ProfileView.height/5)
    }
    func initializeImageTapGestures(){
        singlePlayerSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        onePlayerButtonView.isUserInteractionEnabled = true
        onePlayerButtonView.addGestureRecognizer(singlePlayerSelect)
        
        multiplayerSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        MultiplayerButtonView.isUserInteractionEnabled = true
        MultiplayerButtonView.addGestureRecognizer(multiplayerSelect)
        
        leaderboardSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        LeaderboardView.isUserInteractionEnabled = true
        LeaderboardView.addGestureRecognizer(leaderboardSelect)
        
        profileSelect = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ProfileView.isUserInteractionEnabled = true
        ProfileView.addGestureRecognizer(profileSelect)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        switch tapGestureRecognizer{
        case singlePlayerSelect:
            let gameMode = "Single Player"
            screenTransition(gameMode: gameMode)
        case multiplayerSelect:
            let gameMode = "Multiplayer"
            screenTransition(gameMode: gameMode)
        case leaderboardSelect:
            print("Leaderboard Button Tapped")
        case profileSelect:
            print("Profile Button Tapped")
        default:
            print("Unrecognized Gesture")
        }
    }
    // MARK: - Screen Transition Function
        func screenTransition (gameMode: String) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "GameScreenVC") as! GameScreenVC
            vc.modalPresentationStyle = .fullScreen
            vc.usernameDataPass_GS = usernameDataPass_MM
            vc.gameMode = gameMode
            self.present(vc, animated: true, completion: nil)
        }
}
