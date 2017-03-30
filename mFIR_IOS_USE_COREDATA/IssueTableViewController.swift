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
        self.sendToServer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableViewIssue.dataSource = self
//        let download = FirServices(self)
//        download.getFacility(facilityId: "0") { (listfacility) in
//            if listfacility != nil {
//                print("á")
//                for i in listfacility! {
//                    print(i.facilityName)
//                }
//            }
//        }
        self.getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        self.reportIssues = TIBReportIssue.getAll()
        self.tableView.reloadData()
    }
    
    func sendToServer(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFormat = formatter.string(from: date)
        print(dateFormat)
//        let issue = Issue.init(facilityIssueId: <#T##String#>, facilityIssueCaseNumber: <#T##String#>, sameFacilityIssueId: <#T##String#>, sameFacilityIssueCaseNumber: <#T##String#>, facilityIssueReportDatetime: dateFormat, facilityIssueStatus: <#T##String#>, instructorIdNumber: <#T##String#>, studentIdNumber: <#T##String#>, facilityId: <#T##String#>, facilityName: <#T##String#>, facilityTypeName: <#T##String#>, facilityComponentTypeId1: <#T##String#>, facilityComponentTypeName1: <#T##String#>, facilityComponentIssueReport1: <#T##String#>, facilityComponentIssueStatus1: <#T##String#>, facilityComponentIssue_picture1: <#T##String#>, facilityIssueResolverIdNumber1: <#T##String#>, facilityIssueResolvedDatetime1: <#T##String#>, facilityIssueResolversNote1: <#T##String#>, facilityComponentTypeId2: <#T##String#>, facilityComponentTypeName2: <#T##String#>, facilityComponentIssueReport2: <#T##String#>, facilityComponentIssueStatus2: <#T##String#>, facilityComponentIssue_picture2: <#T##String#>, facilityIssueResolverIdNumber2: <#T##String#>, facilityIssueResolvedDatetime2: <#T##String#>, facilityIssueResolversNote2: <#T##String#>, facilityComponentTypeId3: <#T##String#>, facilityComponentTypeName3: <#T##String#>, facilityComponentIssueReport3: <#T##String#>, facilityComponentIssueStatus3: <#T##String#>, facilityComponentIssue_picture3: <#T##String#>, facilityIssueResolverIdNumber3: <#T##String#>, facilityIssueResolvedDatetime3: <#T##String#>, facilityIssueResolversNote3: <#T##String#>, facilityComponentTypeId4: <#T##String#>, facilityComponentTypeName4: <#T##String#>, facilityComponentIssueReport4: <#T##String#>, facilityComponentIssueStatus4: <#T##String#>, facilityComponentIssue_picture4: <#T##String#>, facilityIssueResolverIdNumber4: <#T##String#>, facilityIssueResolvedDatetime4: <#T##String#>, facilityIssueResolversNote4: <#T##String#>, facilityComponentTypeId5: <#T##String#>, facilityComponentTypeName5: <#T##String#>, facilityComponentIssueReport5: <#T##String#>, facilityComponentIssueStatus5: <#T##String#>, facilityComponentIssue_picture5: <#T##String#>, facilityIssueResolverIdNumber5: <#T##String#>, facilityIssueResolvedDatetime5: <#T##String#>, facilityIssueResolversNote5: <#T##String#>)
        
//        print(issue)
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
