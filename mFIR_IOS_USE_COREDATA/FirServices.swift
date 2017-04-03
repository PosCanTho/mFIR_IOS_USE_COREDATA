//
//  FirServices.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/26/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import UIKit

/// Lấy dữ liệu từ WebService
class FirServices{
    
    private static var progressId:Int = 0
    private static var arrayProgress:[Int:Bool] = [:]
    private static var percentProgressDone:Float = 0.0
    private static var isLogin:Bool = false
    
    //    private static let instance:ServicesInstance = ServicesInstance() // singleton pattern
    //
    //    static func getInstance() -> ServicesInstance{
    //        return instance
    //    }
    
    
    /// Hiển thị phần trăm download
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - progressId: progress id
    ///   - completion: completion
    static func showProgressing(progressId: Int, completion: Bool){
        DispatchQueue.main.async {
            
            if(completion){
                var countProgressDone:Int = 0
                var isAllProgressComplete:Bool = true
                
                for (_ , value) in  FirServices.arrayProgress{
                    if(!value){
                        isAllProgressComplete = false
                    }else{
                        countProgressDone += 1
                    }
                }
                
                FirServices.percentProgressDone = (Float(countProgressDone)/Float(FirServices.arrayProgress.count))*100
                
                if(!FirServices.percentProgressDone.isNaN){
                    ProgressingDialog.setMessage(mes: "\(String(format: "%.0f",FirServices.percentProgressDone))%")
                }
                
                if(isAllProgressComplete || FirServices.arrayProgress.count == 0){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        ProgressingDialog.hide()
                    })
                    
                    FirServices.progressId = 0
                    FirServices.arrayProgress.removeAll()
                    FirServices.percentProgressDone = 0.0
                }
                
            }else{
                ProgressingDialog.show()
                if(!FirServices.isLogin){
                    ProgressingDialog.setMessage(mes: "Downloading...")
                }else{
                    FirServices.isLogin = false
                }
            }
        }
    }
    
    
    /// Tải dữ liệu từ webservices -> sử dụng async
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - url: url
    ///   - post: post with parameter
    ///   - callback: callback
    private static func dataTask(
        url: String,
        post: PostParameter,
        callback: @escaping (_ json: Dictionary<String, Any>) -> Void) {
        
        FirServices.progressId += 1
        
        let TAG = "func -> dataTask: "
        
        guard CheckInternet.isInternetAvailable() else {
            FirDialog.show(title: "Lỗi kết nối", mes: "Không có kết nối internet. Vui lòng kiểm tra lại internet!", buttonName: "Đóng")
            return
        }
        
        
        if(!post.isLogin()){
            let user = UserDefaults.standard
            guard let username = user.string(forKey: UserReferences.USERNAME), let password = user.string(forKey: UserReferences.PASSWORD) else{
                print("ServicesInstance: -> User is nil !!!")
                return
            }
            
            post.add(key: "username", value: username)
            post.add(key: "password", value: password)
        }
        
        let postString:String = post.getString()
        
        let urlRequest = URL(string: url)!
        var request = URLRequest(url: urlRequest, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120) // timeout 120 seconds
        
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        
        let inprogressId = FirServices.progressId
        
        FirServices.arrayProgress[inprogressId] = false
        
        showProgressing(progressId: inprogressId, completion: false)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil
                else {
                    FirServices.arrayProgress.removeAll()
                    FirServices.progressId = 0
                    FirServices.percentProgressDone = 0.0
                    FirServices.showProgressing( progressId: inprogressId, completion: true)
                    FirDialog.showErrorDownload(urlError: (error as! URLError?)!)
                    callback(Dictionary<String, AnyObject>())
                    print(error!)
                    return
            }
            
            FirServices.arrayProgress[inprogressId] = true
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print(TAG + "statusCode should be 200, but is \(httpStatus.statusCode)")
                print(TAG + "response = \(String(describing: response))")
                
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
                    FirServices.showProgressing(progressId: inprogressId, completion: true)
                    callback(json)
                }
                
            } catch {
                FirServices.showProgressing(progressId: inprogressId, completion: true)
                callback(Dictionary<String, AnyObject>())
                print(Constants.ERROR.PARSING_JSON)
            }
        }
        task.resume()
    }
    
    
    /// Kiểm tra đăng nhập
    ///
    /// - Parameters:
    ///   - username: tên đăng nhập
    ///   - password: mật khẩu
    ///   - imei: imei có thể để trống ("")
    ///   - callback: User hoặc nil
    static func login( username: String, password: String, imei: String, callback: @escaping (_ data: User?) -> Void){
        
        let TAG = "func -> login: "
        
        FirServices.isLogin = true
        
        let post = PostParameter()
        post.add(key: "username", value: username)
        post.add(key: "password", value: password)
        post.add(key: "imei", value: "")
        
        dataTask( url: Constants.URL.API_LOGIN, post: post){
            (json) in
            
            
            guard let table = json["Table"] as? [[String: Any]] else{
                let userReference = UserDefaults.standard
                userReference.removeObject(forKey: UserReferences.USERNAME)
                userReference.removeObject(forKey: UserReferences.PASSWORD)
                
                callback(nil)
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
    
    
    /// Lấy danh sách Cơ sở/Phòng (facility_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - facilityId: facilityId
    ///   - callback: Array[Facility] hoặc nil
    static func getFacility( facilityId: String, callback: @escaping (_ data: [Facility]?) -> Void){
        let TAG = "func -> facility: "
        
        let post = PostParameter()
        post.add(key: "facility_id", value: facilityId)
        
        var listFacility = [Facility]()
        
        dataTask( url: Constants.URL.API_GET_LIST_FACILITY, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                print(TAG)
                callback(nil)
                return
            }
            for element in table{
                
                guard let id = element["FACILITY_ID"] as? String,
                    let name = element["FACILITY_NAME"] as? String,
                    let typeName = element["FACILITY_TYPE_NAME"] as? String,
                    let usageStatus = element["FACILITY_USAGE_STATUS"] as? String,
                    let rootId = element["ROOT_FACILITY_ID"] as? String
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
    
    
    
    /// Lấy danh sách Issue (facility_issue_id=0: lấy tất cả - theo from_date/thru_date)
    ///
    /// - Parameters:
    ///   - facilityIssueId: facilityIssueId
    ///   - fromDate: fromDate
    ///   - thruDate: thruDate
    ///   - callback: [Issue] hoặc nil
    static func getIssue( facilityIssueId: String, fromDate: String, thruDate: String, callback: @escaping (_ data: [Issue]?) -> Void){
        
        let TAG = "func -> facilityIssue: "
        
        let post = PostParameter()
        post.add(key: "facility_issue_id", value: facilityIssueId)
        post.add(key: "from_date", value: fromDate)
        post.add(key: "thru_date", value: thruDate)
        
        var listIssue = [Issue]()
        
        dataTask( url: Constants.URL.API_GET_LIST_FACILITY_ISSUE, post: post){
            (json) in
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    
    /// Lấy danh sách Loại thiết bị (facility_component_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityComponentTypeId: facilityComponentTypeId
    ///   - callback: [ComponentType] hoặc nil
    static func getComponentType( facilityComponentTypeId: String, callback: @escaping (_ data: [ComponentType]?) -> Void){
        
        let TAG = "func -> componentType: "
        
        let post = PostParameter()
        post.add(key: "facility_component_type_id", value: facilityComponentTypeId)
        
        var listComponentType = [ComponentType]()
        
        dataTask( url: Constants.URL.API_GET_LIST_FACILITY_COMPONENT_TYPE, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    
    
    /// Lấy danh sách Quan hệ Loại Phòng-Loại thiết bị (facility_type_id=0: lấy tất cả, facility_component_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityTypeId: facilityTypeId
    ///   - facilityComponentTypeId: facilityComponentTypeId
    ///   - callback: [Relationship] hoặc nil
    static func getRelationship( facilityTypeId: String, facilityComponentTypeId: String, callback: @escaping (_ data: [Relationship]?) -> Void){
        
        let TAG = "func -> relationship: "
        
        let post = PostParameter()
        post.add(key: "facility_type_id", value: facilityTypeId)
        post.add(key: "facility_component_type_id", value: facilityComponentTypeId)
        
        var listRelationship = [Relationship]()
        
        dataTask( url: Constants.URL.API_GET_RELATIONSHIP, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    
    /// Lấy danh sách Loại Phòng (facility_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityTypeId: facilityTypeId
    ///   - callback: [FacilityType] hoặc nil
    static func getFacilityType( facilityTypeId: String, callback: @escaping (_ data: [FacilityType]?) -> Void){
        
        let TAG = "func -> facilityType: "
        
        let post = PostParameter()
        post.add(key: "facility_type_id", value: facilityTypeId)
        
        var listFacilityType = [FacilityType]()
        
        dataTask( url: Constants.URL.API_GET_LIST_FACILITY_TYPE, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    
    /// Lấy danh sách Giảng viên (instructor_id_number='': lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - instructorIdNumber: instructorIdNumber
    ///   - callback: [Instructor] hoặc nil
    static func getInstructor( instructorIdNumber: String, callback: @escaping (_ data: [Instructor]?) -> Void){
        
        let TAG = "func -> instructor: "
        
        let post = PostParameter()
        post.add(key: "instructor_id_number", value: instructorIdNumber)
        
        var listInstructor = [Instructor]()
        
        dataTask( url: Constants.URL.API_GET_LIST_INSTRUCTOR, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    
    /// Lấy danh sách Sinh viên (student_id_number='': lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - studentIdNumber: studentIdNumber
    ///   - callback: [Student] hoặc nil
    static func getStudent( studentIdNumber: String, callback: @escaping (_ data: [Student]?) -> Void){
        
        let TAG = "func -> student: "
        
        let post = PostParameter()
        post.add(key: "student_id_number", value: studentIdNumber)
        
        var listStudent = [Student]()
        
        dataTask( url: Constants.URL.API_GET_LIST_STUDENT, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    /// Lấy danh sách trạng thái Facility Issue
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - callback: [IssueStatus] hoặc nil
    static func getIssueStatus( callback: @escaping (_ data: [IssueStatus]?) -> Void){
        
        let TAG = "func -> issueStatus: "
        
        let post = PostParameter()
        
        var listIssueStatus = [IssueStatus]()
        
        dataTask( url: Constants.URL.API_GET_ISSUE_STATUS, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    /// Lấy danh sách Issue theo Facility (facility_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityId: facilityId
    ///   - callback: [Issue] hoặc nil
    static func getIssueByFacility( facilityId: String, callback: @escaping (_ data: [Issue]?) -> Void){
        
        let TAG = "func -> issueByFacility: "
        
        let post = PostParameter()
        post.add(key: "facility_id", value: facilityId)
        
        var listIssue = [Issue]()
        
        dataTask( url: Constants.URL.API_GET_ISSUE_BY_FACILITY, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(nil)
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
    
    
    /// Cập nhật Issue (FACILITY_ISSUE_ID=0: insert)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - issue: Issue
    ///   - callback: true hoặc false
    static func updateIssue( issue: Issue, callback: @escaping (_ completion: Bool) -> Void){
        
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
        
        
        dataTask( url: Constants.URL.API_UPDATE_FACILITY_ISSUE, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(false)
                return
            }
            
            guard let result = table[0]["result"] as? String else{
                print("UpdateIssue: " + "Parsing JSON error!")
                return
            }
            
            print("UpdateIssue: ",result)
            
            callback(true)
        }
    }
    
    
    // ============================
    /// registerFCMToken
    ///
    /// - Parameters:
    ///   - imei: imei
    ///   - typeOS: typeOS
    ///   - tokenKey: tokenKey
    ///   - callback: Bool
    static func registerFCMToken(imei:String, typeOS:String, tokenKey:String ,callback: @escaping (_ completion: Bool) -> Void){
        
        let post = PostParameter()
        post.add(key: "IMEI", value: imei)
        post.add(key: "OS_TYPE", value: typeOS)
        post.add(key: "TOKEN_KEY", value: tokenKey)
        
        dataTask( url: Constants.URL.API_GET_REGISTER_FCMTOKEN, post: post){
            (json) in
            
            guard let table = json["Table"] as? [[String: Any]] else{
                callback(false)
                return
            }
            
            print(table)
            
            callback(true)
        }
    }
    
    
    
    /// task down and upload image server
    ///
    /// - Parameters:
    ///   - url: url
    ///   - post: post
    ///   - callback: String?
    private static func taskFileImage(
        url: String,
        post: String,
        callback: @escaping (_ result: String?) -> Void) {
        
        guard CheckInternet.isInternetAvailable() else {
            FirDialog.show(title: "Lỗi kết nối", mes: "Không có kết nối internet. Vui lòng kiểm tra lại internet!", buttonName: "Đóng")
            return
        }
        
        let urlRequest = URL(string: url)!
        var request = URLRequest(url: urlRequest, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120) // timeout 120 seconds
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(String(post.characters.count), forHTTPHeaderField: "Content-Length")
        request.httpMethod = "POST"
        request.httpBody = post.data(using: .utf8, allowLossyConversion: false)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                    FirDialog.showErrorDownload(urlError: (error as! URLError?)!)
                    callback(nil)
                    print(error!)
                    return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print(Constants.ERROR.MES,"statusCode should be 200, but is \(httpStatus.statusCode)")
                print(Constants.ERROR.MES,"response = \(String(describing: response))")
                
            }
            
            guard let stringXML = String(data: data, encoding: String.Encoding.utf8) else{
                print(Constants.ERROR.MES,"stringXML")
                return
            }

            callback(stringXML)
        }
        task.resume()
        
    }
    
    
    
    /// Upload hình lên server
    ///
    /// - Parameters:
    ///   - fileName: fileName
    ///   - image: UIImage
    ///   - callback: Bool
    static func uploadFileImage(fileName: String, image: UIImage, callback: @escaping (_ completion: Bool) -> Void){
        
        guard fileName != "" else {
            print(Constants.ERROR.FILE_IMAGE_NAME)
            return
        }
        
        let fileName = fileName + ".jpg"
        
        guard let imageData:Data = UIImagePNGRepresentation(image) else {
            print(Constants.ERROR.FILE_IMAGE_DATA)
            return
            
        }
        
        let dataBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        print(dataBase64)
        
        var post = ""
        post += "<?xml version='1.0' encoding='utf-8'?>"
        post += "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
        post += "<soap12:Body>"
        post += "<UploadFileForFIR xmlns='http://tempuri.org/'>"
        post += "<f>\(dataBase64)</f>"
        post += "<fileName>\(fileName)</fileName>"
        post += "<key>\(Constants.URL.UPLOAD_IMAGE_KEY)</key>"
        post += "</UploadFileForFIR>"
        post += "</soap12:Body>"
        post += "</soap12:Envelope>"
        
        
        taskFileImage(url: Constants.URL.API_UPLOAD_FILE_IMAGE, post: post) { (result) in
            
            guard result != nil else{
                callback(false)
                return
            }
            
            let strAfterSub = result!.subString("<UploadFileForFIRResult>","</UploadFileForFIRResult>") ?? "Can not substring"
            
            if(strAfterSub != "OK"){
                print(strAfterSub)
                callback(false)
                return
            }
            
            callback(true)
        }
    }
    
    
    
    /// Tải hình từ server về
    ///
    /// - Parameters:
    ///   - fileName: fileName
    ///   - callback: UIImage?
    static func downloadFileImage(fileName: String, callback: @escaping (_ completion: UIImage?) -> Void){
        
        var post = ""
            post += "<?xml version='1.0' encoding='utf-8'?>"
            post += "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
            post += "<soap12:Body>"
            post += "<GetFileForFIR xmlns='http://tempuri.org/'>"
            post += "<fileName>\(fileName)</fileName>"
            post += "<key>\(Constants.URL.UPLOAD_IMAGE_KEY)</key>"
            post += "</GetFileForFIR>"
            post += "</soap12:Body>"
            post += "</soap12:Envelope>"
        
        guard fileName != "" else {
            print(Constants.ERROR.FILE_IMAGE_NAME)
            return
        }
        
        taskFileImage(url: Constants.URL.API_DOWNLOAD_FILE_IMAGE, post: post) { (result) in
            
            guard result != nil else{
                callback(nil)
                return
            }
            
            let strAfterSub = result!.subString("<GetFileForFIRResult>","</GetFileForFIRResult>") ?? "Can not substring"

            if(strAfterSub == "Can not substring"){
                print(strAfterSub)
                callback(nil)
                return
            }
            
            guard let dataDecoded : Data = Data(base64Encoded: strAfterSub, options: .ignoreUnknownCharacters) else {
                print(Constants.ERROR.MES,"Decode base64 to data for image")
                return
            }
            
            let decodedimage = UIImage(data: dataDecoded)
            
            callback(decodedimage)
        }
    }
    // ============================
    
    
}
