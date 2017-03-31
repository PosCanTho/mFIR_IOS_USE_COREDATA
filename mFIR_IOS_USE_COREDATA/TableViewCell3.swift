//
//  TableViewCell3.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tran Bao Toan on 3/30/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class TableViewCell3: UITableViewCell {

    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbCOm: UILabel!
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
        if(!(issue.facilityComponentTypeName3?.isEmpty)!){
            lbCOm.text = issue.facilityComponentTypeName3
            lbStatus.text = issue.facilityComponentIssueStatus3
        }
    }

}
