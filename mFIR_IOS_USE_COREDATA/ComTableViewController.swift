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
    
    var count:CGFloat! = 56.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()

    }
    
    func getData(){
        let  issue = Issue.init(facilityIssueId: "1", facilityIssueCaseNumber: "1", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "2017", facilityIssueStatus: "", instructorIdNumber: "113", studentIdNumber: "", facilityId:
            "1", facilityName: "Phòng 1", facilityTypeName: "Phòng Lý Thuyết", facilityComponentTypeId1: "1", facilityComponentTypeName1: "Đèn/Điện", facilityComponentIssueReport1: "Ahihi", facilityComponentIssueStatus1: "Chưa xử lý", facilityComponentIssue_picture1: "", facilityIssueResolverIdNumber1: "", facilityIssueResolvedDatetime1: "", facilityIssueResolversNote1: "", facilityComponentTypeId2: "", facilityComponentTypeName2: "", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "3", facilityComponentTypeName3: "", facilityComponentIssueReport3: ":)", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "", facilityComponentTypeName4: "", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")
//        
        let  issue2 = Issue.init(facilityIssueId: "1", facilityIssueCaseNumber: "1", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "2017", facilityIssueStatus: "", instructorIdNumber: "113", studentIdNumber: "", facilityId:
            "1", facilityName: "Phòng 1", facilityTypeName: "Phòng Lý Thuyết", facilityComponentTypeId1: "1", facilityComponentTypeName1: "Đèn/Điệnaaaa", facilityComponentIssueReport1: "Ahihi", facilityComponentIssueStatus1: "Chưa xử lý", facilityComponentIssue_picture1: "", facilityIssueResolverIdNumber1: "", facilityIssueResolvedDatetime1: "", facilityIssueResolversNote1: "", facilityComponentTypeId2: "", facilityComponentTypeName2: "", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "", facilityComponentTypeName3: "", facilityComponentIssueReport3: "", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "", facilityComponentTypeName4: "", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")

        list.append(issue)
        list.append(issue2)

      
        self.tableView.dataSource = self
        self.tableView.reloadData()

//        for i in list {
//            if (!(i.facilityComponentTypeId1?.isEmpty)! &&  (i.facilityComponentTypeId2?.isEmpty)! &&  (i.facilityComponentTypeId3?.isEmpty)! &&  (i.facilityComponentTypeId4?.isEmpty)! &&  (i.facilityComponentTypeId5?.isEmpty)!) {
//                print("if 1")
//                count = 56
//            } else if (!(i.facilityComponentTypeId1?.isEmpty)! && !(i.facilityComponentTypeId2?.isEmpty)! &&  (i.facilityComponentTypeId3?.isEmpty)! &&  (i.facilityComponentTypeId4?.isEmpty)! &&  (i.facilityComponentTypeId5?.isEmpty)!) {
//                print("if 2")
//                count = 56 * 2
//            } else if (!(i.facilityComponentTypeId1?.isEmpty)! && !(i.facilityComponentTypeId2?.isEmpty)! && !(i.facilityComponentTypeId3?.isEmpty)! &&  (i.facilityComponentTypeId4?.isEmpty)! &&  (i.facilityComponentTypeId5?.isEmpty)!) {
//                print("if 3")
//                count = 56 * 3
//            } else if (!(i.facilityComponentTypeId1?.isEmpty)! && !(i.facilityComponentTypeId2?.isEmpty)! && !(i.facilityComponentTypeId3?.isEmpty)! && !(i.facilityComponentTypeId4?.isEmpty)! &&  (i.facilityComponentTypeId5?.isEmpty)!) {
//                print("if 4")
//                count = 56 * 4
//            } else {
//                print("if 5")
//                count =  56 * 5
//            }
//        }
//        tableView.beginUpdates()
//        tableView.endUpdates()
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            print("---1")
            return 56
        } else if (indexPath.row == 1){
            print("---2")
        return 56 * 2
        } else if (indexPath.row == 2){
            print("---3")
            return 56 * 3
        } else if (indexPath.row == 3){
            print("---4")
            return 56 * 4
        } else {
            print("---5")
            return 56 * 5
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell") as! ComReportedTableViewCell
        cell.issue = list[indexPath.row]
        return cell
    }
}
