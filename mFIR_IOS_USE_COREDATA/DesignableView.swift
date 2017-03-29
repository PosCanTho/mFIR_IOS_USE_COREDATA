//
//  DesignableView.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var myBackgroundColor: UIColor = UIColor.clear {
        didSet {
            self.layer.backgroundColor = myBackgroundColor.cgColor.copy(alpha: 0.7)
        }
    }
}
