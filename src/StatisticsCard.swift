//
//  StatisticsCard.swift
//  Cubit
//

import UIKit

class StatisticsCard: UIView {
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let iconImageView = UIImageView()
    private let stackView = UIStackView()
    
    struct StatData {
        let title: String
        let value: String
        let subtitle: String?
        let icon: String? // SF Symbol name
        let color: UIColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        applyCubitCardStyle()
        
        // Setup labels
        titleLabel.font = .cubitCaption1
        titleLabel.textColor = .cubitSecondary
        titleLabel.textAlignment = .center
        
        valueLabel.font = .cubitTitle2
        valueLabel.textColor = .cubitPrimary
        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.7
        
        subtitleLabel.font = .cubitCaption2
        subtitleLabel.textColor = .cubitSecondary
        subtitleLabel.textAlignment = .center
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .cubitAccent
        
        // Setup stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with data: StatData) {
        titleLabel.text = data.title
        valueLabel.text = data.value
        subtitleLabel.text = data.subtitle
        subtitleLabel.isHidden = data.subtitle == nil
        
        if let iconName = data.icon {
            iconImageView.image = UIImage(systemName: iconName)
            iconImageView.tintColor = data.color
            iconImageView.isHidden = false
        } else {
            iconImageView.isHidden = true
        }
        
        // Add subtle color accent
        layer.borderColor = data.color.withAlphaComponent(0.2).cgColor
        layer.borderWidth = 1
    }
    
    // Animation for value updates
    func animateValueChange(to newValue: String) {
        UIView.transition(with: valueLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.valueLabel.text = newValue
        }
    }
}

// Helper to create common statistics cards
extension StatisticsCard {
    static func createBestTimeCard(time: String) -> StatisticsCard {
        let card = StatisticsCard()
        let data = StatData(
            title: "Best Time",
            value: time,
            subtitle: nil,
            icon: "star.fill",
            color: .cubitSuccess
        )
        card.configure(with: data)
        return card
    }
    
    static func createAverageCard(average: String, count: Int) -> StatisticsCard {
        let card = StatisticsCard()
        let data = StatData(
            title: "Average",
            value: average,
            subtitle: "of \(count)",
            icon: "chart.line.uptrend.xyaxis",
            color: .cubitAccent
        )
        card.configure(with: data)
        return card
    }
    
    static func createTotalSolvesCard(count: Int) -> StatisticsCard {
        let card = StatisticsCard()
        let data = StatData(
            title: "Total Solves",
            value: "\(count)",
            subtitle: nil,
            icon: "number.square.fill",
            color: .cubitSecondary
        )
        card.configure(with: data)
        return card
    }
}