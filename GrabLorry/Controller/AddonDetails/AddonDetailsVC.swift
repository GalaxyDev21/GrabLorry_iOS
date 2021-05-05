//
//  AddonDetailsVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 15/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit

class AddonDetailsVC: UIViewController {

    //MARK: ------------ IBOUTLETS -------------
    
    @IBOutlet var CompanyNamTxt: UITextField!
    
    @IBOutlet var ProductNamrTxt: UITextField!
    
    @IBOutlet var DetailsTxt: UITextField!
    
    @IBOutlet var PriceTxt: UITextField!
    
    @IBOutlet var SizeTxt: UITextField!
   
    @IBOutlet var WeightTxt: UITextField!
    
    @IBOutlet var StokeCount: UITextField!
    
    //MARK: ------------ Objects -------------
    var SelectedDatadic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(SelectedDatadic)
      //  CompanyNamTxt.text = SelectedDatadic["companyname"] as? String
        ProductNamrTxt.text = SelectedDatadic["productname"] as? String
        DetailsTxt.text = SelectedDatadic["details"] as? String
        PriceTxt.text = ("£ \(SelectedDatadic["price"] as? String ?? "")")
        SizeTxt.text = SelectedDatadic["size"] as? String
        WeightTxt.text = SelectedDatadic["weight"] as? String
       // StokeCount.text = SelectedDatadic["stockcount"] as? String
    }

    @IBAction func okbuttonclick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
