//
//  UIColor+Modern.swift
//  Cubit
//

import UIKit

extension UIColor {
    // Modern semantic colors that adapt to light/dark mode
    static var cubitBackground: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
    }
    
    static var cubitSecondaryBackground: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .systemGray6 : .systemGray5
        }
    }
    
    static var cubitPrimary: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    static var cubitSecondary: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .systemGray : .systemGray2
        }
    }
    
    static var cubitAccent: UIColor {
        return .systemBlue
    }
    
    static var cubitSuccess: UIColor {
        return .systemGreen
    }
    
    static var cubitWarning: UIColor {
        return .systemOrange
    }
    
    static var cubitError: UIColor {
        return .systemRed
    }
    
    static var cubitButtonBackground: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .systemGray5 : .systemGray6
        }
    }
}