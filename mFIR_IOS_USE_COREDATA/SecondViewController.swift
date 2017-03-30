//
//  SecondViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var arrayComponents = [String]()
    
    @IBOutlet weak var lbFacility: UILabel!
    
    @IBOutlet weak var tableViewComponentsReported: UITableView!
    var Facility = ""
    
    var list: Array<Issue> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        lbFacility.text = Facility
        
        self.getData()

        
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        let  issue = Issue.init(facilityIssueId: "1", facilityIssueCaseNumber: "1", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "2017", facilityIssueStatus: "", instructorIdNumber: "113", studentIdNumber: "", facilityId:
            "1", facilityName: "Phòng 1", facilityTypeName: "Phòng Lý Thuyết", facilityComponentTypeId1: "1", facilityComponentTypeName1: "Đèn/Điện", facilityComponentIssueReport1: "Ahihi", facilityComponentIssueStatus1: "Chưa xử lý", facilityComponentIssue_picture1: "", facilityIssueResolverIdNumber1: "", facilityIssueResolvedDatetime1: "", facilityIssueResolversNote1: "", facilityComponentTypeId2: "", facilityComponentTypeName2: "", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "", facilityComponentTypeName3: "", facilityComponentIssueReport3: "", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "", facilityComponentTypeName4: "", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")
        list.append(issue)
        
        tableViewComponentsReported.dataSource = self
        tableViewComponentsReported.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SecondViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell") as! ComReportedTableViewCell
        cell.issue = list[indexPath.row]
        return cell
    }
    
}
