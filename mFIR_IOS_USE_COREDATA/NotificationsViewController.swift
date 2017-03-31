

import UIKit
class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblRoomName: UILabel!
    @IBOutlet weak var lblStatusRoom: UILabel!
    @IBOutlet weak var lblTimeReport: UILabel!
    @IBOutlet weak var LblTimeIssue: UILabel!
}


class NotificationsViewController: UITableViewController {
    
    var roomName:[Issue] = []
    
//    var roomName = ["Phòng Học 102","Phòng Thực Hành 307","Phòng Thực Hành 308","Phòng Thực Hành 309","Phòng Thực Hành 201","Phòng Học 102","Phòng Thực Hành 102","Phòng Học 102","Phòng Thực Hành 109","Phòng Học 102","Phòng Thực Hành 102","Phòng Học 102"]
    //kka
// 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Notifications"

        //dang nhap
//        issue.login(username: "huynhducviet", password: "UUNpZzQxYXN5VWY4MHIrL0FNN3hIaEtOU0VvPQ==", imei: "") { (data) in
//            
//            guard data != nil else{
//                print("Fail")
//                return
//            }
//            print(data!.userName)
//            
//        }
        
        // Do any additional setup after loading the view.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        
        let issue = roomName[indexPath.row]
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
        cell.lblStatusRoom?.text = issue.facilityIssueStatus
        cell.lblTimeReport?.text = stringFromDate
        cell.LblTimeIssue?.text = stringFromTime
        
        return cell
        
    }

    

    

}
