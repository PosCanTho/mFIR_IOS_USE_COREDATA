//
//  FacilityTableViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class FacilityTableViewController: UITableViewController {
    
    var arrayFacility = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...10 {
            arrayFacility.append("Phòng \(i)")
        }

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFacility.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrayFacility[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "move"){
            if let destination = segue.destination as? SecondViewController {
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: path!)
                destination.Facility = (cell?.textLabel?.text!)!
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRow(at: indexPath as IndexPath) {
            self.performSegue(withIdentifier: "move", sender: self)
        }
    }
}
