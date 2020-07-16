//
//  VisualEffectText.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class VisualEffectText: UIVisualEffectView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var vibrancyView = UIVisualEffectView()
    
    var titleLabel = UILabel()
    
    private func setupUI() {
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        vibrancyView.contentView.addSubview(titleLabel)
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
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

