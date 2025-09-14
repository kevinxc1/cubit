//
//  UIViewController+KeyboardShortcuts.swift
//  Cubit
//

import UIKit

extension ViewController {
    
    @objc func addSolveKeyboard() {
        addSolve()
    }
    
    @objc func startTimerKeyboard() {
        if ViewController.timing && (ViewController.inspection || ViewController.holdingTime < 0.01) {
            performSegue(withIdentifier: "timerSegue", sender: self)
        }
    }
}