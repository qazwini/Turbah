//
//  VisualEffectButton.swift
//  Turbah
//
//  Created by MMQ on 7/15/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class VisualEffectButton: UIVisualEffectView {
    
    var image: UIImage? {
        didSet {
            imageView = UIImageView()
            imageView!.contentMode = .scaleAspectFit
            imageView!.image = image
            vibrancyView.contentView.addSubview(imageView!)
            imageView!.centerInSuperview()
        }
    }
    
    var title: String? {
        didSet {
            titleLabel = UILabel()
            titleLabel!.text = title
            titleLabel!.font = .systemFont(ofSize: 16, weight: .semibold)
            vibrancyView.contentView.addSubview(titleLabel!)
            titleLabel!.centerInSuperview()
        }
    }
    
    var vibrancyView = UIVisualEffectView()
    
    var titleLabel: UILabel?
    var imageView: UIImageView?
    
    private func setupUI() {
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 80).isActive = true
        heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
