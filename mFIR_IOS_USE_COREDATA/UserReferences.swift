//
//  User.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/26/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation


// use -> let user =  UserDefaults.standard
// set -> user.setValue("String value save", UserReferences.KEY)
// get -> user.string(UserReferences.KEY)

struct UserReferences {
    static let USERNAME:String = "REFERENCE_USERNAME"
    static let PASSWORD:String = "REFERENCE_PASSWORD"
    static let FULL_NAME:String = "REFERENCE_USER_FULL_NAME"
}
