//
//  NotificationAlertViewController.swift
//  Cubit
//

import UIKit




class NotificationAlertViewController: UIViewController
{
    @IBOutlet var NotifView: UIView!
    @IBOutlet var NotifTitle: UILabel!
    
    var myTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotifTitle.text = myTitle
        NotifView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        if(ViewController.darkMode)
        {
            NotifView.backgroundColor = .darkGray
        }
    }

    @IBAction func OKPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
