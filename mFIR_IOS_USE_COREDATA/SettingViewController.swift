//
//  SettingViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Baslor on 28/03/2017.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit
class SettingCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbSettingName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableSetting: UITableView!
    var settingArray: Array = [String]()
    var iconArray: Array = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Setting"
        
        settingArray = ["Synch data", "Notifications", "English", "Bell","Sign out"]
        iconArray = [UIImage(named: "setting")!, UIImage(named: "setting")!, UIImage(named: "setting")!, UIImage(named: "setting")!, UIImage(named: "setting")!]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Setting", for: indexPath) as! SettingCell
        
        cell.lbSettingName.text = settingArray[indexPath.row]
        cell.imgIcon.image = iconArray[indexPath.row]
        return cell
    }
}
