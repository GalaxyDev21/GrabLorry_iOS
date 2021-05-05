//
//  ForgotPasswordVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 07/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordVC: UIViewController , UITextFieldDelegate{
    //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet var EmailSeparateView: UIView!
    @IBOutlet var EmailTxt: UITextField!
    //MARK:- ---------------- VIEW DID LOAD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.BorderForTextFieldView(view: EmailSeparateView)
    }
    //MARK:- ---------------- CLICK EVENTS ------------------
    @IBAction func SubmitButtonClick(_ sender: Any) {
        if Validate(){
            ForgotPasswordAPiCall()
        }
    }
    //MARK:- ---------------- My Function ------------------
    func Validate() -> Bool {
        if (EmailTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: EmailValidation)
            return false
        }else if (Utilities.isValidEmail(EmailTxt.text!) != true){
            Utilities.showErrorMessage(text: InvalidEmailValidation)
            return false
        }
        return true
    }
    //MARK:- ---------------- API CALL ------------------
    func ForgotPasswordAPiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let param : [String : Any] = [
            p_email_Id : EmailTxt.text!,
            ]
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers = [p_Headername:deviceid]
        Alamofire.request(baseURL + Endpoint.Forgot.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                    print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "FORGOTSUCC" {
                      Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                      self.navigationController?.popViewController(animated: true)
                   }else{
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
                appInstance.hideLoader()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }
    //MARK:- ---------------- TextField Delegate ------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}
