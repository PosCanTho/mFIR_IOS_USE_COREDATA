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
