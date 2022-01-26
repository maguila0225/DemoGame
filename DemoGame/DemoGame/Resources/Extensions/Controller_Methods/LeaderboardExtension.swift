//
//  LeaderboardExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/26/22.
//

import Foundation
import FirebaseFirestore

extension LeaderboardVC{
    //MARK: - Get User Data and Sort
    func getUserData(){
        let collectionRef = firestoreDatabase.collection("playerDatabase")
        collectionRef.getDocuments{ snapshot, error in
            guard let data = snapshot, error == nil else{
                NSLog("\(String(describing: error))")
                return
            }
            for document in data.documents{
                var loadedPlayer = Player()
                loadedPlayer.wins = document.data()["wins"]! as! Int
                loadedPlayer.losses = document.data()["losses"]! as! Int
                loadedPlayer.username = document.data()["username"]! as! String
                loadedPlayer.password = document.data()["password"]! as! String
                self.playerData.append(loadedPlayer)
            }
            self.playerData = self.playerData.sorted(by: { $0.wins > $1.wins })
            self.leaderboardTableView.reloadData()
        }
    }
}

//MARK: - View Delegate Extension
extension LeaderboardVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell tapped")
    }
}

//MARK: - View Data Source Extension
extension LeaderboardVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1).) \(playerData[indexPath.row].username) W: \(playerData[indexPath.row].wins) L: \(playerData[indexPath.row].losses)"
        return cell
    }
}
