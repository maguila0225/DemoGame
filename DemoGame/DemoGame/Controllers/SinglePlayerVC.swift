//
//  SinglePlayerVCViewController.swift
//  DemoGame
//
//  Created by OPSolutions on 1/16/22.
//

import UIKit
import MaterialComponents.MaterialAppBar

// MARK: - SinglePlayerVC
class SinglePlayerVC: UIViewController {
// MARK: - SinglePlayerVC variable declaration

    @IBOutlet weak var p1SelectedImage: UIImageView!
    @IBOutlet weak var p2SelectedImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rockButton: UIImageView!
    @IBOutlet weak var paperButton: UIImageView!
    @IBOutlet weak var ScissorsButton: UIImageView!
    @IBOutlet weak var lizardButton: UIImageView!
    @IBOutlet weak var spockButton: UIImageView!
    let vcIdentifier = "SinglePlayerVC"
    
// MARK: - SinglePlayerVC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalLog_Load(vc_Log: vcIdentifier)
        p1SelectedImage.image = UIImage(named: "Rock.png")
        p2SelectedImage.image = UIImage(named: "Spock.png")
        rockButton.image = UIImage(named: "Rock.png")
        paperButton.image = UIImage(named: "Paper.png")
        ScissorsButton.image = UIImage(named: "Scissors.png")
        lizardButton.image = UIImage(named: "Lizard.png")
        spockButton.image = UIImage(named: "Spock.png")
        
    }
    override func  viewWillAppear(_ animated: Bool) {
        GlobalLog_Display(vc_Log: vcIdentifier)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GlobalLog_Dismiss(vc_Log: vcIdentifier)
    }
// MARK: - SinglePlayerVC IBAction
    @IBAction func singlePlayerButton(_ sender: Any) {
    }
}
// MARK: - SinglePlayerVC functions
extension SinglePlayerVC{
    func screenTransition (vcIdentifier: String, isFullScreen: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: vcIdentifier)
        if isFullScreen == true {
            vc.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: true, completion: nil)
    }
}
