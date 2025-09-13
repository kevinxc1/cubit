//
//  SimpleAlertService.swift
//  Cubit
//

import Foundation
import UIKit

class SimpleAlertService
{
    var myVC = SimpleAlertViewController()
    
    // keyboard: 0 = decimal, 1 = text
    func alert(myTitle: String, completion: @escaping () -> Void) -> SimpleAlertViewController
    {
        let storyboard = UIStoryboard(name: "SimpleAlertViewController", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "SimpleAlertVC") as! SimpleAlertViewController
        alertVC.enterAction = completion
        alertVC.myTitle = myTitle
        myVC = alertVC
        return alertVC
    }
}
