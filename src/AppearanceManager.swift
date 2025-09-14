//
//  AppearanceManager.swift
//  Cubit
//

import UIKit

class AppearanceManager {
    static let shared = AppearanceManager()
    
    private init() {}
    
    // Check if we're in dark mode (either manual or system)
    var isDarkMode: Bool {
        // Fallback to manual setting if system preference not available
        if ViewController.darkMode {
            return true
        }
        
        // Use system appearance
        if #available(iOS 13.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark
        }
        
        return ViewController.darkMode
    }
    
    // Apply modern appearance to any view controller
    func setupAppearance(for viewController: UIViewController) {
        // Override interface style if manual dark mode is enabled
        if #available(iOS 13.0, *), ViewController.darkMode {
            viewController.overrideUserInterfaceStyle = .dark
        }
    }
    
    // Modern way to update colors based on trait changes
    func updateColors(for view: UIView) {
        // Colors will automatically update due to semantic color usage
        view.setNeedsDisplay()
        
        // Force update for subviews
        view.subviews.forEach { subview in
            updateColors(for: subview)
        }
    }
    
    // Legacy support for old dark mode methods
    func applyLegacyDarkMode(to viewController: UIViewController) {
        guard ViewController.darkMode else { return }
        
        if #available(iOS 13.0, *) {
            viewController.overrideUserInterfaceStyle = .dark
        } else {
            // Fallback for iOS 12 and below
            applyDarkModeColorsLegacy(to: viewController.view)
        }
    }
    
    private func applyDarkModeColorsLegacy(to view: UIView) {
        // Legacy dark mode implementation for iOS 12
        view.backgroundColor = .black
        
        if let label = view as? UILabel {
            label.textColor = .white
        } else if let button = view as? UIButton {
            button.backgroundColor = .darkGray
            button.setTitleColor(.white, for: .normal)
        }
        
        // Apply to subviews
        view.subviews.forEach { subview in
            applyDarkModeColorsLegacy(to: subview)
        }
    }
}