//
//  IssueTableViewCell.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit


protocol IssueTableViewCellDelegate {
    func btnChecked(cell: IssueTableViewCell)
    func textFieldDidChange(cell: IssueTableViewCell)
}

class IssueTableViewCell: UITableViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var lbComponent: UILabel!
    @IBOutlet weak var lbDescription: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var checkbox: BEMCheckBox!
    @IBOutlet weak var btnFirstchar: UIButton!
    
    var delegate: IssueTableViewCellDelegate?
    
    @IBAction func btnChecked(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnChecked(cell: self)
        }
    }
    
    var reportIssue: ReportIssue! {
        didSet {
            self.updateUI()
        }
    }
    
    override func prepareForReuse() {
        self.lbDescription.text = ""
    }
    
    func updateUI(){
        let firstChar = reportIssue.componentName
        lbComponent.text = reportIssue.componentName
        checkbox.setOn(reportIssue.checked, animated: false)
        lbDescription.text = reportIssue.description
        checkbox.delegate = self
        btnFirstchar.setTitle(firstChar[0],for: .normal)
    }
    
    
    func didTap(_ checkBox: BEMCheckBox) {
        if(checkBox.on){
            lbDescription.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        } else {
            lbDescription.text = ""
        }
    }
    func textFieldDidChange(_ textField: UITextField) {
        if let _ = delegate {
            delegate?.textFieldDidChange(cell: self)
        }
        //        print(lbDescription.text!)
    }
    
}


