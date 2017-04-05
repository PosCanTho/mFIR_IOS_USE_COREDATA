

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
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        DatePickerDialog().show("Thru date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: threeMonthAgo, maximumDate: currentDate, datePickerMode: .date) { (date) in
            if let dt = date {
                let formatFromdate = DateFormatter()
                formatFromdate.dateFormat = "dd/MM/yyy"
                let datef = formatFromdate.string(from: dt)
                self.lblThruDate.setTitle("\(datef)", for: .normal)
            }
        }
        //sort theo ngay
        

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
        getFacilityIssue()
        
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
    
    
    func getFacilityIssue(){
        let issue = FirServices (self)
        
        //let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm:ss"
        //let datef = format.string(from: date)
        
        //let strFromDate = "1994-11-11 00:00:00"
        let strFacilityIssueId = "0"
        
        
        
        //Lấy facility issue
        issue.getIssue(facilityIssueId: strFacilityIssueId, fromDate: "", thruDate: "") { (dataIssue) in
            if dataIssue != nil {
                DispatchQueue.main.async {
                   
                    self.facilityIssue = dataIssue! //dữ liệu nguyễn mẫu từ services
                    
                    ///Nhóm FacilityIssue theo facilityId (phòng)
                    for index in 0 ..< self.facilityIssue.count{
                        let issue1: [Issue] = [self.facilityIssue[index]] //lấy đối tượng trong array
                        let strFacilityId = self.facilityIssue[index].facilityId // lấy ra facilityId trong array
                        var isExist: Bool = false
                        for index1 in 0 ..< self.issueNew.count {
                            let strFacilityId1 = self.issueNew[index1].facilityId
                            if strFacilityId?.caseInsensitiveCompare(strFacilityId1!) == .orderedSame {
                                isExist = true
                            }
                        }
                        if !isExist {
                            self.issueNew.append(contentsOf: issue1)
                        }
                    }
                    //Dao nguoc mang issueNew
                    self.issueNew.reverse()
                    
                    self.tableView.reloadData()
                    print("Lấy được rồi nhé!-------- OK")
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFromString = dateFormatter.date(from: dateString)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        let stringFromDate = dateFormatter2.string(from: dateFromString!)
 
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        let stringFromTime = dateFormatter3.string(from: dateFromString!)
        print(stringFromDate)
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

        cell.lblTimeReport?.text = stringFromDate
        cell.LblTimeIssue?.text = stringFromTime
        
        return cell
        
    }
}
