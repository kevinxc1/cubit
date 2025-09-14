//
//  TimerManager.swift
//  Cubit
//

import Foundation

class TimerManager {
    private var timer: Timer?
    private var inspectionTimer: Timer?
    
    func scheduleTimer(timeInterval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        invalidateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: block)
        return timer!
    }
    
    func scheduleInspectionTimer(timeInterval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        invalidateInspectionTimer()
        inspectionTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: repeats, block: block)
        return inspectionTimer!
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func invalidateInspectionTimer() {
        inspectionTimer?.invalidate()
        inspectionTimer = nil
    }
    
    func invalidateAllTimers() {
        invalidateTimer()
        invalidateInspectionTimer()
    }
    
    deinit {
        invalidateAllTimers()
    }
}