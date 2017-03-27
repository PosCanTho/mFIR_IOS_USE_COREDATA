//
//  Student.swift
//  mFIR
//
//  Created by Tống Thành Vinh on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation

class Student {
    var studentIdNumber:String
    var currentLastName:String
    var currentFirstName:String
    var currentMiddleName:String
    var birthDate:String
    var peopleIdNumber:String
    var currentGender:String
    var currentPhoneNumber:String
    var currentMobileNumber:String
    var academicIntakeSessionName:String
    var academicProgramName:String
    var curriculumName:String
    var curriculumCode:String
    var programShort:String
    var academicProgramCode:String
    var academicLevelName:String
    var studentLearningStatusTypeName:String
    
    init(
        studentIdNumber:String,
        currentLastName:String,
        currentFirstName:String,
        currentMiddleName:String,
        birthDate:String,
        peopleIdNumber:String,
        currentGender:String,
        currentPhoneNumber:String,
        currentMobileNumber:String,
        academicIntakeSessionName:String,
        academicProgramName:String,
        curriculumName:String,
        curriculumCode:String,
        programShort:String,
        academicProgramCode:String,
        academicLevelName:String,
        studentLearningStatusTypeName:String
        ){
        self.studentIdNumber = studentIdNumber
        self.currentLastName = currentLastName
        self.currentFirstName = currentFirstName
        self.currentMiddleName = currentMiddleName
        self.birthDate = birthDate
        self.peopleIdNumber = peopleIdNumber
        self.currentGender = currentGender
        self.currentPhoneNumber = currentPhoneNumber
        self.currentMobileNumber = currentMobileNumber
        self.academicIntakeSessionName = academicIntakeSessionName
        self.academicProgramName = academicProgramName
        self.curriculumName = curriculumName
        self.curriculumCode = curriculumCode
        self.programShort = programShort
        self.academicProgramCode = academicProgramCode
        self.academicLevelName = academicLevelName
        self.studentLearningStatusTypeName = studentLearningStatusTypeName
    }
}
