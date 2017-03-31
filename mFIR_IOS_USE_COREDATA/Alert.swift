//
//  Alert.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tran Bao Toan on 3/31/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation


func showAlert(title:String, message: String, ok: String){
    let title = title
    let message = message
    let ok = ok
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okButton = UIAlertAction(title: ok, style: UIAlertActionStyle.cancel, handler : nil)
    alert.addAction(okButton)
    present(alert, animated: true, completion: nil)
}
