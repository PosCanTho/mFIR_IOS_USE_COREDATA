//
//  Facility.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/23/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Facility {
    
    var facilityId:String
    var facilityName:String
    var facilityTypeName:String
    var facilityUsageStatus:String
    var facilityRootId:String
    
    init(facilityId: String, facilityName: String, facilityTypeName: String, facilityUsageStatus: String, facilityRootId: String) {
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.facilityTypeName = facilityTypeName
        self.facilityUsageStatus = facilityUsageStatus
        self.facilityRootId = facilityRootId
    }
}
