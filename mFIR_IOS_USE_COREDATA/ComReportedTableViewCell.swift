//
//  ComReportedTableViewCell.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tran Bao Toan on 3/29/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ComReportedTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFirstchar: UIButton!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbComName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbComName_2: UILabel!
    @IBOutlet weak var lbStatus_2: UILabel!
    @IBOutlet weak var btnFirstchar_2: UIButton!
    @IBOutlet weak var lbTime_2: UILabel!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var lbComName_3: UILabel!
    @IBOutlet weak var lbStatus_3: UILabel!
    @IBOutlet weak var btnFirstchar_3: UIButton!
    @IBOutlet weak var lbTime_3: UILabel!
    
    
    @IBOutlet weak var lbComName_4: UILabel!
    @IBOutlet weak var lbStatus_4: UILabel!
    @IBOutlet weak var lbFirstchar_4: UIButton!
    @IBOutlet weak var lbTime_4: UILabel!
    
    @IBOutlet weak var lbComName_5: UILabel!
    @IBOutlet weak var lbStatus_5: UILabel!
    @IBOutlet weak var btnFirstchar_5: UIButton!
    @IBOutlet weak var lbTime_5: UILabel!
    
    
    var issue: Issue! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI(){
        let firstChar = issue.facilityComponentIssueStatus1
        lbComName.text = issue.facilityComponentTypeName1
        lbStatus.text = issue.facilityComponentIssueStatus1
        btnFirstchar.setTitle(firstChar?[0],for: .normal)
        lbTime.text = issue.facilityIssueReportDatetime
        
        let firstChar2 = issue.facilityComponentIssueStatus2
        if(!(firstChar2?.isEmpty)!){
            lbComName_2.text = issue.facilityComponentTypeName2
            lbStatus_2.text = issue.facilityComponentIssueStatus2
            btnFirstchar_2.setTitle(firstChar2?[0],for: .normal)
            lbTime_2.text = issue.facilityIssueReportDatetime
        } else {
//            print("hihih")
//            UIView.animate(withDuration: 0, animations: {
//                self.view2.frame.origin.x -= self.view2.frame.width
//            print("00")
//            })
//            view2.frame = CGRect(0 , 0, self.view2.frame.width*0, self.view2.frame.height * 0)
        }

        let firstChar3 = issue.facilityComponentIssueStatus3
        if(!(firstChar3?.isEmpty)!){
            lbComName_3.text = issue.facilityComponentTypeName3
            lbStatus_3.text = issue.facilityComponentIssueStatus3
            btnFirstchar_3.setTitle(firstChar3?[0],for: .normal)
            lbTime_3.text = issue.facilityIssueReportDatetime
        }
        
        let firstChar4 = issue.facilityComponentIssueStatus4
        if(!(firstChar4?.isEmpty)!){
            lbComName_4.text = issue.facilityComponentTypeName4
            lbStatus_4.text = issue.facilityComponentIssueStatus4
            lbFirstchar_4.setTitle(firstChar4?[0],for: .normal)
            lbTime_4.text = issue.facilityIssueReportDatetime
        }
        
        let firstChar5 = issue.facilityComponentIssueStatus5
        if(!(firstChar5?.isEmpty)!){
            lbComName_5.text = issue.facilityComponentTypeName5
            lbStatus_5.text = issue.facilityComponentIssueStatus5
            btnFirstchar_5.setTitle(firstChar5?[0],for: .normal)
            lbTime_5.text = issue.facilityIssueReportDatetime
        }

        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}
