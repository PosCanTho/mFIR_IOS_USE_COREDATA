//
//  ComponentType.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class ComponentType {
    var componentTypeId:String
    var componentTypeName:String
    var description:String
    
    init(componentTypeId:String, componentTypeName:String, description:String) {
        self.componentTypeId = componentTypeId
        self.componentTypeName = componentTypeName
        self.description = description
    }
}
