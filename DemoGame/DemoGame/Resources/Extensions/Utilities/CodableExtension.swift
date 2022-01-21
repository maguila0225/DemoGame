//
//  CodableExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit

extension UIViewController{
    func encodePlayer(inputPlayer: Player) -> [String: Any]
    {
        do{
            let encodedData = try JSONEncoder().encode(inputPlayer)
            guard let encodedPlayer = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any] else{
                print("Serialization Fail")
                return [:]
            }
            return encodedPlayer
        }
        catch{
            print("Encoding Failed")
            return [:]
        }
    }
    
    func encodeGame(inputGame: MultiplayerGame) -> [String: Any]
    {
        do{
            let encodedData = try JSONEncoder().encode(inputGame)
            guard let encodedGame = try JSONSerialization.jsonObject(with: encodedData, options: .allowFragments) as? [String: Any] else{
                print("Serialization Fail")
                return [:]
            }
            return encodedGame
        }
        catch{
            print("Encoding Failed")
            return [:]
        }
    }
}
