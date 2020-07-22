//
//  DistanceCell.swift
//  Turbah
//
//  Created by MMQ on 7/21/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class DistanceCell: UITableViewCell {

    static let id = "distanceCell"
    
    private var stack = UIStackView()
    var titleLabel = UILabel()
    var distanceSlider = TickedSlider()
    
    private func setupUI() {
        let reverseColor = UIColor { return $0.userInterfaceStyle == .dark ? .white : .black }
        
        titleLabel.text = "Turbah distance"
        
        distanceSlider.minimumValue = 1
        distanceSlider.maximumValue = 5
        distanceSlider.value = save.distance
        distanceSlider.minimumTrackTintColor = reverseColor
        distanceSlider.setThumbImage(#imageLiteral(resourceName: "thumb").withTintColor(reverseColor), for: .normal)
        distanceSlider.addTarget(self, action: #selector(sliderValueChanged(_:_:)), for: .valueChanged)
        distanceSlider.translatesAutoresizingMaskIntoConstraints = false
        distanceSlider.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(distanceSlider)
        contentView.addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider, _ event: UIEvent) {
        let rounded = round(sender.value)
        sender.value = rounded
        guard rounded != save.distance else { return }
        hapticFeedback()
        save.distance = rounded
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

}
