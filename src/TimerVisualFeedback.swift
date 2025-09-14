//
//  TimerVisualFeedback.swift
//  Cubit
//

import UIKit

class TimerVisualFeedback {
    private weak var timerLabel: UILabel?
    private var backgroundView: UIView?
    private var progressRing: CAShapeLayer?
    
    init(timerLabel: UILabel, containerView: UIView) {
        self.timerLabel = timerLabel
        setupBackgroundView(in: containerView)
        setupProgressRing(around: timerLabel)
    }
    
    private func setupBackgroundView(in container: UIView) {
        backgroundView = UIView()
        backgroundView?.translatesAutoresizingMaskIntoConstraints = false
        backgroundView?.backgroundColor = UIColor.cubitBackground.withAlphaComponent(0.95)
        backgroundView?.roundCorners(radius: 20)
        backgroundView?.isHidden = true
        
        if let bg = backgroundView {
            container.addSubview(bg)
            container.sendSubviewToBack(bg)
            
            NSLayoutConstraint.activate([
                bg.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                bg.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                bg.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
                bg.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.4)
            ])
        }
    }
    
    private func setupProgressRing(around label: UILabel) {
        progressRing = CAShapeLayer()
        progressRing?.fillColor = UIColor.clear.cgColor
        progressRing?.strokeColor = UIColor.cubitAccent.cgColor
        progressRing?.lineWidth = 8
        progressRing?.strokeEnd = 0
        progressRing?.lineCap = .round
        
        if let ring = progressRing {
            label.layer.addSublayer(ring)
        }
    }
    
    func updateProgressRing(progress: CGFloat) {
        guard let label = timerLabel else { return }
        
        let radius = min(label.bounds.width, label.bounds.height) / 2 + 20
        let center = CGPoint(x: label.bounds.midX, y: label.bounds.midY)
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressRing?.path = path.cgPath
        progressRing?.strokeEnd = progress
    }
    
    func showInspectionMode() {
        backgroundView?.isHidden = false
        backgroundView?.backgroundColor = UIColor.cubitWarning.withAlphaComponent(0.1)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView?.alpha = 1
        }
    }
    
    func showReadyMode() {
        backgroundView?.backgroundColor = UIColor.cubitSuccess.withAlphaComponent(0.1)
        progressRing?.strokeColor = UIColor.cubitSuccess.cgColor
    }
    
    func showTimingMode() {
        backgroundView?.backgroundColor = UIColor.cubitBackground.withAlphaComponent(0.95)
        progressRing?.strokeColor = UIColor.cubitAccent.cgColor
        progressRing?.strokeEnd = 0
    }
    
    func hideVisualFeedback() {
        UIView.animate(withDuration: 0.3) {
            self.backgroundView?.alpha = 0
        } completion: { _ in
            self.backgroundView?.isHidden = true
        }
        
        progressRing?.strokeEnd = 0
    }
    
    func pulseEffect() {
        guard let bg = backgroundView else { return }
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: .autoreverse, animations: {
            bg.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            bg.transform = .identity
        }
    }
}