//
//  MyAccountVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 13/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit

class MyAccountVC: UIViewController {

    @IBOutlet var NameTxt: UITextField!
    @IBOutlet var EMailTxt: UITextField!
    @IBOutlet var MobileNumberTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameTxt.text = GetUserDetails()?.name
        EMailTxt.text = GetUserDetails()?.email
        MobileNumberTxt.text = GetUserDetails()?.mobile
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden  = false
    }

}
