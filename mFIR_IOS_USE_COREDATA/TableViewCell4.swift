//
//  TableViewCell4.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tran Bao Toan on 3/30/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class TableViewCell4: UITableViewCell {

    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbCom: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var issue: Issue! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        if(!(issue.facilityComponentTypeName4?.isEmpty)!){
            lbCom.text = issue.facilityComponentTypeName4
            lbStatus.text = issue.facilityComponentIssueStatus4
        }
        
    }
    
}
