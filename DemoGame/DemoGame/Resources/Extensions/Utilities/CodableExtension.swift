//
//  CodableExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import FirebaseFirestore

extension UIViewController{
    func encodePlayer(inputPlayer: Player) -> [String: Any]
    {
        do{
            let encodedData = try JSONEncoder().encode(inputPlayer)
            guard let encodedPlayer = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any] else{
                NSLog("Serialization Fail")
                return [:]
            }
            return encodedPlayer
        }
        catch{
            NSLog("Encoding Failed")
            return [:]
        }
    }
    
    func encodeGame(inputGame: MultiplayerGame) -> [String: Any]
    {
        do{
            let encodedData = try JSONEncoder().encode(inputGame)
            guard let encodedGame = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any] else{
                NSLog("Serialization Fail")
                return [:]
            }
            return encodedGame
        }
        catch{
            NSLog("Encoding Failed")
            return [:]
        }
    }
}


