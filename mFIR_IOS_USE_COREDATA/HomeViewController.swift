//
//  HomeViewController.swift
//  mFIR_IOS_USE_COREDATA
//
//  Created by Baslor on 29/03/2017.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Home"
        let statusBarBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 15))
        statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.6855863333, green: 0.2018412054, blue: 0.1538721025, alpha: 1)
        //statusBarBackgroundView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        //status background
        self.navigationController?.view.addSubview(statusBarBackgroundView)
        self.navigationController?.view.addConstraintsWithFormat(format: "H:|[v0]|", views: statusBarBackgroundView)
        self.navigationController?.view.addConstraintsWithFormat(format: "V:|[v0(20)]", views: statusBarBackgroundView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
