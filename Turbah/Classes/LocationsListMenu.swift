//
//  LocationsListMenu.swift
//  Turbah
//
//  Created by MMQ on 7/17/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class LocationsListMenu: UIVisualEffectView, UITableViewDelegate, UITableViewDataSource {
    
    var locationObjects = [Coordinates]()
    
    var tableView = UITableView()
    var totalHeight: CGFloat {
        return height * CGFloat(locationObjects.count)
    }
    var height: CGFloat = 55
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        effect = blurEffect
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.roundCorners()
    }
    
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "y\(indexPath.row)lo"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationObjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
    
}
