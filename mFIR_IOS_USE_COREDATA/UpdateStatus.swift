//
//  UpdateStatus.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Huong on 3/31/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit
class UpdateStatus: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var btnStatusRoom: UIButton!
    @IBOutlet weak var btnSortDownStatus: UIButton!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var pickerStatus: UIPickerView!
    @IBAction func btnUpdateStatus(_ sender: UIButton) {
        txtComment.resignFirstResponder()
    }

    
    
    
    var status = ["Đã xử lý", "Đang xử lý", "Chưa xử lý", "Không xử lý được"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerStatus.dataSource = self
        pickerStatus.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return status[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //        let titleData = status[row]
    //        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 9.0)!,NSForegroundColorAttributeName:UIColor.orange])
    //        return myTitle
    //    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
     
    //an ban phim khi cham ngoai textfeild
    //    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //
    //        txtComment.resignFirstResponder()
    //        
    //    }
}


