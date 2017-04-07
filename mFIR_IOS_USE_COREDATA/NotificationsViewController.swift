

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblStatusRoom: UILabel!
    @IBOutlet weak var lblTimeReport: UILabel!
    @IBOutlet weak var LblTimeIssue: UILabel!
    @IBOutlet weak var btnStatusRoom: UIButton!
   }


class NotificationsViewController: UITableViewController {
    
    //Fillter notitification by date
    //@IBOutlet
    @IBOutlet weak var lblFromdate: UIButton!
    @IBOutlet weak var lblThruDate: UIButton!
    @IBOutlet weak var lblStatus: UIButton!
    
    
    
    @IBAction func btnFromDate(_ sender: UIButton) {
        sortFromDate()
    }
    @IBAction func btnSortFromDate(_ sender: UIButton) {
        sortFromDate()
    }
    

    func sortFromDate(){
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        
        DatePickerDialog().show("From date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: threeMonthAgo, maximumDate: currentDate, datePickerMode: .date) { (date) in
            if let dt = date {
                let formatFromdate = DateFormatter()
                formatFromdate.dateFormat = "dd/MM/yyy"
                let datef = formatFromdate.string(from: dt)
                self.lblFromdate.setTitle("\(datef)", for: .normal)
            }
        }

    }
    
    @IBAction func btnThruDate(_ sender: UIButton) {
        sortThruDate()
    }
    @IBAction func btnSortThruDate(_ sender: UIButton) {
        sortThruDate()
    }
    func sortThruDate(){
        var strThruDate = ""
        var strFromDate = ""
        let formatDate = DateFormatter()
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        DatePickerDialog().show("Thru date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: threeMonthAgo, maximumDate: currentDate, datePickerMode: .date) { (date) in
            if let dt = date {
                formatDate.dateFormat = "dd/MM/yyyy"
                let datef = formatDate.string(from: dt)
                self.lblThruDate.setTitle("\(datef)", for: .normal)
                
                formatDate.dateFormat = "yyyy-MM-dd 23:59:59" //Lấy cuối ngày
                strThruDate = formatDate.string(from: dt)
                print("Thrudate------ ",strThruDate)

                
                //sort theo ngay
                
                //let dateFormatter = DateFormatter()
                formatDate.dateFormat = "dd/MM/yyyy"
                let fromdate = self.lblFromdate.currentTitle!
                let date = formatDate.date(from: fromdate)
                
                formatDate.dateFormat = "yyyy-MM-dd 00:00:00" //Lấy đầu ngày
                strFromDate = formatDate.string(from: date!)
                print("Fromdate------ ",strFromDate)
                
                
                self.getFacilityIssue(strFacilityIssueId: "0", strFromDate: strFromDate, strThruDate: strThruDate)
                self.tableView.reloadData()


            }
        }
    }
    
    @IBAction func btnStatus(_ sender: UIButton) {
        sortStatus()
    }
    @IBAction func btnSortStatus(_ sender: UIButton) {
        sortStatus()
    }
    func sortStatus(){
        let alert = UIAlertController(title: "Facility Issue Status", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let oneAction = UIAlertAction(title: strChuaXuLy1, style: UIAlertActionStyle.default, handler: nil)
        let twoAction = UIAlertAction(title: strDangXuLy1, style: UIAlertActionStyle.default, handler: nil)
        let threeAction = UIAlertAction(title: strDaXuLy1, style: UIAlertActionStyle.default, handler: nil)
        let fourAction = UIAlertAction(title: strKhongXuLyDuoc1, style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(oneAction)
        alert.addAction(twoAction)
        alert.addAction(threeAction)
        alert.addAction(fourAction)
        
        present(alert, animated: true, completion: nil)
    }
    
  
    
    var facilityIssueStatus: [IssueStatus] = []
    var facilityIssue: [Issue] = []
    var issueNew: [Issue] = []
    var issueSortDate: [Issue] = [] // DS issue hiện thị theo thơi gian mới nhất
    let dateFormatter = DateFormatter()
   
    
    var strChuaXuLy  = ""
    var strDangXuLy = ""
    var strDaXuLy = ""
    var strKhongXuLyDuoc = ""
    var strChuaXuLy1  = ""
    var strDangXuLy1 = ""
    var strDaXuLy1 = ""
    var strKhongXuLyDuoc1 = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Notifications"

        //dang nhap
        let issue = FirServices (self)
        issue.login(username: "huynhducviet", password: "UUNpZzQxYXN5VWY4MHIrL0FNN3hIaEtOU0VvPQ==", imei: "") { (data) in
            
            guard data != nil else{
                print("Fail")
                return
            }
            print(data!.userName)
        }
        getFacilityIssueStatus()
        getFacilityIssue(strFacilityIssueId: "0", strFromDate: "",strThruDate: "")
        //self.tableView.reloadData()
        
    }
    
    func getFacilityIssueStatus(){
        let facilityIssueStatus = FirServices(self)

        //Lấy facility issue status
        facilityIssueStatus.getIssueStatus { (issueStatusData) in
            if issueStatusData != nil {
                self.facilityIssueStatus = issueStatusData!
                
                self.strChuaXuLy = (self.facilityIssueStatus[0].typeNameName).lowercased()
                self.strDangXuLy = (self.facilityIssueStatus[1].typeNameName).lowercased()
                self.strKhongXuLyDuoc = (self.facilityIssueStatus[2].typeNameName).lowercased()
                self.strDaXuLy = (self.facilityIssueStatus[3].typeNameName).lowercased()
                
                self.strChuaXuLy1 = self.facilityIssueStatus[0].typeNameName
                self.strDangXuLy1 = self.facilityIssueStatus[1].typeNameName
                self.strKhongXuLyDuoc1 = self.facilityIssueStatus[2].typeNameName
                self.strDaXuLy1 = self.facilityIssueStatus[3].typeNameName
                
                
            }
        }
    }
    
    
    func getFacilityIssue(strFacilityIssueId: String, strFromDate: String, strThruDate: String){
        
        let issue = FirServices (self)
        
        //Lấy facility issue
        issue.getIssue(facilityIssueId: strFacilityIssueId, fromDate: strFromDate, thruDate: strThruDate) { (dataIssue) in
            if dataIssue != nil {
                DispatchQueue.main.async {
                   
                    self.facilityIssue = dataIssue! //dữ liệu nguyễn mẫu từ services
                    print("Size issue ban dau: ===== ", self.facilityIssue.count)
                    
                    ///Nhóm FacilityIssue theo facilityId (phòng)
                    for index in 0 ..< self.facilityIssue.count{
                        let issueBD: [Issue] = [self.facilityIssue[index]] //lấy đối tượng trong array
                        let strFacilityId = self.facilityIssue[index].facilityId // lấy ra facilityId trong array
                        var isExist: Bool = false
                        for index1 in 0 ..< self.issueNew.count {
                            let strFacilityId1 = self.issueNew[index1].facilityId
                            if strFacilityId == strFacilityId1 {
                                isExist = true
                            }
                        }
                        if !isExist {
                            self.issueNew.append(contentsOf: issueBD)
                        }
                    }
                    //Sap xep mang issue giam dan theo thoi gian
                    for i in 0 ..< self.issueNew.count-1 {
                        var issue1: [Issue] = [self.issueNew[i]]
                        self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let strTimeReport1 = self.dateFormatter.date(from: self.issueNew[i].facilityIssueReportDatetime!)

                        
                        for j in i+1 ..< self.issueNew.count {
                            let issue2: [Issue] = [self.issueNew[j]]
                            let strTimeReport2 = self.dateFormatter.date(from: self.issueNew[j].facilityIssueReportDatetime!)
                            
                            if strTimeReport1! < strTimeReport2! {
                                self.issueSortDate.append(contentsOf: issue2)
                                issue1 = [self.issueNew[j]]
                            }
                            
                        }
                    }
                    
                    
                    //Dao nguoc mang issueNew
                    //self.issueNew.reverse()
                    print("Size issueNew:======= ", self.issueNew.count)
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
        return issueNew.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        
        let issue = issueNew[indexPath.row]
        let dateString = issue.facilityIssueReportDatetime!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter.date(from: dateString)
       
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let stringDateReport = dateFormatter.string(from: dateFromString!)
 
        dateFormatter.dateFormat = "HH:mm"
        let stringTimeReport = dateFormatter.string(from: dateFromString!)
        cell.lblRoomName?.text = issue.facilityTypeName!+" "+issue.facilityName!
        
        //kiem tra facilityIssueStatus
        let strFacilityIssueStatus = (issue.facilityIssueStatus!).lowercased()
        // Rỗng
        if(strFacilityIssueStatus == ""){
            
            cell.lblStatusRoom?.text = "Chưa Xử Lý"
            cell.lblStatusRoom.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            cell.btnStatusRoom.setTitle("C", for: .normal)
            cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            
        }
        else
        {
            cell.lblStatusRoom?.text = issue.facilityIssueStatus
            //Chưa xử lý
            if(strFacilityIssueStatus == strChuaXuLy){
                cell.lblStatusRoom?.text = strChuaXuLy1
                cell.lblStatusRoom.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.btnStatusRoom.setTitle("C", for: .normal)
                cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
            //Đang xử lý
            if(strFacilityIssueStatus == strDangXuLy){
                cell.lblStatusRoom?.text = strDangXuLy1
                cell.lblStatusRoom.textColor = #colorLiteral(red: 0.983184278, green: 0.6165204644, blue: 0.01970458217, alpha: 1)
                cell.btnStatusRoom.setTitle("Đ", for: .normal)
                cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.983184278, green: 0.6165204644, blue: 0.01970458217, alpha: 1)
            }
            //Không xử lý được
            if(strFacilityIssueStatus == strKhongXuLyDuoc){
                cell.lblStatusRoom?.text = strKhongXuLyDuoc1
                cell.lblStatusRoom.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                cell.btnStatusRoom.setTitle("K", for: .normal)
                cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.9313730736)
            }
            //Đã xử lý
            if(strFacilityIssueStatus == strDaXuLy){
                cell.lblStatusRoom?.text = strDaXuLy1
                cell.lblStatusRoom.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                cell.btnStatusRoom.setTitle("Đ", for: .normal)
                cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
        }

        cell.lblTimeReport?.text = stringDateReport
        cell.LblTimeIssue?.text = stringTimeReport
        
        return cell
        
    }
}
