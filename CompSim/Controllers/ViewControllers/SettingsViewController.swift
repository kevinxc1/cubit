//
//  EventViewController.swift
//  CompSim
//
//  Created by Rami Sbahi on 8/4/19.
//  Copyright © 2019 Rami Sbahi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var DarkModeLabel: UILabel!
    @IBOutlet weak var DarkModeControl: UISegmentedControl!
    
    @IBOutlet weak var solveTypeLabel: UILabel!
    @IBOutlet weak var solveTypeControl: UISegmentedControl!
    // checked for when view disappears, no point updating every time it changes
    
    @IBAction func DarkModeChanged(_ sender: Any) {
        ViewController.changedDarkMode = true
        if(!ViewController.darkMode) // not dark, set to dark
        {
            makeDarkMode()
            ViewController.darkMode = true
        }
        else // dark, turn off
        {
            turnOffDarkMode()
            ViewController.darkMode = false
        }
    }
    
    func makeDarkMode()
    {
        Background.isHidden = false
        ScrambleTypeButton.backgroundColor = UIColor.darkGray
        DarkModeLabel.backgroundColor = UIColor.darkGray
        solveTypeLabel.backgroundColor = UIColor.darkGray
        DarkModeControl.tintColor = ViewController.orangeColor()
        solveTypeControl.tintColor = ViewController.orangeColor()
    }
    
    func turnOffDarkMode()
    {
        Background.isHidden = true
        ScrambleTypeButton.backgroundColor = UIColor.init(displayP3Red: 8/255, green: 4/255, blue: 68/255, alpha: 1)
        DarkModeLabel.backgroundColor = UIColor.init(displayP3Red: 8/255, green: 4/255, blue: 68/255, alpha: 1)
        solveTypeLabel.backgroundColor = UIColor.init(displayP3Red: 8/255, green: 4/255, blue: 68/255, alpha: 1)
        DarkModeControl.tintColor = ViewController.blueColor()
        solveTypeControl.tintColor = ViewController.blueColor()
    }
    
    
    @IBOutlet var eventCollection: [UIButton]!
    
    @IBOutlet weak var ScrambleTypeButton: UIButton!
    
    @IBAction func handleSelection(_ sender: UIButton) // clicked select
    {
        eventCollection.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    

    override func viewDidLoad() {
        if(ViewController.darkMode)
        {
            DarkModeControl.selectedSegmentIndex = 0
            makeDarkMode()
        }
        else
        {
            turnOffDarkMode()
        }
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        eventCollection.forEach { (button) in
            button.isHidden = true
        }
        if(ViewController.ao5)
        {
            solveTypeControl.selectedSegmentIndex = 0
        }
        else if(ViewController.mo3)
        {
            solveTypeControl.selectedSegmentIndex = 1
        }
        else
        {
            solveTypeControl.selectedSegmentIndex = 2
        }
        
        if(ViewController.currentIndex > 0) // started average, wont allow change
        {
            solveTypeControl.isEnabled = false
        }
        else
        {
            solveTypeControl.isEnabled = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(false)
        
        switch(solveTypeControl.selectedSegmentIndex)
        {
        case 0:
            ViewController.ao5 = true
            ViewController.mo3 = false
            ViewController.bo3 = false
            break
        case 1:
            ViewController.mo3 = true
            ViewController.ao5 = false
            ViewController.bo3 = false
            break
        default:
            ViewController.bo3 = true
            ViewController.ao5 = false
            ViewController.mo3 = false
        }
    }
    
    enum Events: String
    {
        case twoCube = "2x2x2"
        case threeCube = "3x3x3"
        case fourCube = "4x4x4"
        case fiveCube = "5x5x5"
        case sixCube = "6x6x6"
        case sevenCube = "7x7x7"
        case pyra = "Pyraminx"
        case mega = "Megaminx"
        case sq1 = "Square-1"
        case skewb = "Skewb"
        case clock = "Clock"
        case nonMag = "Non-Mag November"
    }
    
    @IBAction func eventTapped(_ sender: UIButton) {
        
        eventCollection.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
        
        guard let title = sender.currentTitle, let event = Events(rawValue: title) else
        {
            return // doesn't have title
        }
        
        ScrambleTypeButton.setTitle("Scramble Type: \(title)", for: .normal)
        
        switch event
        {
        case .twoCube:
            ViewController.scrambler.doEvent(event: 0)
        case .threeCube:
            ViewController.scrambler.doEvent(event: 1)
        case .fourCube:
            ViewController.scrambler.doEvent(event: 2)
        case .fiveCube:
            ViewController.scrambler.doEvent(event: 3)
        case .sixCube:
            ViewController.scrambler.doEvent(event: 4)
        case .sevenCube:
            ViewController.scrambler.doEvent(event: 5)
        case .pyra:
            ViewController.scrambler.doEvent(event: 6)
        case .mega:
            ViewController.scrambler.doEvent(event: 7)
        case .sq1:
            ViewController.scrambler.doEvent(event: 8)
        case .skewb:
            ViewController.scrambler.doEvent(event: 9)
        case .clock:
            ViewController.scrambler.doEvent(event: 10)
        case .nonMag:
            ViewController.scrambler.doEvent(event: 11)
        default:
            print("op")
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
