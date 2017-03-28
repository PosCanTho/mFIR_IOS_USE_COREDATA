//
//  DesignableTextField.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var lefPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    func updateView(){
        
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: lefPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            
            imageView.tintColor = tintColor
            
            let width = lefPadding+20
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
            leftView = view
        }else{
            leftViewMode = .never
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSForegroundColorAttributeName: tintColor])
        
    }

}
