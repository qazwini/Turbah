//
//  SettingsFooterView.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class SettingsFooterView: UITableViewHeaderFooterView {
    
    var versionLabel = UILabel()
    
    private func setupUI() {
        versionLabel.text = "Version: \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)"
        versionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        versionLabel.textAlignment = .center
        versionLabel.textColor = UIColor { return ($0.userInterfaceStyle == .dark) ? UIColor(hexString: "333333") : UIColor(hexString: "CCCCCC") }
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(versionLabel)
        NSLayoutConstraint.activate([
            versionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            versionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}
