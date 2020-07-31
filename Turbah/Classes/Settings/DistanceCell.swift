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
    var sliderStack = UIStackView()
    var smallIcon = UIImageView()
    var largeIcon = UIImageView()
    var distanceSlider = TickedSlider()
    
    private func setupUI() {
        let reverseColor = UIColor { return $0.userInterfaceStyle == .dark ? .white : .black }
        
        titleLabel.text = "TurbahDistance".localized()
        
        distanceSlider.minimumValue = 1
        distanceSlider.maximumValue = 5
        distanceSlider.value = save.distance
        distanceSlider.setThumbImage(#imageLiteral(resourceName: "thumb").withTintColor(reverseColor), for: .normal)
        distanceSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        distanceSlider.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sliderTapped(_:))))
        distanceSlider.translatesAutoresizingMaskIntoConstraints = false
        
        smallIcon.image = #imageLiteral(resourceName: "shortDistance").withTintColor(distanceSlider.tickColor)
        largeIcon.image = #imageLiteral(resourceName: "longDistance").withTintColor(distanceSlider.tickColor)
        
        NSLayoutConstraint.activate([
            distanceSlider.heightAnchor.constraint(equalToConstant: 12),
            smallIcon.widthAnchor.constraint(equalToConstant: 20),
            largeIcon.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        sliderStack.axis = .horizontal
        sliderStack.alignment = .fill
        sliderStack.distribution = .fill
        sliderStack.spacing = 15
        sliderStack.addArrangedSubview(smallIcon)
        sliderStack.addArrangedSubview(distanceSlider)
        sliderStack.addArrangedSubview(largeIcon)
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(sliderStack)
        contentView.addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let rounded = round(sender.value)
        sender.value = rounded
        guard rounded != save.distance else { return }
        hapticFeedback()
        save.distance = rounded
    }
    
    @objc private func sliderTapped(_ sender: UITapGestureRecognizer) {
        let pointTapped = sender.location(in: self.contentView)
        let positionOfSlider = distanceSlider.frame.origin
        let widthOfSlider = distanceSlider.frame.size.width
        let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(distanceSlider.maximumValue) / widthOfSlider)
        let rounded = Float(round(newValue))
        distanceSlider.setValue(Float(round(newValue)), animated: true)
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
