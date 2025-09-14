//
//  UIFont+Modern.swift
//  Cubit
//

import UIKit

extension UIFont {
    // Modern typography scale
    static var cubitLargeTitle: UIFont {
        return UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    static var cubitTitle1: UIFont {
        return UIFont.preferredFont(forTextStyle: .title1)
    }
    
    static var cubitTitle2: UIFont {
        return UIFont.preferredFont(forTextStyle: .title2)
    }
    
    static var cubitTitle3: UIFont {
        return UIFont.preferredFont(forTextStyle: .title3)
    }
    
    static var cubitHeadline: UIFont {
        return UIFont.preferredFont(forTextStyle: .headline)
    }
    
    static var cubitBody: UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }
    
    static var cubitCallout: UIFont {
        return UIFont.preferredFont(forTextStyle: .callout)
    }
    
    static var cubitSubheadline: UIFont {
        return UIFont.preferredFont(forTextStyle: .subheadline)
    }
    
    static var cubitFootnote: UIFont {
        return UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    static var cubitCaption1: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption1)
    }
    
    static var cubitCaption2: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption2)
    }
    
    // Timer-specific fonts that scale properly
    static func cubitTimerFont(size: CGFloat) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
        let font = UIFont.monospacedDigitSystemFont(ofSize: size, weight: .regular)
        return UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: font)
    }
}