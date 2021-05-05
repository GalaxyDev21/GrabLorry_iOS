//
//  RegisterVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 07/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController  , UITextFieldDelegate{
    //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet var TextFieldSeperaterView: [UIView] = []
    @IBOutlet var Nametxt: UITextField!
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordTxt: UITextField!
    @IBOutlet var ConfirmPasswordTxt: UITextField!
    @IBOutlet var MobilenoTxt: UITextField!
    //MARK:- ---------------- VIEW DID LOAD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in TextFieldSeperaterView as [UIView] {
            Utilities.BorderForTextFieldView(view: view)
        }
    }
     //MARK:- ---------------- CLICK EVENTS ------------------
    @IBAction func RegisterButtonClick(_ sender: Any) {
        if Validate(){
          RegisteAPiCall()
        }
    }
    //MARK:- ---------------- API CALL ------------------
    func RegisteAPiCall(){
    self.view.endEditing(true)
    appInstance.showLoader()
    let param : [String : Any] = [
            p_email_Id : EmailText.text!,
            p_name : Nametxt.text!,
            p_password  : PasswordTxt.text!,
            p_confPassword : ConfirmPasswordTxt.text!,
            p_mobile : MobilenoTxt.text!
    ]
    let deviceid = UIDevice.current.identifierForVendor!.uuidString
    let headers = [p_Headername:deviceid]
    Alamofire.request(baseURL+Endpoint.Register.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("RESPONSE \(response)")
        if((response.result.value) != nil)
        {
            appInstance.hideLoader()
            if let json = response.result.value {
                let jsonobj = json as! NSDictionary
                print(jsonobj)
                if jsonobj["flagMsg"] as? String == "USRREG" {
                    self.BlackAllField()
                    Utilities.showErrorMessage(text: SuccessfullyRegisterMessage)
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

    //MARK:- ---------------- My Function ------------------
    func Validate() -> Bool {
        if (Nametxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: NameValidation)
            return false
        }
        if (EmailText.text?.isEmpty)!{
            Utilities.showErrorMessage(text: EmailValidation)
            return false
        }else if (Utilities.isValidEmail(EmailText.text!) != true){
            Utilities.showErrorMessage(text: InvalidEmailValidation)
            return false
        }
        if (PasswordTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: PasswordValidation)
            return false
        }else if (Utilities.isValidPassword(testStr: PasswordTxt.text!) != true){
            Utilities.showErrorMessage(text: PasswordValidMessage)
            return false
        }
        if (ConfirmPasswordTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: ConfirmPasswordValidation)
            return false
        }
        if (PasswordTxt.text != ConfirmPasswordTxt.text){
            Utilities.showErrorMessage(text: PasswordDonotmatchMessage)
            return false
        }
        if (MobilenoTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: MobileNumberValidation)
            return false
        }else if Utilities.validatemobilenumber(textfield: MobilenoTxt) != true{
            Utilities.showErrorMessage(text: MobileNumberValidValidation)
            return false
        }
        return true
    }
    
    func BlackAllField(){
       EmailText.text = ""
       Nametxt.text = ""
       PasswordTxt.text = ""
       ConfirmPasswordTxt.text = ""
       MobilenoTxt.text = ""
    }
    //MARK:- ---------------- TextField Delegate ------------------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
