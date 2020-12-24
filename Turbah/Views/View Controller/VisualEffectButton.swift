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
            titleLabel?.textAlignment = .center
            titleLabel!.font = .systemFont(ofSize: 16, weight: .semibold)
            vibrancyView.contentView.addSubview(titleLabel!)
            titleLabel!.fillSuperview(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
    }
    
    var newTitle: String? {
        didSet {
            guard let titleLabel = self.titleLabel, let newTitle = self.newTitle else { return }
            titleLabel.text = newTitle
            layoutIfNeeded()
        }
    }
    
    var vibrancyView = UIVisualEffectView()
    
    var titleLabel: UILabel?
    var imageView: UIImageView?
    
    private func setupUI() {
        effect = blurEffect
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
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
