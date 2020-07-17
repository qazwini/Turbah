//
//  SettingsVC.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    struct section {
        var name: sectionNames
        var cells: [cell]
        
        enum sectionNames {
            case about
        }
    }
    
    struct cell {
        var name: cellNames
        
        enum cellNames {
            case red
        }
    }
    
    let sectionArray = [
        section(name: .about, cells: [
            cell(name: .red),
            cell(name: .red),
            cell(name: .red),
            cell(name: .red),
            cell(name: .red)
        ]),
        section(name: .about, cells: [
            cell(name: .red),
            cell(name: .red),
            cell(name: .red),
            cell(name: .red),
            cell(name: .red)
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: self.tableView.frame, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
    }
    
    @objc func donePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionArray[indexPath.section].cells[indexPath.row].name {
        case .red: break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "y\(indexPath.row)lo"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].cells.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sectionArray[section].name {
        case .about: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == (tableView.numberOfSections - 1) {
            return SettingsFooterView()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == (tableView.numberOfSections - 1) {
            return 75
        }
        return .leastNormalMagnitude
    }

}
