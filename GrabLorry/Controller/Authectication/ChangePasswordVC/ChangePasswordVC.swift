//
//  ChangePasswordVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 07/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordVC: UIViewController , UITextFieldDelegate {
    //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet var TextFieldSeperaterView: [UIView] = []
    @IBOutlet var OldPassTxt: UITextField!
    @IBOutlet var NewPasswordTxt: UITextField!
    @IBOutlet var ReTypePasswordTxt: UITextField!
    
    //MARK:- ---------------- VIEW DID LOAD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in TextFieldSeperaterView as [UIView] {
        Utilities.BorderForTextFieldView(view: view)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden  = false
    }
    //MARK:- ---------------- CLICK EVENTS ------------------
    @IBAction func SubmitButtonClick(_ sender: Any) {
        if Validate(){
            ChangePasswordAPiCall()
        }
    }
    //MARK:- ---------------- My Function ------------------
    func Validate() -> Bool {
        if (OldPassTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: OldPasswordValidationMessage)
            return false
        }
        if (NewPasswordTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: NewPasswordValidationMessage)
            return false
        }else if (Utilities.isValidPassword(testStr: NewPasswordTxt.text!) != true){
            Utilities.showErrorMessage(text: PasswordValidMessage)
            return false
        }
        if (ReTypePasswordTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: ConfirmPasswordValidation)
            return false
        }
        if NewPasswordTxt.text != ReTypePasswordTxt.text{
            Utilities.showErrorMessage(text: PasswordDonotmatchMessage)
            return false
        }
        return true
    }
    //MARK:- ---------------- API CALL ------------------
    func ChangePasswordAPiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let param : [String : Any] = [
           // p_email_Id : OldPassTxt.text!,
            p_password  : NewPasswordTxt.text!,
            p_oldPassword: OldPassTxt.text!
            ]
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
        print(headers)
        Alamofire.request(baseURL+Endpoint.ChnagePass.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                   // print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "UPDPASS" {
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
