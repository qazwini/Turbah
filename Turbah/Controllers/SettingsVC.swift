//
//  SettingsVC.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
    }
    
    @objc func donePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.textLabel?.text = "y\(indexPath.row)lo"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

}
