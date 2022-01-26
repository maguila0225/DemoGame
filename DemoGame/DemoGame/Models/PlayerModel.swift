//
//  PlayerModel.swift
//  DemoGame
//
//  Created by OPSolutions on 1/17/22.
//

import Foundation
struct Player: Codable{
    var username: String = ""
    var password: String = ""
    var wins: Int = 0
    var losses: Int = 0
}
