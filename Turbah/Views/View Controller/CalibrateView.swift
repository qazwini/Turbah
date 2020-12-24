//
//  CalibrateView.swift
//  Turbah
//
//  Created by MMQ on 7/25/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class CalibrateView: UIVisualEffectView {
    
    var stack = UIStackView()
    var vibrancyView = UIVisualEffectView()
    var instructionLabel = UILabel()
    var calibrateImageView = UIImageView()
    var removeButton = UIImageView()
    
    private func setupViews() {
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 2
        instructionLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        instructionLabel.text = "Calibrate compass before use for better accuracy".localized
        
        calibrateImageView.contentMode = .scaleAspectFit
        calibrateImageView.image = #imageLiteral(resourceName: "calibrate").withRenderingMode(.alwaysTemplate)
        calibrateImageView.widthAnchor.constraint(equalToConstant: 164).isActive = true
        calibrateImageView.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 30
        stack.addArrangedSubview(calibrateImageView)
        stack.addArrangedSubview(instructionLabel)
        
        vibrancyView.contentView.addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 40, left: 30, bottom: 30, right: 30))
        
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))
        vibrancyView.contentView.addSubview(removeButton)
        removeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        removeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.roundCorners()
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}
