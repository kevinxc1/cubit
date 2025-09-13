//
//  NotificationAlertService.swift
//  Cubit
//

import Foundation
import UIKit

class NotificationAlertService
{
    var myVC = NotificationAlertViewController()
    
    // keyboard: 0 = decimal, 1 = text
    func alert(myTitle: String) -> NotificationAlertViewController
    {
        let storyboard = UIStoryboard(name: "NotificationAlert", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "NotificationAlertVC") as! NotificationAlertViewController
        alertVC.myTitle = myTitle
        myVC = alertVC
        return alertVC
    }
}
