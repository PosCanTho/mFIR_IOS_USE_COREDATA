//
//  Relationship.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Relationship{
    
    var facilityTypeId:String
    var facilityTypeName:String
    var facilityComponentTypeId:String
    var facilityComponentTypeName:String
    var fromDate:String
    var thruDate:String
    var note:String
    
    init(
        facilityTypeId:String,
        facilityTypeName:String,
        facilityComponentTypeId:String,
        facilityComponentTypeName:String,
        fromDate:String,
        thruDate:String,
        note:String
        ){
        self.facilityTypeId = facilityTypeId
        self.facilityTypeName = facilityTypeName
        self.facilityComponentTypeId = facilityComponentTypeId
        self.facilityComponentTypeName = facilityComponentTypeName
        self.fromDate = fromDate
        self.thruDate = thruDate
        self.note = note
    }
}
