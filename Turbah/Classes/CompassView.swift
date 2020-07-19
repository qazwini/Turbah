//
//  CompassView.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class CompassView: UIVisualEffectView {
    
    var vibrancyView = UIVisualEffectView()
    
    var personGradImageView = UIImageView()
    var kabaImageView = UIImageView()
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        effect = blurEffect
        layer.masksToBounds = true
        layer.cornerRadius = 30
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        personGradImageView.image = UIImage(named: "radar")?.withRenderingMode(.alwaysTemplate)
        kabaImageView.image = UIImage(named: "kaba")?.withRenderingMode(.alwaysTemplate)
        
        vibrancyView.contentView.addSubview(personGradImageView)
        personGradImageView.fillSuperview()
        vibrancyView.contentView.addSubview(kabaImageView)
        kabaImageView.fillSuperview()
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
