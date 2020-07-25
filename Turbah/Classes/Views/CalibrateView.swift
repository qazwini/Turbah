//
//  CalibrateView.swift
//  Turbah
//
//  Created by MMQ on 7/25/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class CalibrateView: UIVisualEffectView {
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Calibrate compass before use for better accuracy"
        label.numberOfLines = 2
        return label
    }()
    
    private func setupViews() {
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(instructionLabel)
        instructionLabel.fillSuperview(padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
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
