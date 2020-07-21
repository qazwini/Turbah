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
    var distanceSlider = UISlider()
    
    private func setupUI() {
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(distanceSlider)
        addSubview(stack)
        stack.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
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
