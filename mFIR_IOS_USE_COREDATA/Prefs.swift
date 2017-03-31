//
//  Prefs.swift
//  mFIR
//
//  Created by lehoangdung on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
class Prefs {
    static func set(key:String, value: Any){// Any là kiểu dữ liệu bất kỳ
        UserDefaults.standard.set(value, forKey: key)
    }
    static func get(key:String) -> Any?{
        return UserDefaults.standard.value(forKey: key)
    }
    
    private static let kCurrentLocale = "CurrentLocale"
    private static let kDefaultLocale = LangEN
    
    static let shared = Prefs()
    
    func currentLocale() -> String {
        if let locale = UserDefaults.standard.value(forKey: Prefs.kCurrentLocale) {
            return locale as! String
        }
        return Prefs.kDefaultLocale
    }
    
    func setCurrentLocale(_ locale: String) {
        UserDefaults.standard.set(locale, forKey: Prefs.kCurrentLocale)
        UserDefaults.standard.synchronize()
    }
    
}
