//
//  MultiplayerGame.swift
//  DemoGame
//
//  Created by OPSolutions on 1/21/22.
//

import Foundation
import UIKit

struct MultiplayerGame: Codable{
    var room: String = ""
    var hostName: String = ""
    var hostScore: String = "0"
    var hostSelection: String = "Rock.png"
    var guestName: String = ""
    var guestScore: String = "0"
    var guestSelection: String = "Rock.png"
    var roundNumber: String = "0"
    var roundResult: String = ""
    var gameStatus: String = ""
}
