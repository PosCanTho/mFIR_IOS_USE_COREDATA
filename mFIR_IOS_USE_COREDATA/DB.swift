//
//  DB.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Nguyet Hue on 3/29/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DB {
    
    /// private get context
    private static let context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let con = appDelegate.persistentContainer.viewContext
        return con
    }()
    
    static func downloadToDB(){
        
        if(DB.FacilityComponentDB.checkFacilityComponentIsExist()){
            DB.FacilityComponentDB.deleteRecords()
        }
        
        if(DB.FacilityDB.checkFacilityIsExist()){
            DB.FacilityDB.deleteRecords()
        }
        
        if(DB.FacilityTypeDB.checkFacilityTypeIsExist()){
            DB.FacilityTypeDB.deleteRecords()
        }
        
        if(DB.IssueDB.checkFacilityRelationshipIsExist()){
            DB.IssueDB.deleteRecords()
        }
        
        if(DB.RelationshipDB.checkFacilityRelationshipIsExist()){
            DB.RelationshipDB.deleteRecords()
        }
        
        FirServices.getFacility(facilityId: "0") { (data) in
            guard data != nil else{
                return
            }
            DispatchQueue.main.async {
                DB.FacilityDB.saveAllFacility(listFacilityData: data!)
                print("Downloaded: FacilityDB -> \(DB.FacilityDB.getDataFacility().count)")
            }
        }
        
        FirServices.getComponentType(facilityComponentTypeId: "0") { (data) in
            guard data != nil else{
                return
            }
            DispatchQueue.main.async {
                DB.FacilityComponentDB.saveAllComponent(listComponentData: data!)
                print("Downloaded: FacilityComponentDB -> \(DB.FacilityComponentDB.getDataComponent().count)")
            }
        }
        
        FirServices.getFacilityType(facilityTypeId: "0") { (data) in
            guard data != nil else{
                return
            }
            DispatchQueue.main.async {
                DB.FacilityTypeDB.saveAllFacilityType(listFacilityTypeData: data!)
                print("Downloaded: FacilityTypeDB -> \(DB.FacilityTypeDB.getDataFacilityType().count)")
            }
        }
        
        FirServices.getIssue(facilityIssueId: "0", fromDate: "", thruDate: "") { (data) in
            guard data != nil else{
                return
            }
            DispatchQueue.main.async {
                DB.IssueDB.saveAllIssue(listIssueData: data!)
                print("Downloaded: IssueDB -> \(DB.IssueDB.getDataIssue().count)")
            }
        }
        
        FirServices.getRelationship(facilityTypeId: "0", facilityComponentTypeId: "0") { (data) in
            guard data != nil else{
                return
            }
            DispatchQueue.main.async {
                DB.RelationshipDB.saveAllRelationship(listRelationshipData: data!)
                print("Downloaded: RelationshipDB -> \(DB.RelationshipDB.getDataRelationship().count)")
            }
        }
        
    }
    
    /// Facility database
    class FacilityDB {
        
        static func saveFacility(facility: Facility){
            
            guard let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY, in: context) else {
                return
            }
            
            let facilityData = NSManagedObject(entity: entity, insertInto: context)
            
            facilityData.setValue(facility.facilityId, forKey: Databases.FACILITY_ID)
            facilityData.setValue(facility.facilityName, forKey: Databases.FACILITY_NAME)
            facilityData.setValue(facility.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
            facilityData.setValue(facility.facilityRootId, forKey: Databases.ROOT_FACILITY_ID)
            facilityData.setValue(facility.facilityUsageStatus, forKey: Databases.FACILITY_USAGE_STATUS)
            do {
                try context.save()
            }
            catch {
                print("Error!")
            }
            
        }
        
        static func saveAllFacility(listFacilityData: Array<Facility> = Array()){
            
            for facility in listFacilityData {
                saveFacility(facility: facility)
            }
        }
        
        static func getDataFacility ()->[Facility]{
            var list : [Facility] = []
            //create a fetch request, telling it about the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            // var facility : Facility? = nil
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //print ("num of results = \(searchResults.count)")
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    let facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    list.append(facility)
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        static func getByIdFacility (facilityId : String) ->(Facility?) {
            var facility:Facility? = nil
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_ID) == %@", facilityId)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    //get the Key Value pairs (although there may be a better way to do that...
                }
            } catch {
                print("Error with request: \(error)")
            }
            return facility
        }
        
        //DELETE RECORDS
        static func deleteRecords(){
            let facility = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            
            let result = try? facility.fetch(fetchRequest)
            let resultData = result as! [FacilityCoreData]
            
            for object in resultData {
                facility.delete(object)
            }
            do {
                try facility.save()
                print("Deleted table: -> \(Databases.TABLE_FACILITY)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
        // EDIT 29/03/2017
        static func  getFacilityWithoutFloor ()->[Facility]{
            var list : [Facility] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            fetchRequest.predicate = NSPredicate(format: " \(Databases.FACILITY_TYPE_NAME) IS NOT Tầng AND \(Databases.ROOT_FACILITY_ID) IS NOT ''")
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                for trans in searchResults as! [NSManagedObject] {
                    let facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    list.append(facility)
                }
            } catch {
                print("Error with request: \(error)")
            }
            print("Chieu dai list: \(list.count)")
            return list
        }
        
        //
        static func getFacilityByRootId ( rootFacilityId: String) ->[Facility]  {
            var list : [Facility] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.ROOT_FACILITY_ID) == %@", rootFacilityId)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                //print ("num of results = \(searchResults.count)")
                
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    let facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    list.append(facility)
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        //
        static func getFacilityByRootIdAndName ( rootFacilityId: String , facilityTypeName : String) ->[Facility]  {
            var list : [Facility] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.ROOT_FACILITY_ID) == %@ AND \(Databases.FACILITY_TYPE_NAME) == %@", rootFacilityId,facilityTypeName)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    let facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    list.append(facility)
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        //
        static func getFacilityGroupbyTypeName ( rootFacilityId: String) ->[Facility]  {
            var list : [Facility] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.ROOT_FACILITY_ID) == %@ GROUP BY \(Databases.FACILITY_TYPE_NAME)", rootFacilityId)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    let facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                    list.append(facility)
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        // check facility Is Exist
        static func checkFacilityIsExist() -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
            do{
                let searchResults = try context.fetch(fetchRequest)
                if searchResults.count > 0 {
                    return true
                }
                else {
                    return false
                }
            }catch{
                return false
            }
        }
    }
    
    /// Facility Component database
    class FacilityComponentDB{
        
        static func saveComponent(component :ComponentType){
            
            let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_COMPONENT_TYPE, in: context)
            let componentType76 = NSManagedObject(entity: entity!, insertInto: context)
            //set the entity values
            componentType76.setValue(component.componentTypeId, forKey:Databases.FACILITY_COMPONENT_TYPE_ID)
            componentType76.setValue(component.componentTypeName, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)
            componentType76.setValue(component.description, forKey: Databases.DESCRIPTION)
            
            //save the object
            do {
                try context.save()
            }
            catch {
                print("Error!")
            }
            
        }
        
        static func saveAllComponent(listComponentData: Array<ComponentType> = Array()){
            for component in listComponentData {
                saveComponent(component: component)
            }
        }
        
        static func getDataComponent ()->[ComponentType] {
            //create a fetch request, telling it about the entity
            var list : [ComponentType] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                // print ("num of results = \(searchResults.count)")
                for trans in searchResults as! [NSManagedObject] {
                    let component = ComponentType(componentTypeId: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID)! as! String), componentTypeName: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)! as! String), description: (trans.value(forKey: Databases.DESCRIPTION)! as! String))
                    list.append(component)
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        static func getByIdComponent ( facilityComponentTypeId: String) ->(ComponentType?)  {
            var component :ComponentType? = nil
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_COMPONENT_TYPE_ID) == %@", facilityComponentTypeId)
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                //print ("num of results = \(searchResults.count)")
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    component = ComponentType(componentTypeId: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID)! as! String), componentTypeName: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)! as! String), description: (trans.value(forKey: Databases.DESCRIPTION)! as! String))
                    
                }
            } catch {
                print("Error with request: \(error)")
            }
            return component
        }
        
        //DELETE RECORDS
        static func deleteRecords(){
            let component = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
            
            let result = try? component.fetch(fetchRequest)
            let resultData = result as! [FacilityComponentTypeCoreData]
            
            for object in resultData {
                component.delete(object)
            }
            
            do {
                try component.save()
                print("Deleted table: -> \(Databases.TABLE_FACILITY_COMPONENT_TYPE)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
        //EDIT 29/03/2017
        
        // check ComponentType Is Exist
        static func checkFacilityComponentIsExist() -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
            do{
                let searchResults = try context.fetch(fetchRequest)
                if searchResults.count > 0 {
                    return true
                }
                else {
                    return false
                }
            }catch{
                return false
            }
        }
        
    }
    
    /// Issue database
    class IssueDB{
        
        static func saveFacilityIssue( facilityIssueData: Issue){
            
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
            }
            catch {
                print("Error!")
            }
            
        }
        //INSERT ALL
        static func saveAllIssue( listIssueData: Array<Issue> = Array()){
            for issue in listIssueData {
                saveFacilityIssue(facilityIssueData: issue)
            }
        }
        
        static func getDataIssue () ->[Issue]{
            var list : [Issue] = []
            
            //create a fetch request, telling it about the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_ISSUE)
            
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                
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
            return list
        }
        
        static func getByIdIssue (facilityIssueId : String) ->(Issue?) {
            var issue:Issue? = nil
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_ISSUE_ID) == %@", facilityIssueId)
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
        
        static func deleteRecords() {
            let issue = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_ISSUE)
            
            let result = try? issue.fetch(fetchRequest)
            let resultData = result as! [FacilityIssueCoreData]
            
            for object in resultData {
                issue.delete(object)
            }
            
            do {
                try issue.save()
                print("Deleted table: -> \(Databases.TABLE_FACILITY_ISSUE)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
        //EDIT 29/03/2017
        
        // check issue Is Exist
        static func checkFacilityRelationshipIsExist() -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_ISSUE)
            do{
                let searchResults = try context.fetch(fetchRequest)
                if searchResults.count > 0 {
                    return true
                }
                else {
                    return false
                }
            }catch{
                return false
            }
        }
        
        
    }
    
    /// Relationship database
    class RelationshipDB{
        
        static func saveFacilityRelationship(facilityRelationshipData: Relationship){
            
            let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_RELATIONSHIP, in: context)
            let facilityRelationship = NSManagedObject(entity: entity!, insertInto: context)
            
            facilityRelationship.setValue(facilityRelationshipData.facilityTypeId, forKey: Databases.FACILITY_TYPE_ID)
            facilityRelationship.setValue(facilityRelationshipData.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
            facilityRelationship.setValue(facilityRelationshipData.facilityComponentTypeId, forKey: Databases.FACILITY_COMPONENT_TYPE_ID)
            facilityRelationship.setValue(facilityRelationshipData.facilityComponentTypeName, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)
            facilityRelationship.setValue(facilityRelationshipData.fromDate, forKey: Databases.FROM_DATE)
            facilityRelationship.setValue(facilityRelationshipData.thruDate, forKey: Databases.THRU_DATE)
            facilityRelationship.setValue(facilityRelationshipData.note, forKey: Databases.NOTE)
            
            do {
                try context.save()
            }
            catch {
                print("Error!")
            }
            
            
        }
        
        static func saveAllRelationship( listRelationshipData: Array<Relationship> = Array()){
            for relationship in listRelationshipData {
                saveFacilityRelationship(facilityRelationshipData: relationship)
            }
        }
        
        static func getDataRelationship ()->[Relationship] {
            //create a fetch request, telling it about the entity
            var list : [Relationship] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
            
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                // print ("num of results = \(searchResults.count)")
                for trans in searchResults as! [NSManagedObject] {
                    let relationship = Relationship(facilityTypeId: (trans.value(forKey: Databases.FACILITY_TYPE_ID)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityComponentTypeId: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID)! as! String), facilityComponentTypeName: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)! as! String), fromDate: (trans.value(forKey: Databases.FROM_DATE)! as! String), thruDate: (trans.value(forKey: Databases.THRU_DATE)! as! String), note: (trans.value(forKey: Databases.NOTE)! as! String))
                    list.append(relationship)
                }
            } catch {
                print("Error with request: \(error)")
            }
            
            return list
        }
        
        static func getByIdRelationship ( facilityTypeId: String) ->[Relationship]  {
            var list : [Relationship] = []
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_TYPE_ID) == %@", facilityTypeId)
            
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                //print ("num of results = \(searchResults.count)")
                
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    let relationship = Relationship(facilityTypeId: (trans.value(forKey: Databases.FACILITY_TYPE_ID)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityComponentTypeId: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID)! as! String), facilityComponentTypeName: (trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)! as! String), fromDate: (trans.value(forKey: Databases.FROM_DATE)! as! String), thruDate: (trans.value(forKey: Databases.THRU_DATE)! as! String), note: (trans.value(forKey: Databases.NOTE)! as! String))
                    list.append(relationship)
                    
                    
                }
            } catch {
                print("Error with request: \(error)")
            }
            return list
        }
        
        //delete
        static func deleteRecords() {
            let relationship = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
            
            let result = try? relationship.fetch(fetchRequest)
            let resultData = result as! [RelationshipCoreData]
            
            for object in resultData {
                relationship.delete(object)
            }
            
            do {
                try relationship.save()
                print("Deleted table: -> \(Databases.TABLE_FACILITY_RELATIONSHIP)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        
        //EDIT 29/03/2017
        
        // check Relationship Is Exist
        static func checkFacilityRelationshipIsExist() -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
            do{
                let searchResults = try context.fetch(fetchRequest)
                if searchResults.count > 0 {
                    return true
                }
                else {
                    return false
                }
            }catch{
                return false
            }
        }
        
    }
    
    /// Facility type database
    class FacilityTypeDB{
        
        //insert
        static func saveFacilityType(facilityTypeData:FacilityType){
            
            let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_TYPE, in: context)
            
            let facilityType = NSManagedObject(entity: entity!, insertInto: context)
            
            facilityType.setValue(facilityTypeData.facilityTypeId, forKey: Databases.FACILITY_TYPE_ID)
            facilityType.setValue(facilityTypeData.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
            facilityType.setValue(facilityTypeData.description, forKey: Databases.DESCRIPTION)
            do {
                try context.save()
            }
            catch {
                print("Error!")
            }
            
        }
        
        //insert all
        
        static func saveAllFacilityType( listFacilityTypeData: Array<FacilityType> = Array()){
            for facilityType in listFacilityTypeData {
                saveFacilityType(facilityTypeData: facilityType)
            }
        }
        
        //get all
        
        static func getDataFacilityType ()->[FacilityType] {
            var list : [FacilityType] = []
            //create a fetch request, telling it about the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            //   var facilityType : FacilityType? = nil
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                // print ("num of results = \(searchResults.count)")
                for trans in searchResults as! [NSManagedObject] {
                    let facilityType = FacilityType(facilityTypeId: (trans.value(forKey: Databases.FACILITY_TYPE_ID)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), description: (trans.value(forKey: Databases.DESCRIPTION)! as! String))
                    list.append(facilityType)
                }
            } catch {
                print("Error with request: \(error)")
            }
            
            return list
        }
        
        static func getByIdFacilityType (facilityTypeId : String) ->(FacilityType?) {
            var facilityType:FacilityType? = nil
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_TYPE_ID) == %@", facilityTypeId)
            
            do {
                //go get the results
                let searchResults = try context.fetch(fetchRequest)
                //I like to check the size of the returned results!
                //print ("num of results = \(searchResults.count)")
                
                //You need to convert to NSManagedObject to use 'for' loops
                for trans in searchResults as! [NSManagedObject] {
                    facilityType = FacilityType(facilityTypeId: (trans.value(forKey: Databases.FACILITY_TYPE_ID)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), description: (trans.value(forKey: Databases.DESCRIPTION)! as! String))
                    
                    //get the Key Value pairs (although there may be a better way to do that...
                    
                }
            } catch {
                print("Error with request: \(error)")
            }
            return facilityType
        }
        //DELETE RECORDS
        
        static func deleteRecords() {
            let facilityType = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            
            let result = try? facilityType.fetch(fetchRequest)
            let resultData = result as! [FacilityTypeCoreData]
            
            for object in resultData {
                facilityType.delete(object)
            }
            
            do {
                try facilityType.save()
                print("Deleted table: -> \(Databases.TABLE_FACILITY_TYPE)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
        // EDIT 29/03/2017
        
        static func getTypeIdByTypeName(facilityTypeName: String) -> String {
            var fType:FacilityType? = nil
            var list : [FacilityType] = []
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            fetchRequest.predicate = NSPredicate(format: "\(Databases.FACILITY_TYPE_NAME) == %@", facilityTypeName)
            
            do {
                let searchResults = try context.fetch(fetchRequest)
                for trans in searchResults as! [NSManagedObject] {
                    let facilityType = FacilityType(facilityTypeId: (trans.value(forKey: Databases.FACILITY_TYPE_ID)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), description: (trans.value(forKey: Databases.DESCRIPTION)! as! String))
                    list.append(facilityType)
                    if searchResults.count > 0 {
                        fType = list[0]
                        return fType!.facilityTypeId
                    }
                }
            }catch {
                print("Error with request: \(error)")
            }
            return ""
        }
        
        //// check facility Type Is Exist
        static func checkFacilityTypeIsExist() -> Bool {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
            do{
                let searchResults = try context.fetch(fetchRequest)
                if searchResults.count > 0 {
                    return true
                }
                else {
                    return false
                }
            }catch{
                return false
            }
        }
    }
    
}
