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
    
    private static let window = UIApplication.shared.keyWindow?.rootViewController
    
    /// Hiển thị dialog
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - title: title
    ///   - mes: message
    ///   - buttonName: button name
    static func show(title: String, mes: String, buttonName: String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: mes, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonName, style: UIAlertActionStyle.default, handler: nil))
            
            if (self.window?.presentedViewController == nil){
                self.window?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /// Hiển thị lỗi nếu dataTask bị lỗi
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - urlError: URLError
    static func showErrorDownload(urlError: URLError){
        DispatchQueue.main.async {
            if(urlError.code == URLError.timedOut){
                
                let mes = "Hết thời gian kết nối.\nMã lỗi: \(urlError.errorCode)"
                FirDialog.show(title: "Lỗi kết nối", mes: mes, buttonName: "Đóng")
            }
            if(urlError.code == URLError.notConnectedToInternet){
                
                let mes = "Không có kết nối internet. Vui lòng kiểm tra lại kết nối internet!\nMã lỗi: \(urlError.errorCode)"
                FirDialog.show(title: "Lỗi kết nối", mes: mes, buttonName: "Đóng")
            }
        }
        
    }
    
    
    
}


class ProgressingDialog{
    private static let activityView = ActivityView()
    private static let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
    private static let blurEffectView = UIVisualEffectView(effect: blurEffect)
    private static let window = UIApplication.shared.keyWindow!
    
    static func show(){
        
        activityView.center = window.center
        
        blurEffectView.frame = CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        window.addSubview(blurEffectView)
        window.addSubview(activityView)
        
    }
    
    static func hide(){
        activityView.removeFromSuperview()
        self.blurEffectView.removeFromSuperview()
    }
    
    static func setMessage(mes:String){
        activityView.messageLabel.text = mes
    }
}

private class ActivityView: UIView {
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let boundingBoxView = UIView(frame: CGRect.zero)
    //    let ProgressView = UIProgressView(frame: CGRect.zero)
    let messageLabel = UILabel(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        
        boundingBoxView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        boundingBoxView.layer.cornerRadius = 12.0
        
        activityIndicatorView.startAnimating()
        
        messageLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.shadowColor = UIColor.black
        messageLabel.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        messageLabel.numberOfLines = 0
        
        addSubview(boundingBoxView)
        addSubview(activityIndicatorView)
        addSubview(messageLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boundingBoxView.frame.size.width = 160.0
        boundingBoxView.frame.size.height = 160.0
        boundingBoxView.frame.origin.x = ceil((bounds.width / 2.0) - (boundingBoxView.frame.width / 2.0))
        boundingBoxView.frame.origin.y = ceil((bounds.height / 2.0) - (boundingBoxView.frame.height / 2.0))
        
        activityIndicatorView.frame.origin.x = ceil((bounds.width / 2.0) - (activityIndicatorView.frame.width / 2.0))
        activityIndicatorView.frame.origin.y = ceil((bounds.height / 2.0) - (activityIndicatorView.frame.height / 2.0))
        
        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width: 160.0 - 20.0 * 2.0, height: CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size.width = messageLabelSize.width
        messageLabel.frame.size.height = messageLabelSize.height
        messageLabel.frame.origin.x = ceil((bounds.width / 2.0) - (messageLabel.frame.width / 2.0))
        messageLabel.frame.origin.y = ceil(activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + ((boundingBoxView.frame.height - activityIndicatorView.frame.height) / 4.0) - (messageLabel.frame.height / 2.0))
    }
}
