//
//  Dialog.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tống Thành Vinh on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//
import UIKit
import Foundation

class FirDialog{
    
    static func show(viewController: UIViewController, title: String, mes: String, buttonName: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: mes, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonName, style: UIAlertActionStyle.default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showErrorDownload(viewController: UIViewController, urlError: URLError){
        
        DispatchQueue.main.async {
            if(urlError.code == URLError.timedOut){
                
                let mes = "Hết thời gian kết nối.\nMã lỗi: \(urlError.errorCode)"
                self.show( viewController: viewController, title: "Connection", mes: mes, buttonName: "Close")
            }
            if(urlError.code == URLError.notConnectedToInternet){
                
                let mes = "Không có kết nối internet. Vui lòng kiểm tra lại kết nối internet!\nMã lỗi: \(urlError.errorCode)"
                self.show( viewController: viewController, title: "Connection", mes: mes, buttonName: "Close")
            }
        }
    }
}
