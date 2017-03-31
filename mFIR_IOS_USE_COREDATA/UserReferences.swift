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
    static let USER_FULL_NAME:String = "REFERENCE_USER_FULL_NAME"
    static let USER_ID:String = "REFERENCE_USER_ID"
    static let USER_STUDENT_ID_NUMBER:String = "REFERENCE_USER_STUDENT_ID_NUMBER"
    static let USER_INSTRUCTOR_ID_NUMBER:String = "REFERENCE_USER_INSTRUCTOR_ID_NUMBER"
    static let USER_ROLE_TYPE:String = "REFERENCE_USER_ROLE_TYPE"
    static let IS_REMEMBER:String = "IS_REMEMBER"
}
