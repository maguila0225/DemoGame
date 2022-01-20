//
//  MainMenu_Extension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit

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
        screenTransition(gameMode: gameMode)
        print("Multiplayer Button Tapped")
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
    }
}
