//
//  UserDefaultsWrapper.swift
//  Cubit
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

extension AppDelegate {
    struct Settings {
        @UserDefault(key: "darkMode", defaultValue: false)
        static var darkMode: Bool
        
        @UserDefault(key: "cuber", defaultValue: "")
        static var cuber: String
        
        @UserDefault(key: "ao5", defaultValue: false)
        static var ao5: Bool
        
        @UserDefault(key: "mo3", defaultValue: false)
        static var mo3: Bool
        
        @UserDefault(key: "bo3", defaultValue: false)
        static var bo3: Bool
        
        @UserDefault(key: "timing", defaultValue: 0)
        static var timing: Int
        
        @UserDefault(key: "inspection", defaultValue: false)
        static var inspection: Bool
        
        @UserDefault(key: "holdingTime", defaultValue: 0.0)
        static var holdingTime: Double
        
        @UserDefault(key: "event", defaultValue: 0)
        static var event: Int
        
        @UserDefault(key: "sessionName", defaultValue: "")
        static var sessionName: String
        
        @UserDefault(key: "timerUpdate", defaultValue: 0)
        static var timerUpdate: Int
    }
}