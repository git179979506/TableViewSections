//
//  ViewController.swift
//  TableViewSections
//
//  Created by zhaoshouwen on 06/03/2024.
//  Copyright (c) 2024 zhaoshouwen. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        if indexPath.row == 0 {
            navigationController?.pushViewController(PlanType1ViewController(), animated: true)
        } else if indexPath.row == 1 {
            navigationController?.pushViewController(PlanType2ViewController(), animated: true)
        }
    }
}

