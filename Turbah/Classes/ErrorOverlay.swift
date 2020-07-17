//
//  ErrorOverlay.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class ErrorOverlay: UIView {
    
    var message: String? {
        didSet {
            titleLabel.text = message
        }
    }
    
    var stack = UIStackView()
    var titleLabel = UILabel()
    var horizontalStack = UIStackView()
    var actionButton = VisualEffectText()
    var retryButton = VisualEffectText()
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        
        actionButton.title = "Settings"
        actionButton.titleLabel.textAlignment = .center
        actionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSettings)))
        retryButton.title = "Retry"
        retryButton.titleLabel.textAlignment = .center
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.addArrangedSubview(actionButton)
        horizontalStack.addArrangedSubview(retryButton)
        
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 50
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(horizontalStack)
        addSubview(stack)
        stack.centerInSuperview()
    }
    
    @objc func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else { return }
        UIApplication.shared.open(settingsUrl)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
}
