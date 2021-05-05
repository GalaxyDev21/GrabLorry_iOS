//
//  HomeVC.swift
//  GrabLorry
//
//  Created by RMV on 07/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import GoogleMaps
import DropDown
import Alamofire

class HomeVC: UIViewController , UISearchBarDelegate, CLLocationManagerDelegate {
   //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet weak var Searchbar: UISearchBar!
    @IBOutlet weak var mapview: GMSMapView!
    @IBOutlet weak var MenuBtn: UIButton!
    @IBOutlet var PlaceSearchbar: UISearchBar!
    @IBOutlet var PopupBackView: UIView!
    @IBOutlet var RadiusPopup: UIView!
    @IBOutlet var RadusSlider: UISlider!
    @IBOutlet var SliderValurLabel: UILabel!
    @IBOutlet var lorrycuntlbl: UILabel!
    
    //MARK:- ---------------- OBJECTS ------------------
      let MenuDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.MenuDropdown
        ]
    }()
    var searchActive : Bool = false
    var locationManager = CLLocationManager()
    var locationflag : Bool = false
     var zoom: Float = 13
    var currentlatstring = Double()
    var currentlongstring = Double()
    //MARK:- ---------------- VIEW DID LOAD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        PopupBackView.isHidden = true
        RadiusPopup.isHidden = true
        PlaceSearchbar.delegate = self
        // Add tap Gesture on popupbackview
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeVC.popuphide(_:)))
        PopupBackView.addGestureRecognizer(tapGestureRecognizer)
        RadiusPopup.layer.cornerRadius = 8
        RadiusPopup.layer.masksToBounds = true
        // Google map code
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        mapview.camera = camera
     //   mapview.delegate = self
        mapview.isMyLocationEnabled = true
        mapview.settings.myLocationButton = true
        // Creates a marker in the center of the map.
        // SetUpDropdown
        setupmenudropdown()
      //  self.locationManager.delegate = self
      //  self.locationManager.startUpdatingLocation()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
       locationManager.startUpdatingLocation()
       // GetNearBySupplierAPiCall()
      
        let myString = Defaults.value(forKey: "dlfradius")
        let myFloat = (myString as! NSString).floatValue
        RadusSlider.value = myFloat
        
        SliderValurLabel.text = String(myFloat)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locationflag == false{
            locationflag = true
            mapview.clear()
            let location = locations.last
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 13.0)
           // let lat = "\(location?.coordinate.longitude)"
            
            
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
            marker.title = "My Location"
            //  marker.snippet = "Australia"
            marker.map = mapview
            
            self.mapview?.animate(to: camera)
            
            //Finally stop updating location otherwise it will come again and again in this delegate
            self.locationManager.stopUpdatingLocation()
            
         //   let strlat = String(location?.coordinate.latitude)
            if let latstring = location?.coordinate.latitude , let longstring =  location?.coordinate.longitude {
                currentlatstring = latstring
                currentlongstring = longstring
                appInstance.showLoader()
                 LocationUpdateAPiCall(Lat:latstring, long: longstring)
            }
            
        }else{
            self.locationManager.stopUpdatingLocation()
        }
    
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("NotDetermined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        case .authorizedAlways:
            print("AuthorizedAlways")
        case .authorizedWhenInUse:
            print("AuthorizedWhenInUse")
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       // print("Failed to initialize GPS: ", error.localizedDescription)
        Utilities.showErrorMessage(text: "Please go to setting and on location service for process of this app")
    }

     //MARK:- ---------------- My Mathod ------------------
    @objc func popuphide(_ sender:AnyObject){
        PopupBackView.isHidden = true
        RadiusPopup.isHidden = true
    }
    func setupmenudropdown() {
        MenuDropdown.anchorView = MenuBtn
        MenuDropdown.dataSource = [
            "My Account",
            "Change Radius",
            "I am a grab lorry Comp",
            "Change Password",
            "Help",
            "T&C",
            "Logout",
        ]
        MenuDropdown.selectionAction = { [weak self] (index, item) in
            print(item)
            if item == "Change Password"{
                let resultvc = self?.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                self?.navigationController?.navigationBar.isHidden = false
                self?.navigationController?.pushViewController(resultvc, animated: true)
            }else if item == "My Account"{
                let resultvc = self?.storyboard?.instantiateViewController(withIdentifier: "MyAccountVC") as! MyAccountVC
                self?.navigationController?.navigationBar.isHidden = false
                self?.navigationController?.pushViewController(resultvc, animated: true)
            }else if item == "Change Radius"{
                self?.MenuDropdown.hide()
                self?.PopupBackView.isHidden = false
                self?.RadiusPopup.isHidden = false
            }else if item == "I am a grab lorry Comp" {
                guard let url = URL(string: "https://www.lorrygrabber-site.com/news") else {return}
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            else if item == "Help"{
             guard let url = URL(string: "https://www.lorrygrabber-site.com") else {return}
             if #available(iOS 10.0, *) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
             } else {
                UIApplication.shared.openURL(url)
              }
            }else if item == "T&C"{
               guard let url = URL(string: "https://www.lorrygrabber-site.com") else {return}
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
            }else{
              //  let resultvc = self?.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                
               // self?.navigationController?.pushViewController(resultvc, animated: true)
             //   UserDetailsModel.logOut(<#T##UserDetailsModel#>)
                self?.LogoutAPiCall()
            }
        }
    }
    func setupDefaultDropDown() {
        DropDown.setupDefaultAppearance()
        
        dropDowns.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
            $0.customCellConfiguration = nil
        }
    }
    //MARK:- ---------------- Api Call ------------------
    func LogoutAPiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
        Alamofire.request(baseURL+Endpoint.LogOut.rawValue, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                    print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "USRLOGOUT" {
                      //  self.navigationController?.navigationBar.isHidden = false
                        let USER = GetUserDetails()
                        USER?.logOut()
                    }else{
                        //Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
                appInstance.hideLoader()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }
    func ChangeRadiusAPiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let param : [String : Any] = [
            p_radiusRange  : SliderValurLabel.text!,
            ]
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
        // print(headers)
        Alamofire.request(baseURL+Endpoint.ChangeRadius.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
              //  appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                     print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "RADUPD" {
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                        self.GetNearBySupplierAPiCall()
                    }else{
                        appInstance.hideLoader()
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
                appInstance.hideLoader()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }
    func LocationUpdateAPiCall(Lat: Double , long: Double){
        self.view.endEditing(true)
       // appInstance.showLoader()
        let param : [String : Any] = [
             p_longitude  :long,
             p_latitude : Lat
            ]
        print(param)
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
         print(headers)
        Alamofire.request(baseURL+Endpoint.UpdateLocation.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                //  appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                    print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "USRLOCUPD" {
                      //  Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                        self.GetNearBySupplierAPiCall()
                    }else{
                        appInstance.hideLoader()
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
                appInstance.hideLoader()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }
    func GetNearBySupplierAPiCall(){
        self.view.endEditing(true)
    //    appInstance.showLoader()
//        let param : [String : Any] = [
//            p_radiusRange  : SliderValurLabel.text!,
//            ]
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
       // print(headers)
        Alamofire.request(baseURL+Endpoint.GetNearBySupllier.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                //appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                     print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "NRBYLORY" {
                      //  Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                       // print(jsonobj["data"] as? NSDictionary ?? "")
                        appInstance.hideLoader()
                        if  let lorrydatadic = jsonobj["data"] as? NSDictionary , let lorrycount = lorrydatadic["count"] as? NSNumber {
                            self.lorrycuntlbl.text = "\(lorrycount)"
                        }
                        
                    }else{
                        appInstance.hideLoader()
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
                appInstance.hideLoader()
               // print()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }

    //MARK:- ---------------- CLICK EVENTS ------------------
    @IBAction func MenuButtonClick(_ sender: Any) {
        self.view.endEditing(true)
        setupDefaultDropDown()
        MenuDropdown.show()
    }
    @IBAction func ReqGrabLorryBtnClick(_ sender: Any) {
        let resultVc = self.storyboard?.instantiateViewController(withIdentifier: "ReqGrabLorryVC") as! ReqGrabLorryVC
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(resultVc, animated: true)
    }
    @IBAction func RadiusUpdatebtnclick(_ sender: Any) {
        PopupBackView.isHidden = true
        RadiusPopup.isHidden = true
        ChangeRadiusAPiCall()
    }
    @IBAction func SliderValueChnage(_ sender: AnyObject) {
        let value = Int(RadusSlider.value)
        SliderValurLabel.text = "\(value)"
        Defaults.set(SliderValurLabel.text!, forKey: "dlfradius")
        Defaults.synchronize()
    }
    //MARK:- ---------------- SearchBar Delegate Method ------------------
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        PlaceSearchbar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PlaceSearchbar.endEditing(true)
        searchActive = false;
        
        if (searchBar.text?.isEmpty)! {
            self.LocationUpdateAPiCall(Lat:currentlatstring, long: currentlongstring)
            PlaceSearchbar.endEditing(true)
        }else{
            appInstance.showLoader()
            let address = searchBar.text!
            
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        // handle no location found
                         appInstance.hideLoader()
                        Utilities.showErrorMessage(text:ValidAddressMessage)
                        print(error?.localizedDescription ?? "aaaa")
                        return
                }
               // print("Lat: \(location.coordinate.latitude) -- Long: \(location.coordinate.longitude)")
                self.LocationUpdateAPiCall(Lat:location.coordinate.latitude, long: location.coordinate.longitude)
                
                // Use your location
            }
          }
        }
    
   

   

    
}
