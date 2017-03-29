//
//  FacilityIssue.swift
//  mFIR
//  Created by Pham thi nguyet hue on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityIssueData{
    // var listFacilityData: Array<FacilityData> = Array()
    let context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    func saveFacilityIssue( facilityIssueData: Issue){
        var results : NSArray?
        let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_ISSUE, in: context)
        
        let facilityIssue = NSManagedObject(entity: entity!, insertInto: context)
        
        facilityIssue.setValue(facilityIssueData.facilityIssueId, forKey: Databases.FACILITY_ISSUE_ID)
        facilityIssue.setValue(facilityIssueData.facilityIssueCaseNumber, forKey: Databases.FACILITY_ISSUE_CASE_NUMBER)
        facilityIssue.setValue(facilityIssueData.sameFacilityIssueId, forKey: Databases.SAME_FACILITY_ISSUE_ID)
        facilityIssue.setValue(facilityIssueData.sameFacilityIssueCaseNumber, forKey: Databases.SAME_FACILITY_ISSUE_CASE_NUMBER)
        facilityIssue.setValue(facilityIssueData.facilityIssueReportDatetime, forKey: Databases.FACILITY_ISSUE_REPORT_DATETIME)
        facilityIssue.setValue(facilityIssueData.facilityIssueStatus, forKey: Databases.FACILITY_ISSUE_STATUS)
        facilityIssue.setValue(facilityIssueData.instructorIdNumber, forKey: Databases.INSTRUCTOR_ID_NUMBER)
        facilityIssue.setValue(facilityIssueData.studentIdNumber, forKey: Databases.STUDENT_ID_NUMBER)
        facilityIssue.setValue(facilityIssueData.facilityId,forKey: Databases.FACILITY_ID)
        facilityIssue.setValue(facilityIssueData.facilityName, forKey: Databases.FACILITY_NAME)
        facilityIssue.setValue(facilityIssueData.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeId1, forKey: Databases.FACILITY_COMPONENT_TYPE_ID_1)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeName1, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_1)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueReport1, forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_1)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueStatus1, forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_1)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssue_picture1, forKey: Databases.IMAGE_1)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolverIdNumber1, forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_1)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolvedDatetime1, forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_1)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolversNote1, forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_1)
        
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeId2, forKey: Databases.FACILITY_COMPONENT_TYPE_ID_2)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeName2, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_2)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueReport2, forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_2)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueStatus2, forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_2)
        facilityIssue.setValue (facilityIssueData.facilityComponentIssue_picture2, forKey: Databases.IMAGE_2)
        facilityIssue.setValue (facilityIssueData.facilityIssueResolverIdNumber2, forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_2)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolvedDatetime2, forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_2)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolversNote2, forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_2)
        
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeId3, forKey: Databases.FACILITY_COMPONENT_TYPE_ID_3)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeName3, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_3)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueReport3, forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_3)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueStatus3, forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_3)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssue_picture3, forKey: Databases.IMAGE_3)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolverIdNumber3, forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_3)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolvedDatetime3, forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_3)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolversNote3, forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_3)
        
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeId4, forKey: Databases.FACILITY_COMPONENT_TYPE_ID_4)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeName4, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_4)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueReport4, forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_4)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueStatus4, forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_4)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssue_picture4, forKey: Databases.IMAGE_4)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolverIdNumber4, forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_4)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolvedDatetime4, forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_4)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolversNote4, forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_4)

        facilityIssue.setValue(facilityIssueData.facilityComponentTypeId5, forKey: Databases.FACILITY_COMPONENT_TYPE_ID_5)
        facilityIssue.setValue(facilityIssueData.facilityComponentTypeName5, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_5)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueReport5, forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_5)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssueStatus5, forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_5)
        facilityIssue.setValue(facilityIssueData.facilityComponentIssue_picture5, forKey: Databases.IMAGE_5)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolverIdNumber5, forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_5)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolvedDatetime5, forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_5)
        facilityIssue.setValue(facilityIssueData.facilityIssueResolversNote5, forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_5)
        do {
            try context.save()
            print("insert issue thanh cong!")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY_ISSUE)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }
        
    }
      //INSERT ALL
    func saveAllIssue( listIssueData: Array<Issue> = Array()){
        let length = listIssueData.count
        for i in 0 ..< length {
            var issue: Issue
            issue = listIssueData[i]
            let issueinsert = FacilityIssueData(context: getContext())
            issueinsert.saveFacilityIssue(facilityIssueData: issue)
        }
    }
  
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let test = appDelegate.persistentContainer.viewContext
        
        return test
    }

    func getDataIssue () ->[Issue]{
        var list : [Issue] = []
       
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_ISSUE)
        
        do {
            //go get the results
            let searchResults = try context.fetch(fetchRequest)
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as! [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
               let issue = Issue(facilityIssueId: (trans.value(forKey: Databases.FACILITY_ISSUE_ID)! as! String),
                                 facilityIssueCaseNumber: (trans.value(forKey: Databases.FACILITY_ISSUE_CASE_NUMBER)! as! String),
                                 sameFacilityIssueId: (trans.value(forKey: Databases.SAME_FACILITY_ISSUE_ID)! as! String),
                                 sameFacilityIssueCaseNumber: (trans.value(forKey: Databases.SAME_FACILITY_ISSUE_CASE_NUMBER)! as! String),
                                 facilityIssueReportDatetime: (trans.value(forKey: Databases.FACILITY_ISSUE_REPORT_DATETIME)! as! String),
                                 facilityIssueStatus: (trans.value(forKey: Databases.FACILITY_ISSUE_STATUS)! as! String),
                                 instructorIdNumber: (trans.value(forKey: Databases.INSTRUCTOR_ID_NUMBER)! as! String),
                                 studentIdNumber: (trans.value(forKey: Databases.STUDENT_ID_NUMBER)! as! String),
                                 facilityId: (trans.value(forKey: Databases.FACILITY_ID)! as! String),
                                 facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String),
                                 facilityTypeName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String),
                                 facilityComponentTypeId1:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_1)! as! String),
                                 facilityComponentTypeName1: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_1)! as! String),
                                 facilityComponentIssueReport1: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_1)! as! String),
                                 facilityComponentIssueStatus1: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_1)! as! String),
                                 facilityComponentIssue_picture1: (trans.value(forKey: Databases.IMAGE_1)! as! String),
                                 facilityIssueResolverIdNumber1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_1)! as! String),
                                 facilityIssueResolvedDatetime1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_1)! as! String),
                                 facilityIssueResolversNote1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_1)! as! String),
                                 
                                 
                                 facilityComponentTypeId2:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_2)! as! String),
                                 facilityComponentTypeName2: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_2)! as! String),
                                 facilityComponentIssueReport2: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_2)! as! String),
                                 facilityComponentIssueStatus2: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_2)! as! String),
                                 facilityComponentIssue_picture2: (trans.value(forKey: Databases.IMAGE_2)! as! String),
                                 facilityIssueResolverIdNumber2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_2)! as! String),
                                 facilityIssueResolvedDatetime2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_2)! as! String),
                                 facilityIssueResolversNote2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_2)! as! String),
                                 
                                 facilityComponentTypeId3:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_3)! as! String),
                                 facilityComponentTypeName3: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_3)! as! String),
                                 facilityComponentIssueReport3: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_3)! as! String),
                                 facilityComponentIssueStatus3: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_3)! as! String),
                                 facilityComponentIssue_picture3: (trans.value(forKey: Databases.IMAGE_3)! as! String),
                                 facilityIssueResolverIdNumber3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_3)! as! String),
                                 facilityIssueResolvedDatetime3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_3)! as! String),
                                 facilityIssueResolversNote3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_1)! as! String),
                                 
                                 facilityComponentTypeId4:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_4)! as! String),
                                 facilityComponentTypeName4: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_4)! as! String),
                                 facilityComponentIssueReport4: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_4)! as! String),
                                 facilityComponentIssueStatus4: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_4)! as! String),
                                 facilityComponentIssue_picture4: (trans.value(forKey: Databases.IMAGE_4)! as! String),
                                 facilityIssueResolverIdNumber4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_4)! as! String),
                                 facilityIssueResolvedDatetime4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_4)! as! String),
                                 facilityIssueResolversNote4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_4)! as! String),
                                 
                                 facilityComponentTypeId5:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_5)! as! String),
                                 facilityComponentTypeName5: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_5)! as! String),
                                 facilityComponentIssueReport5: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_5)! as! String),
                                 facilityComponentIssueStatus5: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_5)! as! String),
                                 facilityComponentIssue_picture5: (trans.value(forKey: Databases.IMAGE_5)! as! String),
                                 facilityIssueResolverIdNumber5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_5)! as! String),
                                 facilityIssueResolvedDatetime5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_5)! as! String),
                                 facilityIssueResolversNote5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_5)! as! String))
                                 list.append(issue)
            }
            
        } catch {
            print("Error with request: \(error)")
        }
        print("Chieu dai list: \(list.count)")
        return list
    }
        func getByIdIssue (facilityIssueId : String) ->(Issue?) {
        var issue:Issue? = nil
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
        fetchRequest.predicate = NSPredicate(format: "facilityIssueId == %@", facilityIssueId)
              do {
            //go get the results
            let searchResults = try context.fetch(fetchRequest)
            //I like to check the size of the returned results!
            //print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    //get the Key Value pairs (although there may be a better way to do that...
                     issue = Issue(facilityIssueId: (trans.value(forKey: Databases.FACILITY_ISSUE_ID)! as! String),
                                      facilityIssueCaseNumber: (trans.value(forKey: Databases.FACILITY_ISSUE_CASE_NUMBER)! as! String),
                                      sameFacilityIssueId: (trans.value(forKey: Databases.SAME_FACILITY_ISSUE_ID)! as! String),
                                      sameFacilityIssueCaseNumber: (trans.value(forKey: Databases.SAME_FACILITY_ISSUE_CASE_NUMBER)! as! String),
                                      facilityIssueReportDatetime: (trans.value(forKey: Databases.FACILITY_ISSUE_REPORT_DATETIME)! as! String),
                                      facilityIssueStatus: (trans.value(forKey: Databases.FACILITY_ISSUE_STATUS)! as! String),
                                      instructorIdNumber: (trans.value(forKey: Databases.INSTRUCTOR_ID_NUMBER)! as! String),
                                      studentIdNumber: (trans.value(forKey: Databases.STUDENT_ID_NUMBER)! as! String),
                                      facilityId: (trans.value(forKey: Databases.FACILITY_ID)! as! String),
                                      facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String),
                                      facilityTypeName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String),
                                      facilityComponentTypeId1:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_1)! as! String),
                                      facilityComponentTypeName1: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_1)! as! String),
                                      facilityComponentIssueReport1: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_1)! as! String),
                                      facilityComponentIssueStatus1: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_1)! as! String),
                                      facilityComponentIssue_picture1: (trans.value(forKey: Databases.IMAGE_1)! as! String),
                                      facilityIssueResolverIdNumber1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_1)! as! String),
                                      facilityIssueResolvedDatetime1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_1)! as! String),
                                      facilityIssueResolversNote1: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_1)! as! String),
                                      
                                      
                                      facilityComponentTypeId2:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_2)! as! String),
                                      facilityComponentTypeName2: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_2)! as! String),
                                      facilityComponentIssueReport2: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_2)! as! String),
                                      facilityComponentIssueStatus2: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_2)! as! String),
                                      facilityComponentIssue_picture2: (trans.value(forKey: Databases.IMAGE_2)! as! String),
                                      facilityIssueResolverIdNumber2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_2)! as! String),
                                      facilityIssueResolvedDatetime2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_2)! as! String),
                                      facilityIssueResolversNote2: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_2)! as! String),
                                      
                                      facilityComponentTypeId3:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_3)! as! String),
                                      facilityComponentTypeName3: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_3)! as! String),
                                      facilityComponentIssueReport3: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_3)! as! String),
                                      facilityComponentIssueStatus3: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_3)! as! String),
                                      facilityComponentIssue_picture3: (trans.value(forKey: Databases.IMAGE_3)! as! String),
                                      facilityIssueResolverIdNumber3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_3)! as! String),
                                      facilityIssueResolvedDatetime3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_3)! as! String),
                                      facilityIssueResolversNote3: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_1)! as! String),
                                      
                                      facilityComponentTypeId4:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_4)! as! String),
                                      facilityComponentTypeName4: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_4)! as! String),
                                      facilityComponentIssueReport4: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_4)! as! String),
                                      facilityComponentIssueStatus4: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_4)! as! String),
                                      facilityComponentIssue_picture4: (trans.value(forKey: Databases.IMAGE_4)! as! String),
                                      facilityIssueResolverIdNumber4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_4)! as! String),
                                      facilityIssueResolvedDatetime4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_4)! as! String),
                                      facilityIssueResolversNote4: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_4)! as! String),
                                      
                                      facilityComponentTypeId5:(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID_5)! as! String),
                                      facilityComponentTypeName5: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME_5)! as! String),
                                      facilityComponentIssueReport5: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_REPORT_5)! as! String),
                                      facilityComponentIssueStatus5: (trans.value(forKey: Databases.FACILITY_COMPONENT_ISSUE_STATUS_5)! as! String),
                                      facilityComponentIssue_picture5: (trans.value(forKey: Databases.IMAGE_5)! as! String),
                                      facilityIssueResolverIdNumber5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVER_ID_NUMBER_5)! as! String),
                                      facilityIssueResolvedDatetime5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVED_DATETIME_5)! as! String),
                                      facilityIssueResolversNote5: (trans.value(forKey: Databases.FACILITY_ISSUE_RESOLVERS_NOTE_5)! as! String))
                   
                }
        } catch {
            print("Error with request: \(error)")
        }
        return issue
    }

    //DELETE RECORDS
    
    func deleteRecords() -> Void {
        let issue = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_ISSUE)
        
        let result = try? issue.fetch(fetchRequest)
        let resultData = result as! [FacilityIssueCoreData]
        
        for object in resultData {
            issue.delete(object)
        }
        
        do {
            try issue.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }


}
