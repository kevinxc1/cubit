//
//  AlertService.swift
//  Cubit
//

import Foundation
import UIKit

class AlertService
{
    var myVC = AddSolveAlertViewController()
    
    // keyboard: 0 = decimal, 1 = text
    func alert(placeholder: String, usingPenalty: Bool, keyboardType: Int, myTitle: String, completion: @escaping () -> Void) -> AddSolveAlertViewController
    {
        let storyboard = UIStoryboard(name: "AddSolveAlert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AddSolveAlertVC") as! AddSolveAlertViewController
        alertVC.enterAction = completion
        alertVC.myTitle = myTitle
        alertVC.keyboardType = keyboardType
        alertVC.usingPenalty = usingPenalty
        alertVC.placeholder = placeholder
        myVC = alertVC
        return alertVC
    }
}
