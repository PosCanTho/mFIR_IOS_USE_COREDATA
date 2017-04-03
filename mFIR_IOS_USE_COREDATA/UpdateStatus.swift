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
        txtComment.resignFirstResponder() //an ban phim khi cham vào nút
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        btnStatusRoom.setTitle( status[row], for: .normal)

        if status[row] == "Không xử lý được" {
             btnStatusRoom.setTitle("Không xử lý được", for: .focused)
             btnStatusRoom.titleLabel?.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.8353756421)
             btnStatusRoom.setTitle("Không xử lý được", for: .focused)

        }
        if status[row] == "Đang xử lý" {
            btnStatusRoom.setTitle("Đang xử lý", for: .focused)
            btnStatusRoom.titleLabel?.textColor = #colorLiteral(red: 0.9445355535, green: 0.5337328911, blue: 0.03267831355, alpha: 1)
            btnStatusRoom.setTitle("Đang xử lý", for: .focused)

        }
        if status[row] == "Chưa xử lý" {
            btnStatusRoom.setTitle("Chưa xử lý", for: .focused)
            btnStatusRoom.titleLabel?.textColor = #colorLiteral(red: 0.4078193307, green: 0.4078193307, blue: 0.4078193307, alpha: 1)
            btnStatusRoom.setTitle("Chưa xử lý", for: .focused)

        }
//        if status[row] == "Đã xử lý" {
//            btnStatusRoom.setTitle("Đã xử lý", for: .focused)
//            btnStatusRoom.titleLabel?.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//            btnStatusRoom.setTitle("Đã xử lý", for: .focused)
//            
//        }
        
        
    }
     
    //an ban phim khi cham ngoai textfeild
    //    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //
    //        txtComment.resignFirstResponder()
    //        
    //    }
}


