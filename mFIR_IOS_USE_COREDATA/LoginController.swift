//
//  LoginController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Pham Van Thien on 3/27/17.
//  Copyright © 2017 poscantho. All rights reserved.
//
import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbErrorUsername: UILabel!
    @IBOutlet weak var lbErorrPassowrd: UILabel!
    @IBOutlet weak var btnCheckbox: UIButton!
    
    var isRememberChecked:Bool = false
    var isLogin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isRememberChecked = false;
        lbErrorUsername.isHidden = true;
        lbErorrPassowrd.isHidden = true;
        
        isLogin = UserDefaults.standard.bool(forKey: UserReferences.IS_REMEMBER)
        if isLogin {
            print("Is login")
        }
        let username: String? = UserDefaults.standard.string(forKey: UserReferences.USERNAME)
        if username != nil {
            tfUsername.text = username
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = tfUsername.text!
        let password = tfPassword.text!
        
        if(username.isEmpty){
            lbErrorUsername.isHidden = false
            lbErorrPassowrd.isHidden = true
            tfUsername.becomeFirstResponder()
        }else if(password.isEmpty){
            lbErorrPassowrd.isHidden = false
            lbErrorUsername.isHidden = true
            tfPassword.becomeFirstResponder()
        }else{
            lbErrorUsername.isHidden = true
            lbErorrPassowrd.isHidden = true
            //let usernameDe = "huynhducviet"
            //let passwordDe = "UUNpZzQxYXN5VWY4MHIrL0FNN3hIaEtOU0VvPQ=="
            
            FirServices.login(username: username, password: Utils.passwordEncrypt(password: password), imei: "", callback: { (user) in
                if user == nil {
                    FirDialog.show(title: "Sign in fail", mes: "Username or password is incorrect.", buttonName: "OK")
                }else {
                    //Sigin success
                    FirDialog.show(title: "Sign in", mes: "Sucess", buttonName: "OK")
                }
            })
            
        }
        
    }
    
    @IBAction func onRemember(_ sender: Any) {
        if isRememberChecked == true {
            isRememberChecked = false
            let imgUncheck: UIImage = UIImage(named: "ic_uncheck")!
            btnCheckbox.setImage(imgUncheck, for: UIControlState.normal)
        }else{
            isRememberChecked = true;
            let imgChecked: UIImage = UIImage(named: "ic_checked")!
            btnCheckbox.setImage(imgChecked, for: UIControlState.normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == tfUsername {
            self.tfPassword.becomeFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
