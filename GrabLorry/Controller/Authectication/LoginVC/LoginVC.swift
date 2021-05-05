
//  LoginVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 07/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController  , UITextFieldDelegate{

    //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet var TextFieldSeperaterView: [UIView] = []
    @IBOutlet var EmailText: UITextField!
    @IBOutlet var PasswordTxt: UITextField!
    //MARK:- ---------------- VIEW DID LOAD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        for view in TextFieldSeperaterView as [UIView] {
            Utilities.BorderForTextFieldView(view: view)
        }
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate;

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if GetUserDetails()?.apikey == nil {}else{
            let TabBarController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(TabBarController, animated: true)
        }
    }
  
    //MARK:- ---------------- CLICK EVENTS ------------------
    @IBAction func LoginButtonClick(_ sender: Any) {
        if Validate(){
            LoginAPiCall()
        }
    }
    //MARK:- ---------------- My Function ------------------
    func Validate() -> Bool {
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
        }
        return true
    }
    //MARK:- ---------------- API CALL ------------------
    func LoginAPiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let param : [String : Any] = [
            p_email_Id : EmailText.text!,
            p_password  : PasswordTxt.text!,
        ]
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers = [p_Headername:deviceid]
        Alamofire.request(baseURL+Endpoint.Login.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
           // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                    print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "USRLOGIN" {
                        let userdetails = UserDetailsModel(Data: JSON(jsonobj["data"] as! NSDictionary))
                        print(userdetails.email)
                        print(userdetails.apikey)
                        if let datadic = jsonobj["data"] as? NSDictionary , let radiusstr = datadic["radius"] as? String{
                            Defaults.set(radiusstr, forKey: "dlfradius")
                            Defaults.synchronize()
                        }
                        
                        let resultvc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                        self.navigationController?.navigationBar.isHidden = true
                        self.navigationController?.pushViewController(resultvc, animated: true)
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
