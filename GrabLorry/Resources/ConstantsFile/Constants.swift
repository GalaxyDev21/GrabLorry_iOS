//
//  Constants.swift
//  Jewlot
//
//  Created by peerbits_11 on 28/03/16.
//  Copyright © 2016 peerbits. All rights reserved.
//

import Foundation
import UIKit
import  SwiftyJSON

//----------------------- DELEGATE --------------------------
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

// -------------- CONSTANTS -------------------

/***** API Credentials *****/

private let liveURL : String = ""
//private let localURL : String = "https://lorryapi.greetingtoindia.com/"
private let localURL : String = "http://13.126.203.222/lorry/api/php-api-lorry-service/"

private let isLive : Bool = false   // Api Environment, "Live = true, Local = false"

// Base Api URL
var baseURL: String {
    get {
        return (isLive) ? liveURL : localURL
    }
}


let SCREEN_SIZE = UIScreen.main.bounds

let BundleIdentifier = "" //""

let AppName = ""

let DeviceType = ""

var DeviceUDID = "fgfdgdfgfgfgdgfgfdgfgfgdfggfgf"

var header: [String:String] = ["Connection":"Close"]

var header1: [String:String] = ["content-type":"application/json"]

var header2: [String:String] = ["":""]

var Header3: [String:String] = ["content-type":"application/x-www-form-urlencoded"]

let User_Details = "USER"

let Defaults = UserDefaults.standard




// MARK: ------ Parameter -------

let p_Headername = "X-Header-DeviceID"

let p_email_Id = "email"

let p_name = "name"

let p_password = "password"

let p_oldPassword = "oldpassword"

let p_confPassword = "confPassword"

let p_mobile = "mobile"

let p_Authorization = "Authorization"

let p_radiusRange = "radiusRange"

let p_recid = "recid"

let p_type = "type"

let p_aggregates = "aggregates"

let p_quantity = "quantity"

let p_trip = "trip"

let p_date_and_time = "dateandtime"

let p_address = "address"

let p_notes = "notes"

let p_addon_id = "addonID"

let p_longitude = "longitude"

let p_latitude = "latitude"

let p_ordetotal = "ordertotal"


// MARK: --------- Validation Messages ---------

let EmailValidation = "Please enter EmailID"

let InvalidEmailValidation = "Please enter valid EmailID"

let PasswordValidation = "Please enter Password"

let ConfirmPasswordValidation = "Please re-type Password"

let OldPasswordValidationMessage = "Please enter old password"

let NewPasswordValidationMessage = "Please enter new password"

let PasswordValidMessage = "Password must be between 6 to 12 characters"

let PasswordDonotmatchMessage = "Password do not match"

let NameValidation = "Please enter name"

let NameValidMessage = "Name length should be at least 3 characters long"

let MobileNumberValidation = "Please enter Mobile number"

let MobileNumberValidValidation = "Please enter valid Mobile number"

let SuccessfullyRegisterMessage = "Successfully Register"

let SelectTypeMessage = "Please select type"

let SelectAggregatesMessage = "Please select aggregates"

let SelectLorriesquantityMessage = "Please enter lorries quantity"

let SelectTrips = "Please enter trips"

let SelectDateAndTime = "Please select date and time"

let SelectAddressMessage = "Please enter Address"

let SelectAddonMessage = "Please select add-on"

let ValidAddressMessage = "Please enter valid address with city"

let SomethingWentWrongMessage = "Something went wrong"

enum Endpoint : String
{
    case Login = "public/login/signIn"
    case Register = "public/login/signUp"
    case Forgot = "public/login/forgotPassword"
    case ChnagePass = "public/users/changePassword"
    case LogOut = "public/users/logout"
    case ChangeRadius = "public/users/changeRadius"
    case getallformfield = "public/lorry/getFormFields"
    case GrabLorryReqpost = "public/lorry/postGrabLorryRequest"
    case GetNearBySupllier = "public/suppliers/getNearBySuppliers"
    case UpdateLocation = "public/users/updateLocation"
    
}


//----------------------- SCREEN --------------------------

let kMainScreen         = UIScreen.main.bounds
let kMainScreenWidth    = UIScreen.main.bounds.size.width
let kMainScreenHeight   = UIScreen.main.bounds.size.height


//----------------------- COLORS --------------------------

let jewlot_blue = UIColor(red: 36.0/255.0, green: 37.0/255.0, blue: 57.0/255.0, alpha: 1.0)

let jewlot_yellow = UIColor(red: 238.0/255.0, green: 184.0/255.0, blue: 15.0/255.0, alpha: 1.0)

let jewlot_pink = UIColor(red: 178.0/255.0, green: 41.0/255.0, blue: 122.0/255.0, alpha: 1.0)

let jewlot_gray = UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 85.0/255.0, alpha: 1.0)


//----------------------- FONTS --------------------------

func fontReguler(_ size:CGFloat) -> UIFont {
   return UIFont(name: "ProximaNova-Regular", size: size)!
}

func fontSemibold(_ size:CGFloat) -> UIFont {
    return UIFont(name: "ProximaNova-Semibold", size: size)!
}

func fontSemiboldNovaA(_ size:CGFloat) -> UIFont {
    return UIFont(name: "ProximaNovaA-Semibold", size: size)!
}

// MARK: --------- METHODS -------------

// -------- Phone Number -----------------
func isValidPhoneNumber(value: String) -> Bool {
    //let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
    let PHONE_REGEX = "^\\d{10}$"
    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
    let result =  phoneTest.evaluate(with: value)
    return result
}

// ---------- USERID -----------
func getCurrentUserID() -> String?
{
    if let result = Defaults.value(forKey: User_Details)
    {
        let user : UserDetailsModel = UserDetailsModel(Data: JSON(result))
        //print(user.recid)
        return user.recid
    }
    else
    {
        return nil

    }
}


func GetUserDetails() -> UserDetailsModel?
{
    if let result = Defaults.value(forKey: User_Details)
    {
      //  print(result)
        let user : UserDetailsModel = UserDetailsModel(Data: JSON(result))
        return user
    }
    else
    {
        return nil
    }
}




