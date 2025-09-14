//
//  HapticManager.swift
//  Cubit
//

import UIKit

class HapticManager {
    private let impactLight = UIImpactFeedbackGenerator(style: .light)
    private let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private let selection = UISelectionFeedbackGenerator()
    private let notification = UINotificationFeedbackGenerator()
    
    enum HapticType {
        case light
        case medium
        case heavy
        case selection
        case success
        case warning
        case error
    }
    
    func trigger(_ type: HapticType) {
        switch type {
        case .light:
            impactLight.prepare()
            impactLight.impactOccurred()
        case .medium:
            impactMedium.prepare()
            impactMedium.impactOccurred()
        case .heavy:
            impactHeavy.prepare()
            impactHeavy.impactOccurred()
        case .selection:
            selection.prepare()
            selection.selectionChanged()
        case .success:
            notification.prepare()
            notification.notificationOccurred(.success)
        case .warning:
            notification.prepare()
            notification.notificationOccurred(.warning)
        case .error:
            notification.prepare()
            notification.notificationOccurred(.error)
        }
    }
}

// Convenience extension for easy access
extension UIViewController {
    private static let hapticManager = HapticManager()
    
    func haptic(_ type: HapticManager.HapticType) {
        UIViewController.hapticManager.trigger(type)
    }
}