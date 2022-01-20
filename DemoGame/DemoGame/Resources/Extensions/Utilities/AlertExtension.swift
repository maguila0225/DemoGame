//
//  AlertExtension.swift
//  DemoGame
//
//  Created by OPSolutions on 1/20/22.
//

import Foundation
import UIKit
import MaterialComponents.MaterialDialogs

extension UIViewController {
    func gameAlert(alertTitle: String, alertMessage: String){
        let alertController = MDCAlertController(title: alertTitle, message: alertMessage)
        let action = MDCAlertAction(title:"OK") { (action) in print("OK") }
        alertController.addAction(action)
        self.present(alertController, animated:true, completion: nil)
    }
    
    func GlobalLog_Load (vc_Log: String){
        NSLog("View Controller \(vc_Log) Loaded")
    }

    func GlobalLog_Display (vc_Log: String){
        NSLog("View Controller \(vc_Log) Appeared")
    }

    func GlobalLog_Dismiss (vc_Log: String){
        NSLog("View Controller \(vc_Log) Disappeared")
    }
}
