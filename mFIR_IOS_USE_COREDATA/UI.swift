//
//  UI.swift
//  mFIR
//
//  Created by lehoangdung on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

extension UIViewController{
    func alert(title: String, message: String){
        let ok = UIAlertAction(title:"OK", style: .default, handler: nil)
        let view = UIAlertController(title: title, message: message, preferredStyle: .alert)
        view.addAction(ok)
        self.present(view, animated: true, completion: nil)
    }
    
    
    // thêm 1 nút, có nút Done ẩn bàn phím
    // app dụng từ iphone 5s về sau
    func addDoneButton(to control: UITextField){
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: control, action: #selector(UITextField.resignFirstResponder)
                )
        ]
        toolbar.sizeToFit()
        control.inputAccessoryView = toolbar
    }// goi addDoneButton(to: <tenTextView khi ánh xạ>)
    
}

extension UITextField{
    // textView trống đúng ko, =true là không trống
    func isEmpty() -> Bool{
        return (self.text?.characters.count)! == 0
    }
}

