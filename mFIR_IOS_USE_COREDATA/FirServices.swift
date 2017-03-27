//
//  FirServices.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/26/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation


class FirServices{
    
    // ============================
    private static func dataTask(
        url: String,
        post: PostParameter,
        callback: @escaping (_ json: Dictionary<String, Any>, _ error: URLError?) -> Void) {
        
        let TAG = "func -> dataTask: "
        
        
        if(!post.isLogin()){
            let user = UserDefaults.standard
            guard let username = user.string(forKey: UserReferences.USERNAME), let password = user.string(forKey: UserReferences.PASSWORD) else{
                print("FirServices: -> User is nil !!!")
                return
            }
            
            post.add(key: "username", value: username)
            post.add(key: "password", value: password)
        }
        
        let postString:String = post.getString()
        
        let urlRequest = URL(string: url)!
        var request = URLRequest(url: urlRequest)
        
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil
                else {
                    
                    callback(Dictionary<String, AnyObject>(), error as! URLError?)
                    return
            }
            
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print(TAG + "statusCode should be 200, but is \(httpStatus.statusCode)")
                print(TAG + "response = \(response)")
                
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    callback(json, nil)
                }
                
            } catch let err{
                print(TAG + err.localizedDescription)
                callback(Dictionary<String, AnyObject>(), nil)
            }
        }
        task.resume()
    }
    
    
    
    
    static func login(username: String, password: String, imei: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> login: "
        
        let post = PostParameter()
        post.add(key: "username", value: username)
        post.add(key: "password", value: password)
        post.add(key: "imei", value: "")
        
        FirServices.dataTask(url: Constants.URL.API_LOGIN, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                let userReference = UserDefaults.standard
                userReference.removeObject(forKey: UserReferences.USERNAME)
                userReference.removeObject(forKey: UserReferences.PASSWORD)
                callback(false)
                return
            }
            
            guard let instructorIdNumber = table[0]["INSTRUCTOR_ID_NUMBER"] as? String,
                let userName = table[0]["UserName"] as? String,
                let currentLastName = table[0]["CURRENT_LAST_NAME"] as? String,
                let roleType = table[0]["ROLE_TYPE"] as? String,
                let studentIdNumber = table[0]["STUDENT_ID_NUMBER"] as? String,
                let currentFirstName = table[0]["CURRENT_FIRST_NAME"] as? String,
                let userId = table[0]["USER_ID"] as? String,
                let currentMiddleName = table[0]["CURRENT_MIDDLE_NAME"] as? String
                else{
                    print(TAG + "Parsing JSON error!")
                    return
            }
            
            let user = User(
                userId: userId,
                userName: userName,
                studentIdNumber: studentIdNumber,
                instructorIdNumber: instructorIdNumber,
                currentLastName: currentLastName,
                currentMiddleName: currentMiddleName,
                currentFirstName: currentFirstName,
                roleType: roleType)
            
            callback(user)
        }
    }
    // ============================
    
    
    // ============================
    static func getFacility(facilityId: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> facility: "
        
        let post = PostParameter()
        post.add(key: "facility_id", value: facilityId)
        
        var listFacility = [Facility]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                callback(false)
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_ID"] as? String,
                    let name = element["FACILITY_NAME"] as? String,
                    let typeName = element["FACILITY_TYPE_NAME"] as? String,
                    let usageStatus = element["FACILITY_USAGE_STATUS"] as? String,
                    let rootId = element["ROOT_ROOT_FACILITY_ID"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let facility = Facility(facilityId: id, facilityName: name, facilityTypeName: typeName, facilityUsageStatus: usageStatus, facilityRootId: rootId)
                listFacility.append(facility)
            }
            
            callback(listFacility)
        }
    }
    // ============================
    
    
    // ============================
    static func getIssue(facilityIssueId: String, fromDate: String, thruDate: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> facilityIssue: "
        
        let post = PostParameter()
        post.add(key: "facility_issue_id", value: facilityIssueId)
        post.add(key: "from_date", value: fromDate)
        post.add(key: "thru_date", value: thruDate)
        
        var listIssue = [Issue]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_ISSUE, post: post){
            (json, error) in
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            
            for element in table{
                
                guard let facilityIssueId = element["FACILITY_ISSUE_ID"] as? String,
                    let facilityIssueCaseNumber = element["FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let sameFacilityIssueId = element["SAME_FACILITY_ISSUE_ID"] as? String,
                    let sameFacilityIssueCaseNumber = element["SAME_FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let facilityIssueReportDatetime = element["FACILITY_ISSUE_REPORT_DATETIME"] as? String,
                    let facilityIssueStatus = element["FACILITY_ISSUE_STATUS"] as? String,
                    let instructorIdNumber = element["INSTRUCTOR_ID_NUMBER"] as? String,
                    let studentIdNumber = element["STUDENT_ID_NUMBER"] as? String,
                    let facilityId = element["FACILITY_ID"] as? String,
                    let facilityName = element["FACILITY_NAME"] as? String,
                    let facilityTypeName = element["FACILITY_TYPE_NAME"] as? String,
                    let facilityComponentTypeId1 = element["FACILITY_COMPONENT_TYPE_ID_1"] as? String,
                    let facilityComponentTypeName1 = element["FACILITY_COMPONENT_TYPE_NAME_1"] as? String,
                    let facilityComponentIssueReport1 = element["FACILITY_COMPONENT_ISSUE_REPORT_1"] as? String,
                    let facilityComponentIssueStatus1 = element["FACILITY_COMPONENT_ISSUE_STATUS_1"] as? String,
                    let facilityComponentIssue_picture1 = element["FACILITY_COMPONENT_ISSUE_PICTURE_1"] as? String,
                    let facilityIssueResolverIdNumber1 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_1"] as? String,
                    let facilityIssueResolvedDatetime1 = element["FACILITY_ISSUE_RESOLVED_DATETIME_1"] as? String,
                    let facilityIssueResolversNote1 = element["FACILITY_ISSUE_RESOLVERS_NOTE_1"] as? String,
                    let facilityComponentTypeId2 = element["FACILITY_COMPONENT_TYPE_ID_2"] as? String,
                    let facilityComponentTypeName2 = element["FACILITY_COMPONENT_TYPE_NAME_2"] as? String,
                    let facilityComponentIssueReport2 = element["FACILITY_COMPONENT_ISSUE_REPORT_2"] as? String,
                    let facilityComponentIssueStatus2 = element["FACILITY_COMPONENT_ISSUE_STATUS_2"] as? String,
                    let facilityComponentIssue_picture2 = element["FACILITY_COMPONENT_ISSUE_PICTURE_2"] as? String,
                    let facilityIssueResolverIdNumber2 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_2"] as? String,
                    let facilityIssueResolvedDatetime2 = element["FACILITY_ISSUE_RESOLVED_DATETIME_2"] as? String,
                    let facilityIssueResolversNote2 = element["FACILITY_ISSUE_RESOLVERS_NOTE_2"] as? String,
                    let facilityComponentTypeId3 = element["FACILITY_COMPONENT_TYPE_ID_3"] as? String,
                    let facilityComponentTypeName3 = element["FACILITY_COMPONENT_TYPE_NAME_3"] as? String,
                    let facilityComponentIssueReport3 = element["FACILITY_COMPONENT_ISSUE_REPORT_3"] as? String,
                    let facilityComponentIssueStatus3 = element["FACILITY_COMPONENT_ISSUE_STATUS_3"] as? String,
                    let facilityComponentIssue_picture3 = element["FACILITY_COMPONENT_ISSUE_PICTURE_3"] as? String,
                    let facilityIssueResolverIdNumber3 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_3"] as? String,
                    let facilityIssueResolvedDatetime3 = element["FACILITY_ISSUE_RESOLVED_DATETIME_3"] as? String,
                    let facilityIssueResolversNote3 = element["FACILITY_ISSUE_RESOLVERS_NOTE_3"] as? String,
                    let facilityComponentTypeId4 = element["FACILITY_COMPONENT_TYPE_ID_4"] as? String,
                    let facilityComponentTypeName4 = element["FACILITY_COMPONENT_TYPE_NAME_4"] as? String,
                    let facilityComponentIssueReport4 = element["FACILITY_COMPONENT_ISSUE_REPORT_4"] as? String,
                    let facilityComponentIssueStatus4 = element["FACILITY_COMPONENT_ISSUE_STATUS_4"] as? String,
                    let facilityComponentIssue_picture4 = element["FACILITY_COMPONENT_ISSUE_PICTURE_4"] as? String,
                    let facilityIssueResolverIdNumber4 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_4"] as? String,
                    let facilityIssueResolvedDatetime4 = element["FACILITY_ISSUE_RESOLVED_DATETIME_4"] as? String,
                    let facilityIssueResolversNote4 = element["FACILITY_ISSUE_RESOLVERS_NOTE_4"] as? String,
                    let facilityComponentTypeId5 = element["FACILITY_COMPONENT_TYPE_ID_5"] as? String,
                    let facilityComponentTypeName5 = element["FACILITY_COMPONENT_TYPE_NAME_5"] as? String,
                    let facilityComponentIssueReport5 = element["FACILITY_COMPONENT_ISSUE_REPORT_5"] as? String,
                    let facilityComponentIssueStatus5 = element["FACILITY_COMPONENT_ISSUE_STATUS_5"] as? String,
                    let facilityComponentIssue_picture5 = element["FACILITY_COMPONENT_ISSUE_PICTURE_5"] as? String,
                    let facilityIssueResolverIdNumber5 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_5"] as? String,
                    let facilityIssueResolvedDatetime5 = element["FACILITY_ISSUE_RESOLVED_DATETIME_5"] as? String,
                    let facilityIssueResolversNote5 = element["FACILITY_ISSUE_RESOLVERS_NOTE_5"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let issue = Issue(
                    facilityIssueId: facilityIssueId,
                    facilityIssueCaseNumber: facilityIssueCaseNumber,
                    sameFacilityIssueId: sameFacilityIssueId,
                    sameFacilityIssueCaseNumber: sameFacilityIssueCaseNumber,
                    facilityIssueReportDatetime: facilityIssueReportDatetime,
                    facilityIssueStatus: facilityIssueStatus,
                    instructorIdNumber: instructorIdNumber,
                    studentIdNumber: studentIdNumber,
                    facilityId: facilityId,
                    facilityName: facilityName,
                    facilityTypeName: facilityTypeName,
                    facilityComponentTypeId1: facilityComponentTypeId1,
                    facilityComponentTypeName1: facilityComponentTypeName1,
                    facilityComponentIssueReport1: facilityComponentIssueReport1,
                    facilityComponentIssueStatus1: facilityComponentIssueStatus1,
                    facilityComponentIssue_picture1: facilityComponentIssue_picture1,
                    facilityIssueResolverIdNumber1: facilityIssueResolverIdNumber1,
                    facilityIssueResolvedDatetime1: facilityIssueResolvedDatetime1,
                    facilityIssueResolversNote1: facilityIssueResolversNote1,
                    facilityComponentTypeId2: facilityComponentTypeId2,
                    facilityComponentTypeName2: facilityComponentTypeName2,
                    facilityComponentIssueReport2: facilityComponentIssueReport2,
                    facilityComponentIssueStatus2: facilityComponentIssueStatus2,
                    facilityComponentIssue_picture2: facilityComponentIssue_picture2,
                    facilityIssueResolverIdNumber2: facilityIssueResolverIdNumber2,
                    facilityIssueResolvedDatetime2: facilityIssueResolvedDatetime2,
                    facilityIssueResolversNote2: facilityIssueResolversNote2,
                    facilityComponentTypeId3: facilityComponentTypeId3,
                    facilityComponentTypeName3: facilityComponentTypeName3,
                    facilityComponentIssueReport3: facilityComponentIssueReport3,
                    facilityComponentIssueStatus3: facilityComponentIssueStatus3,
                    facilityComponentIssue_picture3: facilityComponentIssue_picture3,
                    facilityIssueResolverIdNumber3: facilityIssueResolverIdNumber3,
                    facilityIssueResolvedDatetime3: facilityIssueResolvedDatetime3,
                    facilityIssueResolversNote3: facilityIssueResolversNote3,
                    facilityComponentTypeId4: facilityComponentTypeId4,
                    facilityComponentTypeName4: facilityComponentTypeName4,
                    facilityComponentIssueReport4: facilityComponentIssueReport4,
                    facilityComponentIssueStatus4: facilityComponentIssueStatus4,
                    facilityComponentIssue_picture4: facilityComponentIssue_picture4,
                    facilityIssueResolverIdNumber4: facilityIssueResolverIdNumber4,
                    facilityIssueResolvedDatetime4: facilityIssueResolvedDatetime4,
                    facilityIssueResolversNote4: facilityIssueResolversNote4,
                    facilityComponentTypeId5: facilityComponentTypeId5,
                    facilityComponentTypeName5: facilityComponentTypeName5,
                    facilityComponentIssueReport5: facilityComponentIssueReport5,
                    facilityComponentIssueStatus5: facilityComponentIssueStatus5,
                    facilityComponentIssue_picture5: facilityComponentIssue_picture5,
                    facilityIssueResolverIdNumber5: facilityIssueResolverIdNumber5,
                    facilityIssueResolvedDatetime5: facilityIssueResolvedDatetime5,
                    facilityIssueResolversNote5: facilityIssueResolversNote5
                )
                listIssue.append(issue)
            }
            
            callback(listIssue)
        }
    }
    // ============================
    
    
    // ============================
    static func getComponentType(facilityComponentTypeId: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> componentType: "
        
        let post = PostParameter()
        post.add(key: "facility_component_type_id", value: facilityComponentTypeId)
        
        var listComponentType = [ComponentType]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_COMPONENT_TYPE, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                callback(false)
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_COMPONENT_TYPE_ID"] as? String,
                    let name = element["FACILITY_COMPONENT_TYPE_NAME"] as? String,
                    let description = element["DESCRIPTION"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let componentType = ComponentType(componentTypeId: id, componentTypeName: name, description: description)
                listComponentType.append(componentType)
            }
            
            callback(listComponentType)
        }
    }
    // ============================
    
    
    // ============================
    static func getRelationship(facilityTypeId: String, facilityComponentTypeId: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> relationship: "
        
        let post = PostParameter()
        post.add(key: "facility_type_id", value: facilityTypeId)
        post.add(key: "facility_component_type_id", value: facilityComponentTypeId)
        
        var listRelationship = [Relationship]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_RELATIONSHIP, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            for element in table{
                
                guard let facilityTypeId = element["FACILITY_TYPE_ID"] as? String,
                    let facilityTypeName = element["FACILITY_TYPE_NAME"] as? String,
                    let facilityComponentTypeId = element["FACILITY_COMPONENT_TYPE_ID"] as? String,
                    let facilityComponentTypeName = element["FACILITY_COMPONENT_TYPE_NAME"] as? String,
                    let fromDate = element["FROM_DATE"] as? String,
                    let thruDate = element["THRU_DATE"] as? String,
                    let note = element["NOTE"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let relationship = Relationship(
                    facilityTypeId: facilityTypeId,
                    facilityTypeName: facilityTypeName,
                    facilityComponentTypeId: facilityComponentTypeId,
                    facilityComponentTypeName: facilityComponentTypeName,
                    fromDate: fromDate,
                    thruDate: thruDate,
                    note: note
                )
                listRelationship.append(relationship)
            }
            
            callback(listRelationship)
        }
    }
    // ============================
    
    
    // ============================
    static func getFacilityType(facilityTypeId: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> facilityType: "
        
        let post = PostParameter()
        post.add(key: "facility_type_id", value: facilityTypeId)
        
        var listFacilityType = [FacilityType]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_FACILITY_TYPE, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_TYPE_ID"] as? String,
                    let name = element["FACILITY_TYPE_NAME"] as? String,
                    let description = element["DESCRIPTION"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let facilityType = FacilityType(facilityTypeId: id, facilityTypeName: name, description: description)
                listFacilityType.append(facilityType)
                
            }
            
            callback(listFacilityType)
        }
    }
    // ============================
    
    
    // ============================
    static func getInstructor(instructorIdNumber: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> instructor: "
        
        let post = PostParameter()
        post.add(key: "instructor_id_number", value: instructorIdNumber)
        
        var listInstructor = [Instructor]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_INSTRUCTOR, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            
            for element in table{
                
                guard let instructorIdNumber = element["INSTRUCTOR_ID_NUMBER"] as? String,
                    let currentLastName = element["CURRENT_LAST_NAME"] as? String,
                    let currentFirstName = element["CURRENT_FIRST_NAME"] as? String,
                    let currentMiddleName = element["CURRENT_MIDDLE_NAME"] as? String,
                    let currentPersonalTitle = element["CURRENT_PERSONAL_TITLE"] as? String,
                    let currentSuffix = element["CURRENT_SUFFIX"] as? String,
                    let currentNickname = element["CURRENT_NICKNAME"] as? String,
                    let birthDate = element["BIRTH_DATE"] as? String,
                    let birthPlace = element["BIRTH_PLACE"] as? String,
                    let motherSMaidenName = element["MOTHER_S_MAIDEN_NAME"] as? String,
                    let currentMaritalStatus = element["CURRENT_MARITAL_STATUS"] as? String,
                    let peopleIdNumber = element["PEOPLE_ID_NUMBER"] as? String,
                    let peopleIdIssueDate = element["PEOPLE_ID_ISSUE_DATE"] as? String,
                    let peopleIdIssuePlace = element["PEOPLE_ID_ISSUE_PLACE"] as? String,
                    let socialSecurityNumber = element["SOCIAL_SECURITY_NUMBER"] as? String,
                    let currentMajorCitizenship = element["CURRENT_MAJOR_CITIZENSHIP"] as? String,
                    let currentPassportNumber = element["CURRENT_PASSPORT_NUMBER"] as? String,
                    let currentPassportIssuePlace = element["CURRENT_PASSPORT_ISSUE_PLACE"] as? String,
                    let currentPassportIssueDate = element["CURRENT_PASSPORT_ISSUE_DATE"] as? String,
                    let currentPassportExpirationDate = element["CURRENT_PASSPORT_EXPIRATION_DATE"] as? String,
                    let totalYearsWorkExperience = element["TOTAL_YEARS_WORK_EXPERIENCE"] as? String,
                    let instructorTeachingStatusTypeName = element["INSTRUCTOR_TEACHING_STATUS_TYPE_NAME"] as? String,
                    let academicDepartment = element["ACADEMIC_DEPARTMENT"] as? String,
                    let academicGroupUnit = element["ACADEMIC_GROUP_UNIT"] as? String,
                    let academicTitle = element["ACADEMIC_TITLE"] as? String,
                    let instructorTypeName = element["INSTRUCTOR_TYPE_NAME"] as? String,
                    let closeupPicture1 = element["CLOSEUP_PICTURE_1"] as? String,
                    let closeupPicture2 = element["CLOSEUP_PICTURE_2"] as? String,
                    let currentAddress = element["CURRENT_ADDRESS"] as? String,
                    let currentCountry = element["CURRENT_COUNTRY"] as? String,
                    let currentDistrict = element["CURRENT_DISTRICT"] as? String,
                    let currentGender = element["CURRENT_GENDER"] as? String,
                    let currentState = element["CURRENT_STATE"] as? String,
                    let currentWard = element["CURRENT_WARD"] as? String,
                    let homeAddress = element["HOME_ADDRESS"] as? String,
                    let homeCity = element["HOME_CITY"] as? String,
                    let homeCountry = element["HOME_COUNTRY"] as? String,
                    let homeDistrict = element["HOME_DISTRICT"] as? String,
                    let homeState = element["HOME_STATE"] as? String,
                    let homeWard = element["HOME_WARD"] as? String,
                    let startDateInSchool = element["START_DATE_IN_SCHOOL"] as? String,
                    let startDateForTeaching = element["START_DATE_FOR_TEACHING"] as? String,
                    let startDateForTeachingInSchool = element["START_DATE_FOR_TEACHING_IN_SCHOOL"] as? String,
                    let currentPhoneNumber = element["CURRENT_PHONE_NUMBER"] as? String,
                    let currentMobileNumber = element["CURRENT_MOBILE_NUMBER"] as? String,
                    let currentPersonalEmail = element["CURRENT_PERSONAL_EMAIL"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let instructor = Instructor(
                    instructorIdNumber: instructorIdNumber,
                    currentLastName: currentLastName,
                    currentFirstName: currentFirstName,
                    currentMiddleName: currentMiddleName,
                    currentPersonalTitle: currentPersonalTitle,
                    currentSuffix: currentSuffix,
                    currentNickname: currentNickname,
                    birthDate: birthDate,
                    birthPlace: birthPlace,
                    motherSMaidenName: motherSMaidenName,
                    currentMaritalStatus: currentMaritalStatus,
                    peopleIdNumber: peopleIdNumber,
                    peopleIdIssueDate: peopleIdIssueDate,
                    peopleIdIssuePlace: peopleIdIssuePlace,
                    socialSecurityNumber: socialSecurityNumber,
                    currentMajorCitizenship: currentMajorCitizenship,
                    currentPassportNumber: currentPassportNumber,
                    currentPassportIssuePlace: currentPassportIssuePlace,
                    currentPassportIssueDate: currentPassportIssueDate,
                    currentPassportExpirationDate: currentPassportExpirationDate,
                    totalYearsWorkExperience: totalYearsWorkExperience,
                    instructorTeachingStatusTypeName: instructorTeachingStatusTypeName,
                    academicDepartment: academicDepartment,
                    academicGroupUnit: academicGroupUnit,
                    academicTitle: academicTitle,
                    instructorTypeName: instructorTypeName,
                    closeupPicture1: closeupPicture1,
                    closeupPicture2: closeupPicture2,
                    currentAddress: currentAddress,
                    currentCountry: currentCountry,
                    currentDistrict: currentDistrict,
                    currentGender: currentGender,
                    currentState: currentState,
                    currentWard: currentWard,
                    homeAddress: homeAddress,
                    homeCity: homeCity,
                    homeCountry: homeCountry,
                    homeDistrict: homeDistrict,
                    homeState: homeState,
                    homeWard: homeWard,
                    startDateInSchool: startDateInSchool,
                    startDateForTeaching: startDateForTeaching,
                    startDateForTeachingInSchool: startDateForTeachingInSchool,
                    currentPhoneNumber: currentPhoneNumber,
                    currentMobileNumber: currentMobileNumber,
                    currentPersonalEmail: currentPersonalEmail
                )
                listInstructor.append(instructor)
                
            }
            
            callback(listInstructor)
        }
    }
    // ============================
    
    
    // ============================
    static func getStudent(studentIdNumber: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> student: "
        
        let post = PostParameter()
        post.add(key: "student_id_number", value: studentIdNumber)
        
        var listStudent = [Student]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_LIST_STUDENT, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            
            for element in table{
                
                guard let studentIdNumber = element["STUDENT_ID_NUMBER"] as? String,
                    let currentLastName = element["CURRENT_LAST_NAME"] as? String,
                    let currentFirstName = element["CURRENT_FIRST_NAME"] as? String,
                    let currentMiddleName = element["CURRENT_MIDDLE_NAME"] as? String,
                    let birthDate = element["BIRTH_DATE"] as? String,
                    let peopleIdNumber = element["PEOPLE_ID_NUMBER"] as? String,
                    let currentGender = element["CURRENT_GENDER"] as? String,
                    let currentPhoneNumber = element["CURRENT_PHONE_NUMBER"] as? String,
                    let currentMobileNumber = element["CURRENT_MOBILE_NUMBER"] as? String,
                    let academicIntakeSessionName = element["ACADEMIC_INTAKE_SESSION_NAME"] as? String,
                    let academicProgramName = element["ACADEMIC_PROGRAM_NAME"] as? String,
                    let curriculumName = element["CURRICULUM_NAME"] as? String,
                    let curriculumCode = element["CURRICULUM_CODE"] as? String,
                    let programShort = element["PROGRAM_SHORT"] as? String,
                    let academicProgramCode = element["ACADEMIC_PROGRAM_CODE"] as? String,
                    let academicLevelName = element["ACADEMIC_LEVEL_NAME"] as? String,
                    let studentLearningStatusTypeName = element["STUDENT_LEARNING_STATUS_TYPE_NAME"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let student = Student(
                    studentIdNumber: studentIdNumber,
                    currentLastName: currentLastName,
                    currentFirstName: currentFirstName,
                    currentMiddleName: currentMiddleName,
                    birthDate: birthDate,
                    peopleIdNumber: peopleIdNumber,
                    currentGender: currentGender,
                    currentPhoneNumber: currentPhoneNumber,
                    currentMobileNumber: currentMobileNumber,
                    academicIntakeSessionName: academicIntakeSessionName,
                    academicProgramName: academicProgramName,
                    curriculumName: curriculumName,
                    curriculumCode: curriculumCode,
                    programShort: programShort,
                    academicProgramCode: academicProgramCode,
                    academicLevelName: academicLevelName,
                    studentLearningStatusTypeName: studentLearningStatusTypeName
                )
                listStudent.append(student)
                
            }
            
            callback(listStudent)
        }
    }
    // ============================
    
    
    // ============================
    static func getIssueStatus(callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> issueStatus: "
        
        //        let post = ""
        let post = PostParameter()
        
        var listIssueStatus = [IssueStatus]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_ISSUE_STATUS, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                return
            }
            
            for element in table{
                
                guard let id = element["TYPE_NAME_ID"] as? String,
                    let name = element["TYPE_NAME_NAME"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                let issueStatus = IssueStatus(typeNameId: id, typeNameName: name)
                listIssueStatus.append(issueStatus)
                
            }
            
            callback(listIssueStatus)
        }
    }
    // ============================
    
    
    // ============================
    static func getIssueByFacility(facilityId: String, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> issueByFacility: "
        
        let post = PostParameter()
        post.add(key: "facility_id", value: facilityId)
        
        var listIssue = [Issue]()
        
        FirServices.dataTask(url: Constants.URL.API_GET_ISSUE_BY_FACILITY, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                callback(false)
                return
            }
            for element in table{
                
                guard let facilityIssueId = element["FACILITY_ISSUE_ID"] as? String,
                    let facilityIssueCaseNumber = element["FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let sameFacilityIssueId = element["SAME_FACILITY_ISSUE_ID"] as? String,
                    let sameFacilityIssueCaseNumber = element["SAME_FACILITY_ISSUE_CASE_NUMBER"] as? String,
                    let facilityIssueReportDatetime = element["FACILITY_ISSUE_REPORT_DATETIME"] as? String,
                    let facilityIssueStatus = element["FACILITY_ISSUE_STATUS"] as? String,
                    let instructorIdNumber = element["INSTRUCTOR_ID_NUMBER"] as? String,
                    let studentIdNumber = element["STUDENT_ID_NUMBER"] as? String,
                    let facilityId = element["FACILITY_ID"] as? String,
                    let facilityName = element["FACILITY_NAME"] as? String,
                    let facilityTypeName = element["FACILITY_TYPE_NAME"] as? String,
                    let facilityComponentTypeId1 = element["FACILITY_COMPONENT_TYPE_ID_1"] as? String,
                    let facilityComponentTypeName1 = element["FACILITY_COMPONENT_TYPE_NAME_1"] as? String,
                    let facilityComponentIssueReport1 = element["FACILITY_COMPONENT_ISSUE_REPORT_1"] as? String,
                    let facilityComponentIssueStatus1 = element["FACILITY_COMPONENT_ISSUE_STATUS_1"] as? String,
                    let facilityComponentIssue_picture1 = element["FACILITY_COMPONENT_ISSUE_PICTURE_1"] as? String,
                    let facilityIssueResolverIdNumber1 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_1"] as? String,
                    let facilityIssueResolvedDatetime1 = element["FACILITY_ISSUE_RESOLVED_DATETIME_1"] as? String,
                    let facilityIssueResolversNote1 = element["FACILITY_ISSUE_RESOLVERS_NOTE_1"] as? String,
                    let facilityComponentTypeId2 = element["FACILITY_COMPONENT_TYPE_ID_2"] as? String,
                    let facilityComponentTypeName2 = element["FACILITY_COMPONENT_TYPE_NAME_2"] as? String,
                    let facilityComponentIssueReport2 = element["FACILITY_COMPONENT_ISSUE_REPORT_2"] as? String,
                    let facilityComponentIssueStatus2 = element["FACILITY_COMPONENT_ISSUE_STATUS_2"] as? String,
                    let facilityComponentIssue_picture2 = element["FACILITY_COMPONENT_ISSUE_PICTURE_2"] as? String,
                    let facilityIssueResolverIdNumber2 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_2"] as? String,
                    let facilityIssueResolvedDatetime2 = element["FACILITY_ISSUE_RESOLVED_DATETIME_2"] as? String,
                    let facilityIssueResolversNote2 = element["FACILITY_ISSUE_RESOLVERS_NOTE_2"] as? String,
                    let facilityComponentTypeId3 = element["FACILITY_COMPONENT_TYPE_ID_3"] as? String,
                    let facilityComponentTypeName3 = element["FACILITY_COMPONENT_TYPE_NAME_3"] as? String,
                    let facilityComponentIssueReport3 = element["FACILITY_COMPONENT_ISSUE_REPORT_3"] as? String,
                    let facilityComponentIssueStatus3 = element["FACILITY_COMPONENT_ISSUE_STATUS_3"] as? String,
                    let facilityComponentIssue_picture3 = element["FACILITY_COMPONENT_ISSUE_PICTURE_3"] as? String,
                    let facilityIssueResolverIdNumber3 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_3"] as? String,
                    let facilityIssueResolvedDatetime3 = element["FACILITY_ISSUE_RESOLVED_DATETIME_3"] as? String,
                    let facilityIssueResolversNote3 = element["FACILITY_ISSUE_RESOLVERS_NOTE_3"] as? String,
                    let facilityComponentTypeId4 = element["FACILITY_COMPONENT_TYPE_ID_4"] as? String,
                    let facilityComponentTypeName4 = element["FACILITY_COMPONENT_TYPE_NAME_4"] as? String,
                    let facilityComponentIssueReport4 = element["FACILITY_COMPONENT_ISSUE_REPORT_4"] as? String,
                    let facilityComponentIssueStatus4 = element["FACILITY_COMPONENT_ISSUE_STATUS_4"] as? String,
                    let facilityComponentIssue_picture4 = element["FACILITY_COMPONENT_ISSUE_PICTURE_4"] as? String,
                    let facilityIssueResolverIdNumber4 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_4"] as? String,
                    let facilityIssueResolvedDatetime4 = element["FACILITY_ISSUE_RESOLVED_DATETIME_4"] as? String,
                    let facilityIssueResolversNote4 = element["FACILITY_ISSUE_RESOLVERS_NOTE_4"] as? String,
                    let facilityComponentTypeId5 = element["FACILITY_COMPONENT_TYPE_ID_5"] as? String,
                    let facilityComponentTypeName5 = element["FACILITY_COMPONENT_TYPE_NAME_5"] as? String,
                    let facilityComponentIssueReport5 = element["FACILITY_COMPONENT_ISSUE_REPORT_5"] as? String,
                    let facilityComponentIssueStatus5 = element["FACILITY_COMPONENT_ISSUE_STATUS_5"] as? String,
                    let facilityComponentIssue_picture5 = element["FACILITY_COMPONENT_ISSUE_PICTURE_5"] as? String,
                    let facilityIssueResolverIdNumber5 = element["FACILITY_ISSUE_RESOLVER_ID_NUMBER_5"] as? String,
                    let facilityIssueResolvedDatetime5 = element["FACILITY_ISSUE_RESOLVED_DATETIME_5"] as? String,
                    let facilityIssueResolversNote5 = element["FACILITY_ISSUE_RESOLVERS_NOTE_5"] as? String
                    else{
                        print(TAG + "Parsing JSON error!")
                        return
                }
                
                let issue = Issue(
                    facilityIssueId: facilityIssueId,
                    facilityIssueCaseNumber: facilityIssueCaseNumber,
                    sameFacilityIssueId: sameFacilityIssueId,
                    sameFacilityIssueCaseNumber: sameFacilityIssueCaseNumber,
                    facilityIssueReportDatetime: facilityIssueReportDatetime,
                    facilityIssueStatus: facilityIssueStatus,
                    instructorIdNumber: instructorIdNumber,
                    studentIdNumber: studentIdNumber,
                    facilityId: facilityId,
                    facilityName: facilityName,
                    facilityTypeName: facilityTypeName,
                    facilityComponentTypeId1: facilityComponentTypeId1,
                    facilityComponentTypeName1: facilityComponentTypeName1,
                    facilityComponentIssueReport1: facilityComponentIssueReport1,
                    facilityComponentIssueStatus1: facilityComponentIssueStatus1,
                    facilityComponentIssue_picture1: facilityComponentIssue_picture1,
                    facilityIssueResolverIdNumber1: facilityIssueResolverIdNumber1,
                    facilityIssueResolvedDatetime1: facilityIssueResolvedDatetime1,
                    facilityIssueResolversNote1: facilityIssueResolversNote1,
                    facilityComponentTypeId2: facilityComponentTypeId2,
                    facilityComponentTypeName2: facilityComponentTypeName2,
                    facilityComponentIssueReport2: facilityComponentIssueReport2,
                    facilityComponentIssueStatus2: facilityComponentIssueStatus2,
                    facilityComponentIssue_picture2: facilityComponentIssue_picture2,
                    facilityIssueResolverIdNumber2: facilityIssueResolverIdNumber2,
                    facilityIssueResolvedDatetime2: facilityIssueResolvedDatetime2,
                    facilityIssueResolversNote2: facilityIssueResolversNote2,
                    facilityComponentTypeId3: facilityComponentTypeId3,
                    facilityComponentTypeName3: facilityComponentTypeName3,
                    facilityComponentIssueReport3: facilityComponentIssueReport3,
                    facilityComponentIssueStatus3: facilityComponentIssueStatus3,
                    facilityComponentIssue_picture3: facilityComponentIssue_picture3,
                    facilityIssueResolverIdNumber3: facilityIssueResolverIdNumber3,
                    facilityIssueResolvedDatetime3: facilityIssueResolvedDatetime3,
                    facilityIssueResolversNote3: facilityIssueResolversNote3,
                    facilityComponentTypeId4: facilityComponentTypeId4,
                    facilityComponentTypeName4: facilityComponentTypeName4,
                    facilityComponentIssueReport4: facilityComponentIssueReport4,
                    facilityComponentIssueStatus4: facilityComponentIssueStatus4,
                    facilityComponentIssue_picture4: facilityComponentIssue_picture4,
                    facilityIssueResolverIdNumber4: facilityIssueResolverIdNumber4,
                    facilityIssueResolvedDatetime4: facilityIssueResolvedDatetime4,
                    facilityIssueResolversNote4: facilityIssueResolversNote4,
                    facilityComponentTypeId5: facilityComponentTypeId5,
                    facilityComponentTypeName5: facilityComponentTypeName5,
                    facilityComponentIssueReport5: facilityComponentIssueReport5,
                    facilityComponentIssueStatus5: facilityComponentIssueStatus5,
                    facilityComponentIssue_picture5: facilityComponentIssue_picture5,
                    facilityIssueResolverIdNumber5: facilityIssueResolverIdNumber5,
                    facilityIssueResolvedDatetime5: facilityIssueResolvedDatetime5,
                    facilityIssueResolversNote5: facilityIssueResolversNote5
                )
                listIssue.append(issue)
            }
            
            callback(listIssue)
        }
    }
    // ============================
    
    
    // ============================
    static func updateIssue(issue: Issue, callback: @escaping (_ data: Any) -> Void){
        
        let TAG = "func -> updateIssue: "
        
        let post = PostParameter()
        post.add(key: "FACILITY_ISSUE_ID", value: issue.facilityIssueId!)
        post.add(key: "FACILITY_ISSUE_CASE_NUMBER", value: issue.facilityIssueCaseNumber!)
        post.add(key: "SAME_FACILITY_ISSUE_ID", value: issue.sameFacilityIssueId!)
        post.add(key: "SAME_FACILITY_ISSUE_CASE_NUMBER", value: issue.sameFacilityIssueCaseNumber!)
        post.add(key: "FACILITY_ISSUE_REPORT_DATETIME", value: issue.facilityIssueReportDatetime!)
        post.add(key: "FACILITY_ISSUE_STATUS", value: issue.facilityIssueStatus!)
        post.add(key: "INSTRUCTOR_ID_NUMBER", value: issue.instructorIdNumber!)
        post.add(key: "STUDENT_ID_NUMBER", value: issue.studentIdNumber!)
        post.add(key: "FACILITY_ID", value: issue.facilityId!)
        post.add(key: "FACILITY_NAME", value: issue.facilityName!)
        post.add(key: "FACILITY_TYPE_NAME", value: issue.facilityTypeName!)
        post.add(key: "FACILITY_COMPONENT_TYPE_ID_1", value: issue.facilityComponentTypeId1!)
        post.add(key: "FACILITY_COMPONENT_TYPE_NAME_1", value: issue.facilityComponentTypeName1!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_REPORT_1", value: issue.facilityComponentIssueReport1!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_STATUS_1", value: issue.facilityComponentIssueStatus1!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_PICTURE_1", value: issue.facilityComponentIssue_picture1!)
        post.add(key: "FACILITY_ISSUE_RESOLVER_ID_NUMBER_1", value: issue.facilityIssueResolverIdNumber1!)
        post.add(key: "FACILITY_ISSUE_RESOLVED_DATETIME_1", value: issue.facilityIssueResolvedDatetime1!)
        post.add(key: "FACILITY_ISSUE_RESOLVERS_NOTE_1", value: issue.facilityIssueResolversNote1!)
        post.add(key: "FACILITY_COMPONENT_TYPE_ID_2", value: issue.facilityComponentTypeId2!)
        post.add(key: "FACILITY_COMPONENT_TYPE_NAME_2", value: issue.facilityComponentTypeName2!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_REPORT_2", value: issue.facilityComponentIssueReport2!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_STATUS_2", value: issue.facilityComponentIssueStatus2!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_PICTURE_2", value: issue.facilityComponentIssue_picture2!)
        post.add(key: "FACILITY_ISSUE_RESOLVER_ID_NUMBER_2", value: issue.facilityIssueResolverIdNumber2!)
        post.add(key: "FACILITY_ISSUE_RESOLVED_DATETIME_2", value: issue.facilityIssueResolvedDatetime2!)
        post.add(key: "FACILITY_ISSUE_RESOLVERS_NOTE_2", value: issue.facilityIssueResolversNote2!)
        post.add(key: "FACILITY_COMPONENT_TYPE_ID_3", value: issue.facilityComponentTypeId3!)
        post.add(key: "FACILITY_COMPONENT_TYPE_NAME_3", value: issue.facilityComponentTypeName3!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_REPORT_3", value: issue.facilityComponentIssueReport3!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_STATUS_3", value: issue.facilityComponentIssueStatus3!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_PICTURE_3", value: issue.facilityComponentIssue_picture3!)
        post.add(key: "FACILITY_ISSUE_RESOLVER_ID_NUMBER_3", value: issue.facilityIssueResolverIdNumber3!)
        post.add(key: "FACILITY_ISSUE_RESOLVED_DATETIME_3", value: issue.facilityIssueResolvedDatetime3!)
        post.add(key: "FACILITY_ISSUE_RESOLVERS_NOTE_3", value: issue.facilityIssueResolversNote3!)
        post.add(key: "FACILITY_COMPONENT_TYPE_ID_4", value: issue.facilityComponentTypeId4!)
        post.add(key: "FACILITY_COMPONENT_TYPE_NAME_4", value: issue.facilityComponentTypeName4!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_REPORT_4", value: issue.facilityComponentIssueReport4!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_STATUS_4", value: issue.facilityComponentIssueStatus4!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_PICTURE_4", value: issue.facilityComponentIssue_picture4!)
        post.add(key: "FACILITY_ISSUE_RESOLVER_ID_NUMBER_4", value: issue.facilityIssueResolverIdNumber4!)
        post.add(key: "FACILITY_ISSUE_RESOLVED_DATETIME_4", value: issue.facilityIssueResolvedDatetime4!)
        post.add(key: "FACILITY_ISSUE_RESOLVERS_NOTE_4", value: issue.facilityIssueResolversNote4!)
        post.add(key: "FACILITY_COMPONENT_TYPE_ID_5", value: issue.facilityComponentTypeId5!)
        post.add(key: "FACILITY_COMPONENT_TYPE_NAME_5", value: issue.facilityComponentTypeName5!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_REPORT_5", value: issue.facilityComponentIssueReport5!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_STATUS_5", value: issue.facilityComponentIssueStatus5!)
        post.add(key: "FACILITY_COMPONENT_ISSUE_PICTURE_5", value: issue.facilityComponentIssue_picture5!)
        post.add(key: "FACILITY_ISSUE_RESOLVER_ID_NUMBER_5", value: issue.facilityIssueResolverIdNumber5!)
        post.add(key: "FACILITY_ISSUE_RESOLVED_DATETIME_5", value: issue.facilityIssueResolvedDatetime5!)
        post.add(key: "FACILITY_ISSUE_RESOLVERS_NOTE_5", value: issue.facilityIssueResolversNote5!)
        
        
        FirServices.dataTask(url: Constants.URL.API_UPDATE_FACILITY_ISSUE, post: post){
            (json, error) in
            
            guard let table = json["Table"] as? [[String: Any]], error == nil else{
                print(TAG)
                print(error!)
                callback(false)
                return
            }
            
            print(table)
            
            callback("Chua hoan thien")
        }
    }
    // ============================
}
