//
//  ViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let download = FirServices(self)
        /*
        download.login(username: "huynhducviet", password: "UUNpZzQxYXN5VWY4MHIrL0FNN3hIaEtOU0VvPQ==", imei: "") { (data, isComplete) in
            guard let data = data as?  User else{
                
                return
            }
            
            print(data.userName)
        }
         
    */
        download.getFacility(facilityId: "0") { (data) in
            guard let data = data as?  [Facility] else{
                return
            }
            print(data.count)
            for i in data{
                print(i.facilityName)
            }
        }
  
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

