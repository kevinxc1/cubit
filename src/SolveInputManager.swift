//
//  SolveInputManager.swift
//  Cubit
//

import UIKit

class SolveInputManager {
    
    enum SolveAction {
        case add
        case edit(index: Int)
        case delete(index: Int)
    }
    
    static func showSolveInputSheet(from viewController: UIViewController, action: SolveAction, completion: @escaping (String?, Int) -> Void) {
        
        let alertController = UIAlertController(title: titleForAction(action), message: nil, preferredStyle: .alert)
        
        // Configure based on action type
        switch action {
        case .add:
            setupAddSolveInput(alertController: alertController, completion: completion)
        case .edit(let index):
            setupEditSolveInput(alertController: alertController, index: index, completion: completion)
        case .delete(let index):
            setupDeleteConfirmation(alertController: alertController, index: index, completion: completion)
        }
        
        // Modern presentation style
        alertController.view.tintColor = .cubitAccent
        viewController.present(alertController, animated: true)
    }
    
    private static func titleForAction(_ action: SolveAction) -> String {
        switch action {
        case .add:
            return "Add Solve"
        case .edit:
            return "Edit Solve"
        case .delete:
            return "Delete Solve"
        }
    }
    
    private static func setupAddSolveInput(alertController: UIAlertController, completion: @escaping (String?, Int) -> Void) {
        
        // Time input
        alertController.addTextField { textField in
            textField.placeholder = "Time (e.g., 12.34)"
            textField.keyboardType = .decimalPad
            textField.autocorrectionType = .no
        }
        
        // Penalty selector
        let penalties = ["No penalty", "DNF", "+2"]
        var selectedPenalty = 0
        
        // Add penalty selection (simplified for alert)
        alertController.message = "Penalty: \(penalties[selectedPenalty])\n\nTap to change penalty:"
        
        // Actions
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            let time = alertController.textFields?[0].text ?? ""
            completion(time.isEmpty ? nil : time, selectedPenalty)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil, 0)
        }
        
        // Penalty cycle action
        let penaltyAction = UIAlertAction(title: "Change Penalty", style: .default) { _ in
            selectedPenalty = (selectedPenalty + 1) % penalties.count
            alertController.message = "Penalty: \(penalties[selectedPenalty])\n\nTap to change penalty:"
            
            // Re-present with updated penalty
            // Note: This is a simplified implementation
            completion(alertController.textFields?[0].text, selectedPenalty)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(penaltyAction)
        alertController.addAction(cancelAction)
        
        addAction.isEnabled = false
        
        // Enable add button when text is entered
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alertController.textFields?[0], queue: .main) { _ in
            addAction.isEnabled = !(alertController.textFields?[0].text?.isEmpty ?? true)
        }
    }
    
    private static func setupEditSolveInput(alertController: UIAlertController, index: Int, completion: @escaping (String?, Int) -> Void) {
        // Similar to add but pre-populate with existing data
        setupAddSolveInput(alertController: alertController, completion: completion)
        
        // Pre-populate with existing solve data if available
        if index < ViewController.mySession.times.count {
            let existingSolve = ViewController.mySession.times[index]
            alertController.textFields?[0].text = existingSolve.getMyString()
        }
    }
    
    private static func setupDeleteConfirmation(alertController: UIAlertController, index: Int, completion: @escaping (String?, Int) -> Void) {
        
        alertController.message = "Are you sure you want to delete this solve?"
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion("DELETE", index)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil, 0)
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
}