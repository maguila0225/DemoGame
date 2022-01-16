//
//  MainMenuVC.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//
// MARK: - MainMenuVC imported libraries
import UIKit
import MaterialComponents.MaterialAppBar

// MARK: - MainMenuVC
class MainMenuVC: UIViewController {
// MARK: - MainMenuVC variable declaration
    @IBOutlet weak var singlePlayerButton: UIButton!
    let vcIdentifier = "MainMenuVC"
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
    }
}
// MARK: - MainMenuVC functions
extension MainMenuVC{
    func screenTransition (vcIdentifier: String, isFullScreen: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        if isFullScreen == true {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
}
