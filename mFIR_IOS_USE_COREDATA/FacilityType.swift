//
//  FacilityType.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class FacilityType {
    var facilityTypeId:String
    var facilityTypeName:String
    var desctiption:String
    
    init(facilityTypeId:String, facilityTypeName:String, desctiption:String) {
        self.facilityTypeId = facilityTypeId
        self.facilityTypeName = facilityTypeName
        self.desctiption = desctiption
    }
}
