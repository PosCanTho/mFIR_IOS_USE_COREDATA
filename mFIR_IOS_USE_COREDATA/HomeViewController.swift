//
//  HomeViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Baslor on 28/03/2017.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Home"
        let statusBarBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 15))
        statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.9872162938, green: 0.1450281143, blue: 0.01777093299, alpha: 1)
        //statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.9872162938, green: 0.1450281143, blue: 0.01777093299, alpha: 1)
        
        /* status background
        self.navigationController?.view.addSubview(statusBarBackgroundView)
        self.navigationController?.view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        self.navigationController?.view.addConstraintsWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
