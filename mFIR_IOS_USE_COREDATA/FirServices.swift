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
    
    func login(username: String, password: String, imei: String, callback: @escaping (Any, Bool) -> Void){
        
        objectInstance.login(viewController: self.viewController, username: username, password: password, imei: imei, callback: callback)
    }
    
    func getFacility(facilityId: String, callback: @escaping (Any) -> Void){
        
        objectInstance.getFacility(viewController: self.viewController, facilityId: facilityId, callback: callback)
    }
    
    func getIssue(facilityIssueId: String, fromDate: String, thruDate: String, callback: @escaping (Any) -> Void){
        objectInstance.getIssue(viewController: self.viewController, facilityIssueId: facilityIssueId, fromDate: fromDate, thruDate: thruDate, callback: callback)
    }
    
    func getComponentType(facilityComponentTypeId: String, callback: @escaping (Any) -> Void){
        objectInstance.getComponentType(viewController: self.viewController, facilityComponentTypeId: facilityComponentTypeId, callback: callback)
    }
    
    func getRelationship(facilityTypeId: String, facilityComponentTypeId: String, callback: @escaping (Any) -> Void){
        objectInstance.getRelationship(viewController: self.viewController, facilityTypeId: facilityTypeId, facilityComponentTypeId: facilityComponentTypeId, callback: callback)
    }
    
    func getFacilityType(facilityTypeId: String, callback: @escaping (Any) -> Void){
        objectInstance.getFacilityType(viewController: self.viewController, facilityTypeId: facilityTypeId, callback: callback)
    }
    
    func getInstructor(instructorIdNumber: String, callback: @escaping (Any) -> Void){
        objectInstance.getInstructor(viewController: self.viewController, instructorIdNumber: instructorIdNumber, callback: callback)
    }
    
    func getStudent(studentIdNumber: String, callback: @escaping (Any) -> Void){
        objectInstance.getStudent(viewController: self.viewController, studentIdNumber: studentIdNumber, callback: callback)
    }
    
    func getIssueStatus(callback: @escaping (Any) -> Void){
        objectInstance.getIssueStatus(viewController: self.viewController, callback: callback)
    }
    
    func getIssueByFacility(facilityId: String, callback: @escaping (Any) -> Void){
        objectInstance.getIssueByFacility(viewController: self.viewController, facilityId: facilityId, callback: callback)
    }
    
    
    func updateIssue(issue: Issue, callback: @escaping (Any, Bool) -> Void){
        objectInstance.updateIssue(viewController: self.viewController, issue: issue, callback: callback)
    }
    
}
