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
    
    
    // hiển thị nút sidemenu ở trang home, notifications, settings
//    func addSideMenu(){
//        let menuButton = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .plain, target:
//            self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
//        self.navigationItem.setLeftBarButton(menuButton, animated: true)// thiết lập nút bấm
//        
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())// thiết lập nhận diện cử chỉ
//    }
    
    // nút tắt quay về trang home trên navigationbar
//    func addHomeButton(){
//        let homeButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(popToHome))
//        self.navigationItem.setRightBarButton(homeButton, animated: true)
//        
//        //vuốt kéo hiện sidemenu
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//    }
    
//    func popToHome(){
//        self.navigationController?.popToRootViewController(animated: true)
//    }
}

extension UITextField{
    // textView trống đúng ko, =true là không trống
    func isEmpty() -> Bool{
        return (self.text?.characters.count)! == 0
    }
}


//******** ******** ******* Đa ngôn ngữ ******** ******** *******
extension UIView {
    func onUpdateLocale() {
//        print("------Vào onUpdateLocale------")
        for subView: UIView in self.subviews {
//            print("--Vào vòng lặp--")
//            print(Prefs.shared.currentLocale())
            subView.onUpdateLocale()
        }
    }
}
