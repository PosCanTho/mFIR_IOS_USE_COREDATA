//
//  Settings.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by lehoangdung on 3/30/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SettingsController: UIViewController{
    /*
     
     //MARK: UI Elements
     @IBOutlet weak var lblLang: LocalizableLabel!
     @IBOutlet weak var lblSync: LocalizableLabel!
     @IBOutlet weak var btn: LocalizableButton!
     @IBOutlet weak var txt: LocalizableTextField!
     
     
     @IBOutlet weak var swLang: UISwitch!
     var currentLocale = Prefs.shared.currentLocale()
     
     //MARK: ** UI EVents
     @IBAction func swLangEvent(_ sender: Any) {
     if let sw = sender as? UISwitch
     {
     if sw.isOn
     {
     Prefs.set(key: "swSettingsLang", value: 1)
     Prefs.shared.setCurrentLocale(LangEN)
     view.onUpdateLocale()
     
     }else{
     Prefs.set(key: "swSettingsLang", value: 0)
     Prefs.shared.setCurrentLocale(LangVI)
     view.onUpdateLocale()
     }
     
     }
     }
     
     @IBAction func btnClick(_ sender: UIButton) {
     alert(title: LocalizationHelper.shared.localized("t")!,
     message: LocalizationHelper.shared.localized("m")!)
     }

     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
//        let swlang = Prefs.get(key: "swSettingsLang") as? Int
//        if swlang == nil
//        {
//            Prefs.set(key: "swSettingsLang", value: 1)
//            swLang.setOn(true, animated: true)
//            Prefs.shared.setCurrentLocale(LangEN)
//            view.onUpdateLocale()
//        }else if(swlang == 1){
//            Prefs.set(key: "swSettingsLang", value: 1)
//            swLang.setOn(true, animated: true)
//            Prefs.shared.setCurrentLocale(LangEN)
//            view.onUpdateLocale()
//        }else{
//            Prefs.set(key: "swSettingsLang", value: 0)
//            swLang.setOn(false, animated: true)
//            Prefs.shared.setCurrentLocale(LangVI)
//            view.onUpdateLocale()
//        }
    }
}
