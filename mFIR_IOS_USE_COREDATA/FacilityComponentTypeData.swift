//
//  FacilityRelationshipData.swift
//  mFIR
//  Created by Pham thi nguyet hue on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FacilityComponentTypeData{
    // var listFacilityData: Array<FacilityData> = Array()
    let context:NSManagedObjectContext
    
    init(context:NSManagedObjectContext) {
        self.context = context
    }
    
    func saveComponent(component :ComponentType){
        var results : NSArray?
        
        let entity =  NSEntityDescription.entity(forEntityName: Databases.TABLE_FACILITY_COMPONENT_TYPE, in: context)
        let componentType76 = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        componentType76.setValue(component.componentTypeId, forKey:Databases.FACILITY_COMPONENT_TYPE_ID)
        componentType76.setValue(component.componentTypeName, forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)
        componentType76.setValue(component.description, forKey: Databases.DESCRIPTION)
        
        //save the object
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
    func saveAllComponent(listComponentData: Array<ComponentType> = Array()){
        let length = listComponentData.count
        for i in 0 ..< length {
            var component: ComponentType
            component = listComponentData[i]
            let componentinsert = FacilityComponentTypeData(context: getContext())
            componentinsert.saveComponent(component: component)
        }
    }
       func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let test = appDelegate.persistentContainer.viewContext
        
        return test
    }
    
    func getData () {
        //create a fetch request, telling it about the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
        
        do {
            //go get the results
            let searchResults = try context.fetch(fetchRequest)
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for trans in searchResults as! [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_ID)!) - \(trans.value(forKey: Databases.FACILITY_COMPONENT_TYPE_NAME)!) - \(trans.value(forKey: Databases.DESCRIPTION)!)")
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    //DELETE RECORDS
    
    func deleteRecords() -> Void {
        let component = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Databases.TABLE_FACILITY_COMPONENT_TYPE)
        
        let result = try? component.fetch(fetchRequest)
        let resultData = result as! [FacilityComponentTypeCoreData]
        
        for object in resultData {
            component.delete(object)
        }
        
        do {
            try component.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }


    
}
