//
//  ComTableViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tran Bao Toan on 3/30/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ComTableViewController: UITableViewController {
    
    var list: Array<Issue> = Array()
    var count:Int! = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    func getData(){
        let  issue = Issue.init(facilityIssueId: "1", facilityIssueCaseNumber: "1", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "2017", facilityIssueStatus: "", instructorIdNumber: "113", studentIdNumber: "", facilityId:
            "1", facilityName: "Phòng 1", facilityTypeName: "Phòng Lý Thuyết", facilityComponentTypeId1: "1", facilityComponentTypeName1: "Đèn/Điện", facilityComponentIssueReport1: "Ahihi", facilityComponentIssueStatus1: "Chưa xử lý", facilityComponentIssue_picture1: "dasd", facilityIssueResolverIdNumber1: "asdas", facilityIssueResolvedDatetime1: "sadas", facilityIssueResolversNote1: "", facilityComponentTypeId2: "asdas", facilityComponentTypeName2: "asdas", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "asdasdas", facilityComponentTypeName3: "a3", facilityComponentIssueReport3: "", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "ddd", facilityComponentTypeName4: "asdas", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "aa", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")
        
        let  issue2 = Issue.init(facilityIssueId: "1", facilityIssueCaseNumber: "1", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "2017", facilityIssueStatus: "", instructorIdNumber: "113", studentIdNumber: "", facilityId:
            "1", facilityName: "Phòng 1", facilityTypeName: "Phòng Lý Thuyết", facilityComponentTypeId1: "1", facilityComponentTypeName1: "Đèn/Điệnaaaa", facilityComponentIssueReport1: "Ahihi", facilityComponentIssueStatus1: "Chưa xử lý", facilityComponentIssue_picture1: "dasd", facilityIssueResolverIdNumber1: "asdas", facilityIssueResolvedDatetime1: "sadas", facilityIssueResolversNote1: "", facilityComponentTypeId2: "asdas", facilityComponentTypeName2: "asdas", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "", facilityComponentTypeName3: "", facilityComponentIssueReport3: "", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "", facilityComponentTypeName4: "", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")


        list.append(issue)

//        list.append(issue2)
        
        self.tableView.dataSource = self
        print(list.count)
        self.tableView.reloadData()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell0") as! TableViewCell1
        cell.issue = list[indexPath.row]
        return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell1") as! TableViewCell2
            cell.issue = list[indexPath.row]
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell2") as! TableViewCell3
            cell.issue = list[indexPath.row]
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell3") as! TableViewCell4
            cell.issue = list[indexPath.row]
            return cell
        }
        else   {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell4") as! TableViewCell5
            cell.issue = list[indexPath.row]
            return cell
        }
    }

}
