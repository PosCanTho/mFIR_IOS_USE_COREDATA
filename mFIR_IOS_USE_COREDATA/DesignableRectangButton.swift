//
//  DesignableRectangButton.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableRectangButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius;
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
  

}
