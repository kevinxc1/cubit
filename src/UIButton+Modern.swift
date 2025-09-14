//
//  UIButton+Modern.swift
//  Cubit
//

import UIKit

extension UIButton {
    
    enum CubitButtonStyle {
        case primary
        case secondary
        case destructive
        case ghost
    }
    
    func applyCubitStyle(_ style: CubitButtonStyle) {
        // Remove old styling
        backgroundColor = nil
        layer.cornerRadius = 0
        layer.borderWidth = 0
        layer.borderColor = nil
        
        // Apply modern styling
        layer.cornerRadius = 12
        titleLabel?.font = .cubitHeadline
        
        // Add subtle shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        switch style {
        case .primary:
            backgroundColor = .cubitAccent
            setTitleColor(.white, for: .normal)
            setTitleColor(.white.withAlphaComponent(0.7), for: .highlighted)
            
        case .secondary:
            backgroundColor = .cubitButtonBackground
            setTitleColor(.cubitPrimary, for: .normal)
            setTitleColor(.cubitSecondary, for: .highlighted)
            
        case .destructive:
            backgroundColor = .cubitError
            setTitleColor(.white, for: .normal)
            setTitleColor(.white.withAlphaComponent(0.7), for: .highlighted)
            
        case .ghost:
            backgroundColor = .clear
            setTitleColor(.cubitAccent, for: .normal)
            setTitleColor(.cubitSecondary, for: .highlighted)
            layer.borderWidth = 1
            layer.borderColor = UIColor.cubitAccent.cgColor
        }
        
        // Add press animation
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
    
    // Convenience methods
    func makePrimary() {
        applyCubitStyle(.primary)
    }
    
    func makeSecondary() {
        applyCubitStyle(.secondary)
    }
    
    func makeDestructive() {
        applyCubitStyle(.destructive)
    }
    
    func makeGhost() {
        applyCubitStyle(.ghost)
    }
}