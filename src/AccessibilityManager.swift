//
//  AccessibilityManager.swift
//  Cubit
//

import UIKit

class AccessibilityManager {
    static let shared = AccessibilityManager()
    
    private init() {}
    
    func setupAccessibility(for viewController: UIViewController) {
        // Voice Over support
        if UIAccessibility.isVoiceOverRunning {
            setupVoiceOverSupport(for: viewController)
        }
        
        // Keyboard navigation
        setupKeyboardShortcuts(for: viewController)
        
        // Dynamic Type support
        setupDynamicType(for: viewController)
    }
    
    private func setupVoiceOverSupport(for viewController: UIViewController) {
        // Make timer accessible
        if let timerVC = viewController as? TimerViewController {
            timerVC.view.isAccessibilityElement = false
            timerVC.view.accessibilityElements = [
                timerVC.TimerLabel as Any,
                timerVC.SubmitButton as Any,
                timerVC.CancelButton as Any
            ]
            
            timerVC.TimerLabel?.accessibilityLabel = "Timer"
            timerVC.TimerLabel?.accessibilityHint = "Shows current solve time"
            
            timerVC.SubmitButton?.accessibilityLabel = "Submit solve"
            timerVC.SubmitButton?.accessibilityHint = "Submit current solve time"
            
            timerVC.CancelButton?.accessibilityLabel = "Cancel solve"
            timerVC.CancelButton?.accessibilityHint = "Cancel current solve and return to main screen"
        }
        
        // Make main view accessible
        if let mainVC = viewController as? ViewController {
            mainVC.ScrambleLabel?.accessibilityLabel = "Current scramble"
            mainVC.ScrambleLabel?.accessibilityHint = "Tap to start timer, double tap for new scramble"
            
            // Make time buttons accessible
            for (index, button) in mainVC.TimesCollection.enumerated() {
                button.accessibilityLabel = "Solve \(index + 1)"
                button.accessibilityHint = "Time: \(button.titleLabel?.text ?? "Not set")"
            }
        }
    }
    
    private func setupKeyboardShortcuts(for viewController: UIViewController) {
        guard #available(iOS 13.4, *) else { return }
        
        if let mainVC = viewController as? ViewController {
            // Space bar for new scramble
            let newScrambleCommand = UIKeyCommand(
                input: " ",
                modifierFlags: [],
                action: #selector(mainVC.newScramblePressed(_:))
            )
            newScrambleCommand.title = "New Scramble"
            
            // 'A' for add solve
            let addSolveCommand = UIKeyCommand(
                input: "a",
                modifierFlags: [],
                action: #selector(mainVC.addSolveKeyboard)
            )
            addSolveCommand.title = "Add Solve"
            
            // 'R' for reset
            let resetCommand = UIKeyCommand(
                input: "r",
                modifierFlags: .command,
                action: #selector(mainVC.resetPressed(_:))
            )
            resetCommand.title = "Reset Session"
            
            // 'T' for timer
            let timerCommand = UIKeyCommand(
                input: "t",
                modifierFlags: [],
                action: #selector(mainVC.startTimerKeyboard)
            )
            timerCommand.title = "Start Timer"
            
            mainVC.addKeyCommand(newScrambleCommand)
            mainVC.addKeyCommand(addSolveCommand)
            mainVC.addKeyCommand(resetCommand)
            mainVC.addKeyCommand(timerCommand)
        }
    }
    
    private func setupDynamicType(for viewController: UIViewController) {
        // Ensure all fonts respond to Dynamic Type changes
        NotificationCenter.default.addObserver(
            forName: UIContentSizeCategory.didChangeNotification,
            object: nil,
            queue: .main
        ) { _ in
            self.updateFontsForDynamicType(viewController: viewController)
        }
    }
    
    private func updateFontsForDynamicType(viewController: UIViewController) {
        // Update fonts when Dynamic Type changes
        if let timerVC = viewController as? TimerViewController {
            timerVC.TimerLabel?.font = UIFont.cubitTimerFont(size: 72)
            timerVC.SubmitButton?.titleLabel?.font = .cubitHeadline
            timerVC.CancelButton?.titleLabel?.font = .cubitHeadline
        }
        
        viewController.view.setNeedsLayout()
    }
}