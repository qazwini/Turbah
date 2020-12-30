//
//  LocationListCell.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class LocationListCell: UITableViewCell {
    
    static let id = "locationListCell"
    
    var vibrancyView = UIVisualEffectView()
    var titleLabel = UILabel()
    
    private func setupUI() {
        backgroundColor = .clear
        
        vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: .secondaryLabel)
        contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        vibrancyView.contentView.addSubview(titleLabel)
        titleLabel.fillSuperview(padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
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
