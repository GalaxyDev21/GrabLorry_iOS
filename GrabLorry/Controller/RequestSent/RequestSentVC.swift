//
//  RequestSentVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 15/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit

class RequestSentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DoneButtonClick(_ sender: Any) {
      //  let resultvc = self.storyboard?.instantiateViewController(withIdentifier: "<#T##String#>")
     self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)

    }
    

}
