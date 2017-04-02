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
    func btnTakePhoto(cell: IssueTableViewCell)
    func imageTapped(cell: IssueTableViewCell)
}

class IssueTableViewCell: UITableViewCell, BEMCheckBoxDelegate {
    
    @IBOutlet weak var lbComponent: UILabel!
    @IBOutlet weak var lbDescription: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var checkbox: BEMCheckBox!
    @IBOutlet weak var btnFirstchar: UIButton!
    @IBOutlet weak var imgIssue: UIImageView!
    
    var delegate: IssueTableViewCellDelegate?
    var issueTableViewController : IssueTableViewController?
 
    
    @IBAction func btnTakePhoto(_ sender: UIButton) {
        if let _ = delegate {
            delegate?.btnTakePhoto(cell: self)
        }
    }

    @IBAction func btnChecked(_ sender: Any) {
        if let _ = delegate {
            delegate?.btnChecked(cell: self)
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if let _ = delegate {
            delegate?.textFieldDidChange(cell: self)
        }
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if let _ = delegate {
            delegate?.imageTapped(cell: self)
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
        if(checkbox.on){
            lbDescription.isHidden = false
            btnCamera.isHidden = false
            lbDescription.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            imgIssue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
            imgIssue.isUserInteractionEnabled = true
            imgIssue.image = reportIssue.image
        } else {
            lbDescription.text = ""
            lbDescription.isHidden = true
            btnCamera.isHidden = true
        }
    }

    func didTap(_ checkBox: BEMCheckBox) {
        if(checkBox.on){
            lbDescription.isHidden = false
            btnCamera.isHidden = false
            lbDescription.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            imgIssue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
            imgIssue.isUserInteractionEnabled = true
        } else {
            lbDescription.text = ""
            lbDescription.isHidden = true
            btnCamera.isHidden = true
        }
    }

}


