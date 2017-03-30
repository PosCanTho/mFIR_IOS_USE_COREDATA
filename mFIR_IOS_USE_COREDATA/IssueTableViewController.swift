//
//  IssueTableViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController,IssueTableViewCellDelegate {

    
    var arrayIssue = [String]()
    //    var reportIssues = TIBReportIssue.getAll()
    var reportIssues: [ReportIssue]?
    var hashTableChecked: [Int:ReportIssue] = [:]
    var des:String!
    
    @IBAction func btnSend(_ sender: Any) {
        for i in hashTableChecked {
            print(i.value.description)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableViewIssue.dataSource = self
  
        self.getData()
    }
    func getData() {
        self.reportIssues = TIBReportIssue.getAll()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(cell: IssueTableViewCell){
        let indexPath = self.tableView.indexPath(for: cell)
        reportIssues?[indexPath!.row].description = cell.lbDescription.text!
        des = reportIssues?[indexPath!.row].description
        print(des)
        if (cell.checkbox.on) {
            let count = hashTableChecked.count
            if (count <= 4) {
                let report = ReportIssue.init(componentName: cell.lbComponent.text!, description: des, componentID: "1", checked: true)
                hashTableChecked[indexPath!.row] = report
                
            } else {
                print("Check clg check hoai vay me")
                cell.checkbox.setOn(false, animated: false)
            }
        } else {
            hashTableChecked.removeValue(forKey: indexPath!.row)
            
            print("uncheck---\(hashTableChecked.count)")
        }
    }

    func btnChecked(cell: IssueTableViewCell) {
        //Get the indexpath of cell where checkbox was checked
        let indexPath = self.tableView.indexPath(for: cell)
        // cell.lbDescription.text
        reportIssues?[indexPath!.row].checked = cell.checkbox.on

    }

}

extension IssueTableViewController {
    /*
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
        }
 */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportIssues!.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueCell") as! IssueTableViewCell
        cell.reportIssue = reportIssues?[indexPath.row]
        cell.delegate = self
        return cell
    }
}
