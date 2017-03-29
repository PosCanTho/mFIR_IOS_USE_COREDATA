//
//  FacilityTypeData.swift
//  mFIR
//  Created by Pham thi nguyet hue on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityTypeData{
    // var listFacilityData: Array<FacilityData> = Array()
    let context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
   //insert
    func saveFacilityType(facilityTypeData:FacilityType){
        var results : NSArray?
        let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_TYPE, in: context)
        
        let facilityType = NSManagedObject(entity: entity!, insertInto: context)
        
        facilityType.setValue(facilityTypeData.facilityTypeId, forKey: Databases.FACILITY_TYPE_ID)
        facilityType.setValue(facilityTypeData.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
        facilityType.setValue(facilityTypeData.description, forKey: Databases.DESCRIPTION)
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
    
    //insert all 
    
    func saveAllFacilityType( listFacilityTypeData: Array<FacilityType> = Array()){
        let length = listFacilityTypeData.count
        for i in 0 ..< length {
            var facilityType :FacilityType
            facilityType = listFacilityTypeData[i]
            let facilityTypeinsert = FacilityTypeData(context: getContext())
            facilityTypeinsert.saveFacilityType(facilityTypeData: facilityType)
        }
    }
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let test = appDelegate.persistentContainer.viewContext
        
        return test
    }
    
    //get all
    
    func getDataFacilityType ()->[FacilityType] {
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
        print("Chieu dai list: \(list.count)")
        return list
    }
       func getByIdFacilityType (facilityTypeId : String) ->(FacilityType?) {
        var facilityType:FacilityType? = nil
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
        fetchRequest.predicate = NSPredicate(format: "facilityTypeId == %@", facilityTypeId)
        print(facilityTypeId)
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
    
    func deleteRecords() -> Void {
        let facilityType = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_TYPE)
        
        let result = try? facilityType.fetch(fetchRequest)
        let resultData = result as! [FacilityTypeCoreData]
        
        for object in resultData {
            facilityType.delete(object)
        }
        
        do {
            try facilityType.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }

}
