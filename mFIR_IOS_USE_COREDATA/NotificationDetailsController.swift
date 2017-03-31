//
//  NotificationDetailsController.swift
//  mFIR
//
//  Created by Pham Van Huong on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit
class NotificationDetailsViewCell: UITableViewCell{
    
    
    @IBOutlet weak var lblComponentTypeName: UILabel!
    
}

class NotificationDetailsController: UITableViewController {
       
   
     var roomName:[Issue] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    func getData(){
        let issue = FirServices (self)
        
        issue.getIssue(facilityIssueId: "0", fromDate: "", thruDate: "") { (dataIssue) in
            if dataIssue != nil {
                DispatchQueue.main.async {
                    print("-------- OK")
                    self.roomName = dataIssue!
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationDetailsCell", for: indexPath) as! NotificationDetailsViewCell
        
        let issue = roomName[indexPath.row]
        
  
        cell.lblComponentTypeName.text = issue.facilityComponentTypeName1
        cell.lblComponentTypeName.text = issue.facilityComponentTypeName2

        cell.lblComponentTypeName.text = issue.facilityComponentTypeName3

        cell.lblComponentTypeName.text = issue.facilityComponentTypeName4

        cell.lblComponentTypeName.text = issue.facilityComponentTypeName5
        //cell.lblComponentTypeName.text = issue.facilityComponentTypeName1


        
       
        
        return cell
        
    }
  
    
}
