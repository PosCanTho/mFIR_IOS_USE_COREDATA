//
//  ListReporterViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/29/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ListReporterViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvReporter: UITableView!

    var list: [String] = ["Pham Van Thien","Pham Van Huong", "Le Tuan Kiet la mot thang khung dien ba chon qua troi qua dat", "Tong Thanh Vinh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvReporter.delegate = self
        tvReporter.dataSource = self
        
        tvReporter.estimatedRowHeight = 50
        tvReporter.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = list[indexPath.row]
        cell!.textLabel?.numberOfLines = 0
        return cell!
    }
    
}
