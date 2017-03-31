

import UIKit
class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblStatusRoom: UILabel!
    @IBOutlet weak var lblTimeReport: UILabel!
    @IBOutlet weak var LblTimeIssue: UILabel!
    @IBOutlet weak var btnStatusRoom: UIButton!
   }


class NotificationsViewController: UITableViewController {
    
    var facilityIssue: [Issue] = []
    var issueNew: [Issue] = []
    //var issueSortByFacId:[Issue] = [] //list issue sort theo facilityId
    let strNoStatus = "No status"
    let strChuaXuLy = "Chưa xử lý"
    let strDangXuLy = "Đang xử lý"
    let strDaXuLy = "Đã xử lý"
    let strKhongXuLyDuoc = "Không xử lý được"

    //123
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
        
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let issue = FirServices (self)
        //Lấy ngày giờ hệ thống
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let datef = format.string(from: date)
        
        let strFromDate = "1994-11-11 00:00:00"
        let strFacilityIssueId = "0"
        
        //print("ngay he thong ne: \(datef)")
        
        issue.getIssue(facilityIssueId: strFacilityIssueId, fromDate: strFromDate, thruDate: datef) { (dataIssue) in
            if dataIssue != nil {
                DispatchQueue.main.async {
                   
                    self.facilityIssue = dataIssue! //dữ liệu nguyễn mấu từ services
                    
                    ///Nhóm FacilityIssue theo facilityId (phòng)
                    
                   
                    for index in 0 ..< self.facilityIssue.count{
                      
                        let issue1: [Issue] = [self.facilityIssue[index]] //lấy đối tượng trong array
                        
                        //print(issue1)
                        let strFacilityId = self.facilityIssue[index].facilityId // lấy ra facilityId trong array
                        var isExist: Bool = false
                        
                        for index1 in 0 ..< self.issueNew.count {
                            let strFacilityId1 = self.facilityIssue[index1].facilityId
                            if strFacilityId?.caseInsensitiveCompare(strFacilityId1!) == .orderedSame {
                                isExist = true
                                                           }
                        
                        }
                        if !isExist {
                            self.issueNew.append(contentsOf: issue1)
                            //print("jsfsssrff \(self.issueNew)")
                        }
                        
                        
                    }
   
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
       // let dateIssue = issue.facilityIssueReportDatetime
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
        
        //let strFacilityIssueStatus = issue.facilityIssueStatus!
        let strFacilityIssueStatus = issue.facilityIssueStatus!

        if(strFacilityIssueStatus.isEmpty){
            
            cell.lblStatusRoom?.text = strNoStatus
            cell.lblStatusRoom.textColor = UIColor.darkGray
            cell.btnStatusRoom.setTitle("N", for: .normal)
            cell.btnStatusRoom.backgroundColor = UIColor.darkGray
            
        }
        else
        {
            cell.lblStatusRoom?.text = issue.facilityIssueStatus
            if(strFacilityIssueStatus == strChuaXuLy){
                cell.lblStatusRoom?.text = strFacilityIssueStatus
                cell.lblStatusRoom.textColor = UIColor.darkGray
                cell.btnStatusRoom.setTitle("C", for: .normal)
                cell.btnStatusRoom.backgroundColor = UIColor.darkGray
            }
            if(strFacilityIssueStatus == strDangXuLy){
                cell.lblStatusRoom?.text = strFacilityIssueStatus
                cell.lblStatusRoom.textColor = UIColor.orange
                cell.btnStatusRoom.setTitle("Đ", for: .normal)
                cell.btnStatusRoom.backgroundColor = UIColor.orange
            }
            if(strFacilityIssueStatus == strKhongXuLyDuoc){
                cell.lblStatusRoom?.text = strFacilityIssueStatus
                cell.lblStatusRoom.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                cell.btnStatusRoom.setTitle("K", for: .normal)
                cell.btnStatusRoom.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.9313730736)
            }
        }

        cell.lblTimeReport?.text = stringFromDate
        cell.LblTimeIssue?.text = stringFromTime
        
        return cell
        
    }

    

    

}
