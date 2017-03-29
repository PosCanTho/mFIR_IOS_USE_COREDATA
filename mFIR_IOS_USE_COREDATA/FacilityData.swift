//
//  FacilityData.swift
//  mFIR
//  Created by Pham thi nguyet hue on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityData{
   
    let context:NSManagedObjectContext

    init(context:NSManagedObjectContext) {
        self.context = context
        
    }

    func saveFacility(facility: Facility){
        var results : NSArray?
        let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY, in: context)
        let facilityData = NSManagedObject(entity: entity!, insertInto: context)
        facilityData.setValue(facility.facilityId, forKey: Databases.FACILITY_ID)
        facilityData.setValue(facility.facilityName, forKey: Databases.FACILITY_NAME)
        facilityData.setValue(facility.facilityTypeName, forKey: Databases.FACILITY_TYPE_NAME)
        facilityData.setValue(facility.facilityRootId, forKey: Databases.ROOT_FACILITY_ID)
        facilityData.setValue(facility.facilityUsageStatus, forKey: Databases.FACILITY_USAGE_STATUS)
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
    func saveAllFacility(listFacilityData: Array<Facility> = Array()){
        let length = listFacilityData.count
        for facility in listFacilityData {
          //  var facility:Facility
          //   facility = listFacilityData[i]
             let facilityinsert = FacilityData(context: getContext())
            facilityinsert.saveFacility(facility: facility)
        }
        }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let test = appDelegate.persistentContainer.viewContext
        
        return test
    }
    
    func getDataFacility ()->[Facility]{
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
         print("Chieu dai list: \(list.count)")
        return list
    }
    func getByIdFacility (facilityId : String) ->(Facility?) {
        var facility:Facility? = nil
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
        fetchRequest.predicate = NSPredicate(format: "facilityId == %@", facilityId)
        print(facilityId)
        do {
            //go get the results
            let searchResults = try context.fetch(fetchRequest)
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as! [NSManagedObject] {
                facility = Facility(facilityId:(trans.value(forKey: Databases.FACILITY_ID)! as! String) , facilityName: (trans.value(forKey: Databases.FACILITY_NAME)! as! String), facilityTypeName: (trans.value(forKey: Databases.FACILITY_TYPE_NAME)! as! String), facilityUsageStatus: (trans.value(forKey: Databases.FACILITY_USAGE_STATUS)! as! String), facilityRootId: (trans.value(forKey: Databases.ROOT_FACILITY_ID)! as! String))
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(trans.value(forKey: Databases.FACILITY_ID)!) - \(trans.value(forKey: Databases.FACILITY_NAME)!) - \(trans.value(forKey: Databases.FACILITY_TYPE_NAME)!) - \(trans.value(forKey: Databases.ROOT_FACILITY_ID)!) - \(trans.value(forKey: Databases.FACILITY_USAGE_STATUS)!)")
            }
        } catch {
            print("Error with request: \(error)")
        }
        return facility
    }
    
    //DELETE RECORDS
    
    func deleteRecords() -> Void {
        let facility = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY)
        
        let result = try? facility.fetch(fetchRequest)
        let resultData = result as! [FacilityCoreData]
        
        for object in resultData {
            facility.delete(object)
        }
        do {
            try facility.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    

    }
