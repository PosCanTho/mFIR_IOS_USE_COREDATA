//
//  Constants.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/26/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

struct Constants {
    
    struct URL {
        
        // URL Server
        private static let URL_SERVER:String = "http://dev.duytan.edu.vn:8075/ConnectService.asmx/"
        
        // Server Image
        private static let URL_SERVER_IMAGE:String = "http://dev.duytan.edu.vn:8045/FileUploader.asmx"
        static let UPLOAD_IMAGE_KEY:String = "Xds+vBvtvLyUUv8ydOOmjMYkPlQ="
        static let API_DOWNLOAD_FILE_IMAGE:String = URL_SERVER_IMAGE
        static let API_UPLOAD_FILE_IMAGE:String = URL_SERVER_IMAGE
        
        // API
        static let API_LOGIN:String = URL_SERVER + "Login"
        static let API_GET_LIST_FACILITY:String = URL_SERVER + "csvc_getFacility"
        static let API_GET_LIST_FACILITY_ISSUE:String = URL_SERVER + "csvc_getFacilityIssue"
        static let API_GET_LIST_FACILITY_COMPONENT_TYPE:String = URL_SERVER + "csvc_getFacilityComponentType"
        static let API_GET_RELATIONSHIP:String = URL_SERVER + "csvc_getFacilityTypeComponentTypeRelationship"
        static let API_GET_LIST_FACILITY_TYPE:String = URL_SERVER + "csvc_getFacilityType"
        static let API_GET_LIST_INSTRUCTOR:String = URL_SERVER + "csvc_getInstructor"
        static let API_GET_LIST_STUDENT:String = URL_SERVER + "csvc_getStudent"
        static let API_UPDATE_FACILITY_ISSUE:String = URL_SERVER + "csvc_insupdFacilityIssue"
        static let API_GET_ISSUE_STATUS:String = URL_SERVER + "csvc_getFacilityIssueStatus"
        static let API_GET_ISSUE_BY_FACILITY:String = URL_SERVER + "csvc_getFacilityIssueByFacility"
        static let API_GET_REGISTER_FCMTOKEN:String = URL_SERVER + "registerFCMToken"
        
    }
    
    struct ERROR {
        static let MES:String = "ERROR: -> "
        
        static let FILE_IMAGE_DATA:String = MES + "image is empty"
        static let FILE_IMAGE_NAME:String = MES + "image name is empty"
        static let PARSING_JSON:String = MES + "JSONSerialization"
    }
}

struct Databases {
    
    //Table WR_FICILITY_TYPE (loại cơ sở phòng)
    static let TABLE_FACILITY_TYPE:String = "FacilityTypeCoreData"
    static let FACILITY_TYPE_ID:String = "facilityTypeId"
    static let FACILITY_TYPE_NAME:String = "facilityTypeName"
    static let DESCRIPTION:String = "descriptionFacility"
    // Table WR-FACILITY_COMPONENT_TYPE (Loại nhóm thiết bị trong phòng)
    
    static let TABLE_FACILITY_COMPONENT_TYPE:String = "FacilityComponentTypeCoreData"
    static let FACILITY_COMPONENT_TYPE_ID:String = "facilityComponentTypeId"
    static let FACILITY_COMPONENT_TYPE_NAME:String = "facilityComponentTypeName"
    //Table WR-FACILITY (cơ sở phòng)
    static let TABLE_FACILITY:String = "FacilityCoreData"
    static let FACILITY_ID:String = "FacilityId"
    static let FACILITY_NAME:String = "FacilityName"
    static let ROOT_FACILITY_ID:String = "rootFacilityId"
    static let FACILITY_USAGE_STATUS:String = "facilityUsageStatus"
    
    //Table WR_FACILITY_ISSUE (Sự cố phòng)
    static let TABLE_FACILITY_ISSUE:String = "FacilityIssueCoreData"
    static let FACILITY_ISSUE_ID:String = "facilityIssueId"
    static let FACILITY_ISSUE_CASE_NUMBER:String = "facilityIssueCaseNumber"
    static let SAME_FACILITY_ISSUE_ID:String = "sameFacilityIssueId"
    static let SAME_FACILITY_ISSUE_CASE_NUMBER:String = "sameFacilityIssueCaseNumber"
    static let FACILITY_ISSUE_REPORT_DATETIME:String = "facilityIssueReportDatetime"
    static let FACILITY_ISSUE_STATUS:String = "facilityIssueStatus"
    
    static let FACILITY_COMPONENT_TYPE_ID_1:String = "facilityComponentTypeId1"
    static let FACILITY_COMPONENT_TYPE_NAME_1:String = "facilityComponentTypeName1"
    static let FACILITY_COMPONENT_ISSUE_REPORT_1:String = "facilityComponentIssueReport1"
    static let FACILITY_COMPONENT_ISSUE_STATUS_1:String = "facilityComponentIssueStatus1"
    static let FACILITY_ISSUE_RESOLVER_ID_NUMBER_1:String = "facilityIssueResolverIdNumber1"
    static let FACILITY_ISSUE_RESOLVED_DATETIME_1:String = "facilityIssueResolvedDatetime1"
    static let FACILITY_ISSUE_RESOLVERS_NOTE_1:String = "facilityIssueResolversNote1"
    
    static let FACILITY_COMPONENT_TYPE_ID_2:String = "facilityComponentTypeId2"
    static let FACILITY_COMPONENT_TYPE_NAME_2:String = "facilityComponentTypeName2"
    static let FACILITY_COMPONENT_ISSUE_REPORT_2:String = "facilityComponentIssueReport2"
    static let FACILITY_COMPONENT_ISSUE_STATUS_2:String = "facilityComponentIssueStatus2"
    static let FACILITY_ISSUE_RESOLVER_ID_NUMBER_2:String = "facilityIssueResolverIdNumber2"
    static let FACILITY_ISSUE_RESOLVED_DATETIME_2:String = "facilityIssueResolvedDatetime2"
    static let FACILITY_ISSUE_RESOLVERS_NOTE_2:String = "facilityIssueResolversNote2"
    
    static let FACILITY_COMPONENT_TYPE_ID_3:String = "facilityComponentTypeId3"
    static let FACILITY_COMPONENT_TYPE_NAME_3:String = "facilityComponentTypeName3"
    static let FACILITY_COMPONENT_ISSUE_REPORT_3:String = "facilityComponentIssueReport3"
    static let FACILITY_COMPONENT_ISSUE_STATUS_3:String = "facilityComponentIssueStatus3"
    static let FACILITY_ISSUE_RESOLVER_ID_NUMBER_3:String = "facilityIssueResolverIdNumber3"
    static let FACILITY_ISSUE_RESOLVED_DATETIME_3:String = "facilityIssueResolvedDatetime3"
    static let FACILITY_ISSUE_RESOLVERS_NOTE_3:String = "facilityIssueResolversNote3"
    
    static let FACILITY_COMPONENT_TYPE_ID_4:String = "facilityComponentTypeId4"
    static let FACILITY_COMPONENT_TYPE_NAME_4:String = "facilityComponentTypeName4"
    static let FACILITY_COMPONENT_ISSUE_REPORT_4:String = "facilityComponentIssueReport4"
    static let FACILITY_COMPONENT_ISSUE_STATUS_4:String = "facilityComponentIssueStatus4"
    static let FACILITY_ISSUE_RESOLVER_ID_NUMBER_4:String = "facilityIssueResolverIdNumber4"
    static let FACILITY_ISSUE_RESOLVED_DATETIME_4:String = "facilityIssueResolvedDatetime4"
    static let FACILITY_ISSUE_RESOLVERS_NOTE_4:String = "facilityIssueResolversNote4"
    
    static let FACILITY_COMPONENT_TYPE_ID_5:String = "facilityComponentTypeId5"
    static let FACILITY_COMPONENT_TYPE_NAME_5:String = "facilityComponentTypeName5"
    static let FACILITY_COMPONENT_ISSUE_REPORT_5:String = "facilityComponentIssueReport5"
    static let FACILITY_COMPONENT_ISSUE_STATUS_5:String = "facilityComponentIssueStatus5"
    static let FACILITY_ISSUE_RESOLVER_ID_NUMBER_5:String = "facilityIssueResolverIdNumber5"
    static let FACILITY_ISSUE_RESOLVED_DATETIME_5:String = "facilityIssueResolvedDatetime5"
    static let FACILITY_ISSUE_RESOLVERS_NOTE_5:String = "facilityIssueResolversNote5"
    
    static let IMAGE_1:String = "image1"
    static let IMAGE_2:String = "image2"
    static let IMAGE_3:String = "image3"
    static let IMAGE_4:String = "image4"
    static let IMAGE_5:String = "image5"
    
    static let FACILITY_COMPONENT_TYPE_NUMBER:String = "facilityComponentTypeNumber"
    static let FACILITY_COMPONENT_ISSUE_REPORT:String = "facilityComponentIssueReport"
    
    static let STUDENT_ID_NUMBER:String = "studentIdNumber"
    static let INSTRUCTOR_ID_NUMBER:String = "instructorIdNumber"
    
    static let TABLE_FACILITY_RELATIONSHIP:String = "RelationshipCoreData"
    static let FROM_DATE:String = "fromDate"
    static let THRU_DATE:String = "thruDate"
    
    
    static let NOTE:String = "note"
    static let USER_ID:String = "userId"
    static let TABLE_ACCOUNT:String = "Account"
    
    static let ACCOUNT_ID:String = "accountId"
    static let UESRNAME:String = "userName"
    static let PASSWORD:String = "password"
    static let ROW_ID:String = "rowId"
}



