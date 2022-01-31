//
//  LeaderboardVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/26/22.
//

import UIKit
import FirebaseFirestore

class LeaderboardVC: UIViewController{
    // MARK: - UI Element Declaration
    @IBOutlet weak var leaderboardTableView: UITableView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK: - Variable and Constant Declaration
    let firestoreDatabase = Firestore.firestore()
    var playerData: [Player] = []
    let vcIdentifier = "LeaderboardVC"
    var bgImage = ""
    
    //MARK: - LeaderboardVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        leaderboardTableView.delegate = self
        leaderboardTableView.dataSource = self
        getUserData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
        setupBackground()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
    
    //MARK: - IBActions
    @IBAction func returnToMainMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


