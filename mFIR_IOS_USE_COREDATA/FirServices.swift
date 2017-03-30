//
//  GetData.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Tống Thành Vinh on 3/28/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import UIKit

class FirServices{
    
    private let viewController:UIViewController
    
    private let objectInstance:ServicesInstance = ServicesInstance.getInstance()
    
    init(_ viewController:UIViewController){
        self.viewController = viewController
    }
    
    
    /// Kiểm tra đăng nhập
    ///
    /// - Parameters:
    ///   - username: tên đăng nhập
    ///   - password: mật khẩu
    ///   - imei: imei có thể để trống ("")
    ///   - callback: User hoặc nil
    func login(username: String, password: String, imei: String, callback: @escaping (_ user: User?) -> Void){
        
        objectInstance.login(viewController: self.viewController, username: username, password: password, imei: imei, callback: callback)
    }
    
    
    /// Lấy danh sách Cơ sở/Phòng (facility_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - facilityId: facilityId
    ///   - callback: Array[Facility] hoặc nil
    func getFacility(facilityId: String, callback: @escaping (_ arrayFacility: [Facility]?) -> Void){
        
        objectInstance.getFacility(viewController: self.viewController, facilityId: facilityId, callback: callback)
    }
    
    
    /// Lấy danh sách Issue (facility_issue_id=0: lấy tất cả - theo from_date/thru_date)
    ///
    /// - Parameters:
    ///   - facilityIssueId: facilityIssueId
    ///   - fromDate: fromDate
    ///   - thruDate: thruDate
    ///   - callback: [Issue] hoặc nil
    func getIssue(facilityIssueId: String, fromDate: String, thruDate: String, callback: @escaping (_ arrayIssue: [Issue]?) -> Void){
        objectInstance.getIssue(viewController: self.viewController, facilityIssueId: facilityIssueId, fromDate: fromDate, thruDate: thruDate, callback: callback)
    }
    
    
    /// Lấy danh sách Loại thiết bị (facility_component_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityComponentTypeId: facilityComponentTypeId
    ///   - callback: [ComponentType] hoặc nil
    func getComponentType(facilityComponentTypeId: String, callback: @escaping (_ arrayComponentType: [ComponentType]?) -> Void){
        objectInstance.getComponentType(viewController: self.viewController, facilityComponentTypeId: facilityComponentTypeId, callback: callback)
    }
    
    
    /// Lấy danh sách Quan hệ Loại Phòng-Loại thiết bị (facility_type_id=0: lấy tất cả, facility_component_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityTypeId: facilityTypeId
    ///   - facilityComponentTypeId: facilityComponentTypeId
    ///   - callback: [Relationship] hoặc nil
    func getRelationship(facilityTypeId: String, facilityComponentTypeId: String, callback: @escaping (_ arrayRelationship: [Relationship]?) -> Void){
        objectInstance.getRelationship(viewController: self.viewController, facilityTypeId: facilityTypeId, facilityComponentTypeId: facilityComponentTypeId, callback: callback)
    }
    
    
    /// Lấy danh sách Loại Phòng (facility_type_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityTypeId: facilityTypeId
    ///   - callback: [FacilityType] hoặc nil
    func getFacilityType(facilityTypeId: String, callback: @escaping (_ arrayFacilityType: [FacilityType]?) -> Void){
        objectInstance.getFacilityType(viewController: self.viewController, facilityTypeId: facilityTypeId, callback: callback)
    }
    
    
    /// Lấy danh sách Giảng viên (instructor_id_number='': lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - instructorIdNumber: instructorIdNumber
    ///   - callback: [Instructor] hoặc nil
    func getInstructor(instructorIdNumber: String, callback: @escaping (_ arrayInstructor: [Instructor]?) -> Void){
        objectInstance.getInstructor(viewController: self.viewController, instructorIdNumber: instructorIdNumber, callback: callback)
    }
    
    
    /// Lấy danh sách Sinh viên (student_id_number='': lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - studentIdNumber: studentIdNumber
    ///   - callback: [Student] hoặc nil
    func getStudent(studentIdNumber: String, callback: @escaping (_ arrayStudent: [Student]?) -> Void){
        objectInstance.getStudent(viewController: self.viewController, studentIdNumber: studentIdNumber, callback: callback)
    }
    
    
    /// Lấy danh sách trạng thái Facility Issue
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - callback: [IssueStatus] hoặc nil
    func getIssueStatus(callback: @escaping (_ arrayIssueStatus: [IssueStatus]?) -> Void){
        objectInstance.getIssueStatus(viewController: self.viewController, callback: callback)
    }
    
    
    /// Lấy danh sách Issue theo Facility (facility_id=0: lấy tất cả)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - facilityId: facilityId
    ///   - callback: [Issue] hoặc nil
    func getIssueByFacility(facilityId: String, callback: @escaping (_ arrayIssue: [Issue]?) -> Void){
        objectInstance.getIssueByFacility(viewController: self.viewController, facilityId: facilityId, callback: callback)
    }
    
    
    /// Cập nhật Issue (FACILITY_ISSUE_ID=0: insert)
    ///
    /// - Parameters:
    ///   - viewController: UIViewController
    ///   - issue: Issue
    ///   - callback: true hoặc false
    func updateIssue(issue: Issue, callback: @escaping (Bool) -> Void){
        objectInstance.updateIssue(viewController: self.viewController, issue: issue, callback: callback)
    }
    
}
