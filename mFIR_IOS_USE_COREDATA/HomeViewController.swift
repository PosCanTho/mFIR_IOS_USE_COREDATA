//
//  HomeViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Baslor on 29/03/2017.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class FacilityCell: UITableViewCell{

    @IBOutlet weak var lbNameFacility: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableFacility: UITableView!
    var facilityArray: Array = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.visibleViewController?.title = "Home"
        
//        let statusBarBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 15))
//        statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.6855863333, green: 0.2018412054, blue: 0.1538721025, alpha: 1)
//        self.navigationController?.view.addSubview(statusBarBackgroundView)
//        self.navigationController?.view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
//        self.navigationController?.view.addConstraintsWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
        
        facilityArray = ["21 Nguyễn Văn Linh","59 Hà Bổng","103 Lê Sát","182 Nguyễn Văn Linh","209 Phan Thanh","271 Nguyễn Tri Phương","369 Điện Biên Phủ","Cao Đẳng Kinh Tế Kỹ Thuật Kiêng Giang","Dã Ngoại","Hoà Khánh Nam - Toà Nhà A","Hoà Khánh Nam - Toà Nhà B","Hoà Khánh Nam - Toà Nhà C","Hoà Khánh Nam - Toà Nhà D","K7/25 Quang Trung"]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Facility", for: indexPath) as! FacilityCell
        cell.lbNameFacility.text = facilityArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
       
}
