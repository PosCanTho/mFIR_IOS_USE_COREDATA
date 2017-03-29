//
//  FacilityRelationshipData.swift
//  mFIR
//  Created by Pham thi nguyet hue on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityRelationshipData{
    // var listFacilityData: Array<FacilityData> = Array()
    let context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func saveFacilityRelationship(facilityRelationshipData: Relationship){
        var results : NSArray?
            
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
            print("thanh cong")
        }
        catch {
            print("Error!")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult> (entityName: Databases.TABLE_FACILITY_TYPE)
        request.returnsObjectsAsFaults = false
        results = try! context.fetch(request) as NSArray?
        
        if (results!.count>0){
            for res in results! {
                print(res)
            }
        }
        
    }
    
    func saveAllRelationship( listRelationshipData: Array<Relationship> = Array()){
        let length = listRelationshipData.count
        for i in 0 ..< length {
            var relationship: Relationship
            relationship = listRelationshipData[i]
            let relationshipinsert = FacilityRelationshipData(context: getContext())
            relationshipinsert.saveFacilityRelationship(facilityRelationshipData: relationship)
        }
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let test = appDelegate.persistentContainer.viewContext
        
        return test
    }

    
    func getDataRelationship ()->[Relationship] {
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
        print("Chieu dai list: \(list.count)")
        return list
    }
    
        func getByIdRelationship ( facilityTypeId: String) ->[Relationship]  {
        var list : [Relationship] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
        fetchRequest.predicate = NSPredicate(format: "facilityTypeId == %@", facilityTypeId)
        print(facilityTypeId)
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
    
    func deleteRecords() -> Void {
        let relationship = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_RELATIONSHIP)
        
        let result = try? relationship.fetch(fetchRequest)
        let resultData = result as! [RelationshipCoreData]
        
        for object in resultData {
            relationship.delete(object)
        }
        
        do {
            try relationship.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }

}
