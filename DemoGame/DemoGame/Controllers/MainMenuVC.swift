//
//  MainMenuVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import MaterialComponents.MaterialAppBar

class MainMenuVC: UIViewController {
// MARK: - Variable/Constant Declaration
    let vcIdentifier: String = "MainMenuVC"
    var usernameDataPass_MM: String = "Default Username"
    
// MARK: - MainMenuVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
    }
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)
    }

    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
// MARK: - MainMenuVC IBAction
    @IBAction func singlePlayerButton(_ sender: Any) {
        let gameMode = "Single Player"
        screenTransition(gameMode: gameMode)
    }
    @IBAction func multiplayerButton(_ sender: Any) {
        let gameMode = "Multiplayer"
        screenTransition(gameMode: gameMode)
    }

}
// MARK: - MainMenuVC functions
extension MainMenuVC{
    
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
