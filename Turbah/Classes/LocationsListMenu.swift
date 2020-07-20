//
//  LocationsListMenu.swift
//  Turbah
//
//  Created by MMQ on 7/17/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class LocationsListMenu: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var rowClicked: ((Locations) -> Void)?
    
    let locations = Locations.allLocations
    let cellHeight: CGFloat = 47
    
    var height: CGFloat { return cellHeight * CGFloat(locations.count) }
    let width: CGFloat = 250
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
        
        delegate = self
        dataSource = self
        isScrollEnabled = false
        backgroundColor = nil
        backgroundView = UIVisualEffectView(effect: blurEffect)
        separatorEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .separator)
        separatorInset = .zero
        delaysContentTouches = false
        register(LocationListCell.self, forCellReuseIdentifier: LocationListCell.id)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.roundCorners(radius: 15)
    }
    
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationListCell.id, for: indexPath) as! LocationListCell
        cell.titleLabel.text = locations[indexPath.row].name
        if indexPath.row == locations.count - 1 { cell.separatorInset.left = width }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowClicked?(locations[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
