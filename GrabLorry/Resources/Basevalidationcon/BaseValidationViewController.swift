//
//  BaseValidationViewController.swift
//  Leazzer
//
//  Created by Guruz.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseValidationViewController : UIViewController, NVActivityIndicatorViewable {
    
    //var isApiInCall : Bool = false
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: - LOADEr -
    func showLoader() {
   //    isApiInCall = true
        stopAnimating()
        self.view.isUserInteractionEnabled = false
        NVActivityIndicatorView.DEFAULT_COLOR  = UIColor.black
        NVActivityIndicatorView.DEFAULT_TYPE = .ballSpinFadeLoader
        startAnimating()
    }
    
    func hideLoader() {
        
     //   isApiInCall = false
        self.view.isUserInteractionEnabled = true
        stopAnimating()
    }

}


