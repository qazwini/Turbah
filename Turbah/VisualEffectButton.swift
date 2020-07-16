//
//  VisualEffectButton.swift
//  Turbah
//
//  Created by MMQ on 7/15/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class VisualEffectButton: UIVisualEffectView {
    
    var vibrancyView = UIVisualEffectView()
    var button = UIButton()
    
    var visualEffectClicked: ((UITapGestureRecognizer) -> Void)?
    
    private func setupUI() {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 80).isActive = true
        heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        button.tintColor = .white
        
        vibrancyView.contentView.addSubview(button)
        button.centerInSuperview()
    }
    
    override func layoutSubviews() {
        layer.roundCorners(radius: 15)
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}
