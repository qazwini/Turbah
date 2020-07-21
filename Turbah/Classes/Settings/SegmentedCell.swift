//
//  SegmentedCell.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class SegmentedCell: UITableViewCell {
    
    static let id = "segmentedCell"
    
    var segmentedControl = UISegmentedControl()
    
    private func setupUI() {
        segmentedControl.insertSegment(withTitle: "True North", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Magnetic North", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = (save.northType == .trueNorth) ? 0 : 1
        addSubview(segmentedControl)
        segmentedControl.fillSuperview(padding: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
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
