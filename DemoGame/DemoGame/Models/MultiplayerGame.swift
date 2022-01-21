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
    var hostState: String = ""
    var hostSelection: String = ""
    var guestName: String = ""
    var guestScore: String = "0"
    var guestState: String = ""
    var guestSelection: String = ""
    var roundNumber: String = ""
    var roundResult: String = ""

}
