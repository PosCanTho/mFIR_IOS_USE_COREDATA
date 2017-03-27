//
//  PostParameter.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class PostParameter{
    
    private var keyArray:Array = ["username", "password"]
    private var valueArray:Array = ["",""]
    
    func add(key:String, value:String){
        if(key == "username"){
            valueArray[0] = value
            let userReference = UserDefaults.standard
            userReference.setValue(value, forKey: UserReferences.USERNAME)
            return
        }
        
        if(key == "password"){
            valueArray[1] = value
            let userReference = UserDefaults.standard
            userReference.setValue(value, forKey: UserReferences.PASSWORD)
            return
        }
        
        keyArray.append(key)
        valueArray.append(value)
    }
    
    func getString() -> String{
        var str:String = ""
        let total = keyArray.count - 1
        for i in 0...total{
            if(i == total){
                str += keyArray[i] + "=" + valueArray[i]
            }else{
                str += keyArray[i] + "=" + valueArray[i] + "&"
            }
        }
    
        return str
    }
    
    func isLogin() -> Bool{
        if(!valueArray[0].isEmpty && !valueArray[1].isEmpty){
            return true
        }
        
        return false
    }
}
