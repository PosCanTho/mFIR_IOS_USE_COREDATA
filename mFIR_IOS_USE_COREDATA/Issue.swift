//
//  Issue.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Issue{
    
    var facilityIssueId:String?
    var facilityIssueCaseNumber:String?
    var sameFacilityIssueId:String?
    var sameFacilityIssueCaseNumber:String?
    var facilityIssueReportDatetime:String?
    var facilityIssueStatus:String?
    var instructorIdNumber:String?
    var studentIdNumber:String?
    var facilityId:String?
    var facilityName:String?
    var facilityTypeName:String?
    var facilityComponentTypeId1:String?
    var facilityComponentTypeName1:String?
    var facilityComponentIssueReport1:String?
    var facilityComponentIssueStatus1:String?
    var facilityComponentIssue_picture1:String?
    var facilityIssueResolverIdNumber1:String?
    var facilityIssueResolvedDatetime1:String?
    var facilityIssueResolversNote1:String?
    var facilityComponentTypeId2:String?
    var facilityComponentTypeName2:String?
    var facilityComponentIssueReport2:String?
    var facilityComponentIssueStatus2:String?
    var facilityComponentIssue_picture2:String?
    var facilityIssueResolverIdNumber2:String?
    var facilityIssueResolvedDatetime2:String?
    var facilityIssueResolversNote2:String?
    var facilityComponentTypeId3:String?
    var facilityComponentTypeName3:String?
    var facilityComponentIssueReport3:String?
    var facilityComponentIssueStatus3:String?
    var facilityComponentIssue_picture3:String?
    var facilityIssueResolverIdNumber3:String?
    var facilityIssueResolvedDatetime3:String?
    var facilityIssueResolversNote3:String?
    var facilityComponentTypeId4:String?
    var facilityComponentTypeName4:String?
    var facilityComponentIssueReport4:String?
    var facilityComponentIssueStatus4:String?
    var facilityComponentIssue_picture4:String?
    var facilityIssueResolverIdNumber4:String?
    var facilityIssueResolvedDatetime4:String?
    var facilityIssueResolversNote4:String?
    var facilityComponentTypeId5:String?
    var facilityComponentTypeName5:String?
    var facilityComponentIssueReport5:String?
    var facilityComponentIssueStatus5:String?
    var facilityComponentIssue_picture5:String?
    var facilityIssueResolverIdNumber5:String?
    var facilityIssueResolvedDatetime5:String?
    var facilityIssueResolversNote5:String?
    
    init(
        facilityIssueId: String,
        facilityIssueCaseNumber: String,
        sameFacilityIssueId: String,
        sameFacilityIssueCaseNumber: String,
        facilityIssueReportDatetime: String,
        facilityIssueStatus: String,
        instructorIdNumber: String,
        studentIdNumber: String,
        facilityId: String,
        facilityName: String,
        facilityTypeName: String,
        facilityComponentTypeId1: String,
        facilityComponentTypeName1: String,
        facilityComponentIssueReport1: String,
        facilityComponentIssueStatus1: String,
        facilityComponentIssue_picture1: String,
        facilityIssueResolverIdNumber1: String,
        facilityIssueResolvedDatetime1: String,
        facilityIssueResolversNote1: String,
        facilityComponentTypeId2: String,
        facilityComponentTypeName2: String,
        facilityComponentIssueReport2: String,
        facilityComponentIssueStatus2: String,
        facilityComponentIssue_picture2: String,
        facilityIssueResolverIdNumber2: String,
        facilityIssueResolvedDatetime2: String,
        facilityIssueResolversNote2: String,
        facilityComponentTypeId3: String,
        facilityComponentTypeName3: String,
        facilityComponentIssueReport3: String,
        facilityComponentIssueStatus3: String,
        facilityComponentIssue_picture3: String,
        facilityIssueResolverIdNumber3: String,
        facilityIssueResolvedDatetime3: String,
        facilityIssueResolversNote3: String,
        facilityComponentTypeId4: String,
        facilityComponentTypeName4: String,
        facilityComponentIssueReport4: String,
        facilityComponentIssueStatus4: String,
        facilityComponentIssue_picture4: String,
        facilityIssueResolverIdNumber4: String,
        facilityIssueResolvedDatetime4: String,
        facilityIssueResolversNote4: String,
        facilityComponentTypeId5: String,
        facilityComponentTypeName5: String,
        facilityComponentIssueReport5: String,
        facilityComponentIssueStatus5: String,
        facilityComponentIssue_picture5: String,
        facilityIssueResolverIdNumber5: String,
        facilityIssueResolvedDatetime5: String,
        facilityIssueResolversNote5: String
        ) {
        self.facilityIssueId = facilityIssueId
        self.facilityIssueCaseNumber = facilityIssueCaseNumber
        self.sameFacilityIssueId = sameFacilityIssueId
        self.sameFacilityIssueCaseNumber = sameFacilityIssueCaseNumber
        self.facilityIssueReportDatetime = facilityIssueReportDatetime
        self.facilityIssueStatus = facilityIssueStatus
        self.instructorIdNumber = instructorIdNumber
        self.studentIdNumber = studentIdNumber
        self.facilityId = facilityId
        self.facilityName = facilityName
        self.facilityTypeName = facilityTypeName
        self.facilityComponentTypeId1 = facilityComponentTypeId1
        self.facilityComponentTypeName1 = facilityComponentTypeName1
        self.facilityComponentIssueReport1 = facilityComponentIssueReport1
        self.facilityComponentIssueStatus1 = facilityComponentIssueStatus1
        self.facilityComponentIssue_picture1 = facilityComponentIssue_picture1
        self.facilityIssueResolverIdNumber1 = facilityIssueResolverIdNumber1
        self.facilityIssueResolvedDatetime1 = facilityIssueResolvedDatetime1
        self.facilityIssueResolversNote1 = facilityIssueResolversNote1
        self.facilityComponentTypeId2 = facilityComponentTypeId2
        self.facilityComponentTypeName2 = facilityComponentTypeName2
        self.facilityComponentIssueReport2 = facilityComponentIssueReport2
        self.facilityComponentIssueStatus2 = facilityComponentIssueStatus2
        self.facilityComponentIssue_picture2 = facilityComponentIssue_picture2
        self.facilityIssueResolverIdNumber2 = facilityIssueResolverIdNumber2
        self.facilityIssueResolvedDatetime2 = facilityIssueResolvedDatetime2
        self.facilityIssueResolversNote2 = facilityIssueResolversNote2
        self.facilityComponentTypeId3 = facilityComponentTypeId3
        self.facilityComponentTypeName3 = facilityComponentTypeName3
        self.facilityComponentIssueReport3 = facilityComponentIssueReport3
        self.facilityComponentIssueStatus3 = facilityComponentIssueStatus3
        self.facilityComponentIssue_picture3 = facilityComponentIssue_picture3
        self.facilityIssueResolverIdNumber3 = facilityIssueResolverIdNumber3
        self.facilityIssueResolvedDatetime3 = facilityIssueResolvedDatetime3
        self.facilityIssueResolversNote3 = facilityIssueResolversNote3
        self.facilityComponentTypeId4 = facilityComponentTypeId4
        self.facilityComponentTypeName4 = facilityComponentTypeName4
        self.facilityComponentIssueReport4 = facilityComponentIssueReport4
        self.facilityComponentIssueStatus4 = facilityComponentIssueStatus4
        self.facilityComponentIssue_picture4 = facilityComponentIssue_picture4
        self.facilityIssueResolverIdNumber4 = facilityIssueResolverIdNumber4
        self.facilityIssueResolvedDatetime4 = facilityIssueResolvedDatetime4
        self.facilityIssueResolversNote4 = facilityIssueResolversNote4
        self.facilityComponentTypeId5 = facilityComponentTypeId5
        self.facilityComponentTypeName5 = facilityComponentTypeName5
        self.facilityComponentIssueReport5 = facilityComponentIssueReport5
        self.facilityComponentIssueStatus5 = facilityComponentIssueStatus5
        self.facilityComponentIssue_picture5 = facilityComponentIssue_picture5
        self.facilityIssueResolverIdNumber5 = facilityIssueResolverIdNumber5
        self.facilityIssueResolvedDatetime5 = facilityIssueResolvedDatetime5
        self.facilityIssueResolversNote5 = facilityIssueResolversNote5
    }
}
