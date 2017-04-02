//
//  ReportIssue.swift
//  mFIR
//
//  Created by Tran Bao Toan on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class ReportIssue {
    var componentName: String
    var description: String
    var componentID: String
    var checked: Bool
    var image: UIImage?

    
    init(componentName: String, description: String, componentID: String, checked: Bool, image: UIImage?) {
        self.componentName = componentName
        self.description = description
        self.componentID = componentID
        self.checked = checked
        self.image = image
    }
}

extension ReportIssue: Equatable { }
func ==(lhs: ReportIssue, rhs: ReportIssue) -> Bool {
    return lhs === rhs
}

