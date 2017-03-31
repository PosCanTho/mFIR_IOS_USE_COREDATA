//
//  IssueTableViewController.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/23/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit
import MobileCoreServices

class IssueTableViewController: UITableViewController,IssueTableViewCellDelegate, UITextFieldDelegate {

    
    var arrayIssue = [String]()
    //    var reportIssues = TIBReportIssue.getAll()
    var reportIssues: [ReportIssue]?
    var hashTableChecked: [Int:ReportIssue] = [:]
    var des:String!
    let statusCom = "Chưa Xử Lý"
    var issue : Issue!
    var imagePicker : UIImagePickerController!
    
    @IBAction func btnSend(_ sender: Any) {
        var check:Bool! = true
        for i in hashTableChecked {
            if i.value.description.isEmpty {
                check = false
            }
        }
        // kiểm tra chọn thiết bị
        if hashTableChecked.count == 0 {
            self.showAlert(title: "Opps!", msg: "You have to choose at least ONE component for reporting!", ok: "OK")
        } else {
            if !check { // kiểm tra mô tả
                // hiển thị alert
                self.showAlert(title: "No Desciptions!", msg: "Please give us more details  about these issues!", ok: "OK")
            }  else {
                // kiểm tra internet
                if CheckInternet.isInternetAvailable() {
                    self.sendToServer()
                } else {
                    self.showAlert(title: "No Internet connection", msg: "We can not send your report at the moment because the Internet is not available. \nYour reports will continue to be sent  until the Internet is available.", ok: "OK")
                    self.sendToCoreData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData() // lấy dữ liệu thiết bị (name, id...)
        // set sự kiện ẩn bàn phím
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IssueTableViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    // ẩn bàn phím
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    // ẩn bàn phím, too
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    // chả biết, hàm có sẵn
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // lấy dữ liệu
    func getData() {
        var list : [Relationship]?
        list = DB.RelationshipDB.getByIdRelationship(facilityTypeId: "32")
        print(list?.count as Any)
        self.reportIssues = TIBReportIssue.getAll()
        self.tableView.reloadData()
    }
    func sendToCoreData(){
        DB.IssueDB.saveFacilityIssue(facilityIssueData: issue)
    }
    
    // gửi báo cáo
    func sendToServer(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFormat = formatter.string(from: date) // 83->86 : định dạng ngày

        var idStudent = ""
        var idInstructor = ""
        let role = UserDefaults.standard.string(forKey: UserReferences.USER_ROLE_TYPE)
        if role != "5" {
            idStudent = ""
            idInstructor = UserDefaults.standard.string(forKey: UserReferences.USER_INSTRUCTOR_ID_NUMBER)!
        } else {
            idInstructor = ""
            idStudent = UserDefaults.standard.string(forKey: UserReferences.USER_STUDENT_ID_NUMBER)!
        }
        // 88 -> 96: lấy id gv or sv
        
        // tạo issue
        issue = Issue.init(facilityIssueId: "", facilityIssueCaseNumber: "", sameFacilityIssueId: "", sameFacilityIssueCaseNumber: "", facilityIssueReportDatetime: "", facilityIssueStatus: "", instructorIdNumber: "", studentIdNumber: "", facilityId: "", facilityName: "", facilityTypeName: "",facilityComponentTypeId1: "" ,facilityComponentTypeName1: "" ,facilityComponentIssueReport1: "", facilityComponentIssueStatus1: "", facilityComponentIssue_picture1: ",", facilityIssueResolverIdNumber1: "", facilityIssueResolvedDatetime1: "", facilityIssueResolversNote1: "", facilityComponentTypeId2: "", facilityComponentTypeName2: "", facilityComponentIssueReport2: "", facilityComponentIssueStatus2: "", facilityComponentIssue_picture2: "", facilityIssueResolverIdNumber2: "", facilityIssueResolvedDatetime2: "", facilityIssueResolversNote2: "", facilityComponentTypeId3: "", facilityComponentTypeName3: "", facilityComponentIssueReport3: "", facilityComponentIssueStatus3: "", facilityComponentIssue_picture3: "", facilityIssueResolverIdNumber3: "", facilityIssueResolvedDatetime3: "", facilityIssueResolversNote3: "", facilityComponentTypeId4: "", facilityComponentTypeName4: "", facilityComponentIssueReport4: "", facilityComponentIssueStatus4: "", facilityComponentIssue_picture4: "", facilityIssueResolverIdNumber4: "", facilityIssueResolvedDatetime4: "", facilityIssueResolversNote4: "", facilityComponentTypeId5: "", facilityComponentTypeName5: "", facilityComponentIssueReport5: "", facilityComponentIssueStatus5: "", facilityComponentIssue_picture5: "", facilityIssueResolverIdNumber5: "", facilityIssueResolvedDatetime5: "", facilityIssueResolversNote5: "")
    
        issue.facilityIssueId = "0"
        issue.facilityIssueCaseNumber = String(hashTableChecked.count)
        issue.sameFacilityIssueId = ""
        issue.sameFacilityIssueCaseNumber = ""
        issue.facilityIssueReportDatetime = dateFormat
        issue.facilityIssueStatus = ""
        issue.instructorIdNumber = String(idInstructor)
        issue.studentIdNumber = String(idStudent)
        issue.facilityId = "32"
        issue.facilityName = "902"
        issue.facilityTypeName = "Phòng Học"
        for i in hashTableChecked {
            if i.key == 0 {
                issue.facilityComponentTypeId1 = i.value.componentID
                issue.facilityComponentTypeName1 = i.value.componentName
                issue.facilityComponentIssueReport1 = i.value.description
                issue.facilityComponentIssue_picture1 = ""
            }
            if i.key == 1 {
                issue.facilityComponentTypeId2 = i.value.componentID
                issue.facilityComponentTypeName2 = i.value.componentName
                issue.facilityComponentIssueReport2 = i.value.description
                 issue.facilityComponentIssue_picture2 = ""
            }
            if i.key == 2 {
                issue.facilityComponentTypeId3 = i.value.componentID
                issue.facilityComponentTypeName3 = i.value.componentName
                issue.facilityComponentIssueReport3 = i.value.description
                 issue.facilityComponentIssue_picture3 = ""
            }
            if i.key == 3 {
                issue.facilityComponentTypeId4 = i.value.componentID
                issue.facilityComponentTypeName4 = i.value.componentName
                issue.facilityComponentIssueReport4 = i.value.description
                 issue.facilityComponentIssue_picture4 = ""
            }
            if i.key == 4 {
                issue.facilityComponentTypeId5 = i.value.componentID
                issue.facilityComponentTypeName5 = i.value.componentName
                issue.facilityComponentIssueReport5 = i.value.description
                 issue.facilityComponentIssue_picture5 = ""
            }
        }
       // print(issue.instructorIdNumber,issue.studentIdNumber)
     self.callAsync(issue: issue)
    }
    
    func callAsync(issue: Issue){
        let fir = FirServices(self)
        fir.updateIssue(issue: issue) { (result) in
            if(result == true){
                print("ok")
            }
        }
    }
    
    // lấy dữ liệu trên text field
    func textFieldDidChange(cell: IssueTableViewCell){
        let indexPath = self.tableView.indexPath(for: cell)
        reportIssues?[indexPath!.row].description = cell.lbDescription.text!
        des = reportIssues?[indexPath!.row].description
        if (cell.checkbox.on) {
            print("check")
            let count = hashTableChecked.count
            if (count <= 5) {
                let report = ReportIssue.init(componentName: cell.lbComponent.text!, description: des, componentID: "1", checked: true,image:"")
                hashTableChecked[indexPath!.row] = report
            }
        } else {
            hashTableChecked.removeValue(forKey: indexPath!.row)
        }
    }
    // sự kiện check - uncheck ở checkbox
    func btnChecked(cell: IssueTableViewCell) {
        let indexPath = self.tableView.indexPath(for: cell)
        reportIssues?[indexPath!.row].checked = cell.checkbox.on
        if (cell.checkbox.on) {
            let count = hashTableChecked.count
            if (count <= 4) {
                let report = ReportIssue.init(componentName: cell.lbComponent.text!, description: "", componentID: "1", checked: true, image: "")
                hashTableChecked[indexPath!.row] = report
            } else {
                self.showAlert(title: "Too much components!", msg: "You just can choose FIVE components for reporting!", ok: "OK")
                cell.checkbox.setOn(false, animated: true)
                cell.lbDescription.isHidden = true
                cell.btnCamera.isHidden = true
            }
        } else {
            hashTableChecked.removeValue(forKey: indexPath!.row)
        }

    }
    
    func btnTakePhoto(cell: IssueTableViewCell) {
        _ = self.tableView.indexPath(for: cell)
        let alertController = YBAlertController(title: "Do you want get issue's photo from ?", message: "", style: .actionSheet)
        alertController.addButton(UIImage(named: "Cam"), title: "Camera") {
             self.camera()
        }
        
        alertController.addButton(UIImage(named: "PhotoL"), title: "Library") {
             self.photoLibrary()
        }
        
        alertController.addButton(UIImage(named: "Cancel"), title: "Cancel") {
            
        }
        alertController.touchingOutsideDismiss = true
        alertController.buttonIconColor = UIColor(red: 248/255.0, green: 47/255.0, blue: 38/255.0, alpha: 1.0)
        alertController.show()
    }
    
    func camera(){
        imagePicker = UIImagePickerController()
 //       imagePicker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            imagePicker.sourceType = .camera
        } else {
        self.showAlert(title: "Opps!", msg: "Your Camera is not avaiable now!", ok: "OK")
        }
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        self.present(imagePicker, animated: true, completion: nil)
    }
    func photoLibrary(){
        imagePicker = UIImagePickerController()
    //    imagePicker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            imagePicker.sourceType = .photoLibrary
        } else {
            self.showAlert(title: "Opps!", msg: "Your Library is not avaiable now!", ok: "OK")
        }
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        self.present(imagePicker, animated: true, completion: nil)
    }
    // hiện alert thông báo
    func showAlert(title:String, msg:String, ok:String){
        let title = title
        let message = msg
        let ok = ok
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okButton = UIAlertAction(title: ok, style: UIAlertActionStyle.cancel, handler : nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension IssueTableViewController {

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
        cell.lbDescription.delegate = self
        return cell
    }
}
