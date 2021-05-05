//
//  ReqGrabLorryVC.swift
//  GrabLorry
//
//  Created by Sumit Parmar on 11/05/18.
//  Copyright © 2018 Sumit Parmar. All rights reserved.
//

import UIKit
import Alamofire

class ReqGrabLorryVC: UIViewController ,UIPickerViewDataSource, UIPickerViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextViewDelegate , UITextFieldDelegate {
   
    //MARK:- ---------------- IBOUTLETS ------------------
    @IBOutlet var AdonColView: UICollectionView!
    @IBOutlet var SelectTypeTxt: UITextField!
    @IBOutlet var SelectAggregatesTxt: UITextField!
    @IBOutlet var Howmanylorriestxt: UITextField!
    @IBOutlet var AddressTxtview: UITextView!
    @IBOutlet var NotesTxt: UITextView!
    @IBOutlet var Dateandtimetxt: UITextField!
    @IBOutlet var TripsTxt: UITextField!
    
    @IBOutlet var OrderTotalLbl: UILabel!
    //MARK:- ---------------- Objects And Variable------------------
   // var addonarrat : [NSDictionary] = []
    var aggregatesarray =  [[String: AnyObject]]()
    var typearray =  [[String: AnyObject]]()
    let AggregatesPicker = UIPickerView()
    let TypeSelectionPicker = UIPickerView()
    var TextviewCheck = Bool()
    var addonarrat = [[String: AnyObject]]()
    var addonflag = String()
    var selectaggregatesindex = Int()
    var variableodertotal =  Float()
    var selectedaggegateid = String()
    var selectedtypeid = String()
    //MARK:- ---------------- VIEW DID LOAD METHOD ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Request a Grab Lorry"
        self.GetALLFormFieldsApiCall()
        PickerviewSetup()
        AddressTxtview.text = "Address"
        AddressTxtview.textColor = UIColor.lightGray
        AddressTxtview.selectedTextRange = AddressTxtview.textRange(from: AddressTxtview.beginningOfDocument, to: AddressTxtview.beginningOfDocument)
        
        NotesTxt.text = "Leave Note(optional)"
        NotesTxt.textColor = UIColor.lightGray
        NotesTxt.selectedTextRange = NotesTxt.textRange(from: NotesTxt.beginningOfDocument, to: AddressTxtview.beginningOfDocument)
        
        
        addonflag = "0"
        OrderTotalLbl.text = "Order Total"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden  = false
    }
     //MARK:- ---------------- VOID METHODS ------------------
    func PickerviewSetup(){
        AggregatesPicker.delegate = self
        AggregatesPicker.tag = 1
        SelectAggregatesTxt.inputView = AggregatesPicker
        TypeSelectionPicker.delegate = self
        TypeSelectionPicker.tag = 2
        SelectTypeTxt.inputView = TypeSelectionPicker
        toolbarsetup()
    }
    func toolbarsetup(){
        let toolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6, width:self.view.frame.size.width,height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.white
        
        let defaultButton = UIBarButtonItem(title: "Cancle", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ReqGrabLorryVC.tappedToolBarBtn))
        
     //   let defaultButton1 = UIBarButtonItem(title: "Select Grab Lorry", style: UIBarButtonItemStyle.plain, target: self, action: nil)
     //    let defaultButton2 = UIBarButtonItem(title: "Select Aggrgates", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ReqGrabLorryVC.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
       
       
        toolBar.setItems([defaultButton,flexSpace,flexSpace,doneButton], animated: true)
        SelectAggregatesTxt.inputAccessoryView = toolBar
        SelectTypeTxt.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        SelectAggregatesTxt.resignFirstResponder()
        SelectTypeTxt.resignFirstResponder()
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
      //  pickerTextField.text = "one"
        SelectAggregatesTxt.resignFirstResponder()
        SelectTypeTxt.resignFirstResponder()
    }
    func Validate() -> Bool {
        if (SelectTypeTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: SelectTypeMessage)
            return false
        }
        if SelectTypeTxt.text  == "----- Select Grab Lorry -----"{
            Utilities.showErrorMessage(text: SelectTypeMessage)
            return false
        }
        if (SelectAggregatesTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: SelectAggregatesMessage)
            return false
        }
        if SelectAggregatesTxt.text == "----- Select Aggregates -----"{
            Utilities.showErrorMessage(text: SelectAggregatesMessage)
            return false
        }
        if (Howmanylorriestxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: SelectLorriesquantityMessage)
            return false
        }
        if (TripsTxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: SelectTrips)
            return false
        }
        if (Dateandtimetxt.text?.isEmpty)!{
            Utilities.showErrorMessage(text: SelectDateAndTime)
            return false
        }
//        if (AddressTxtview.text?.isEmpty)!{
//            Utilities.showErrorMessage(text: SelectAddressMessage)
//            return false
//        }
//        if AddressTxtview.text == "Address" {
//            Utilities.showErrorMessage(text: SelectAddressMessage)
//            return false
//        }
        if (TextviewCheck) != true {
            Utilities.showErrorMessage(text: SelectAddressMessage)
            return false
        }
//        if (NotesTxt.text?.isEmpty)!{
//            Utilities.showErrorMessage(text: SelectNotesMessage)
//            return false
//        }
//        if addonflag == "0"{
//            Utilities.showErrorMessage(text: SelectAddonMessage)
//            return false
//        }
        return true
    }
    //MARK:- ---------------- Api Call ------------------
    func GetALLFormFieldsApiCall(){
        self.view.endEditing(true)
       appInstance.showLoader()
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
        Alamofire.request(baseURL+Endpoint.getallformfield.rawValue, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
               appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                   print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "SUCCESS" {
                       if let datadic = jsonobj["data"] as? NSDictionary{
                        self.addonarrat = datadic["arrAddons"] as! [NSDictionary] as! [[String : AnyObject]]
                     //   self.aggregatesarray = datadic["arrAggregates"]  as! NSArray
                      //  self.typearray = datadic["arrType"]  as! NSArray
                        let dmidatadic :[String : AnyObject] = [
                            "id" : "0" as AnyObject,
                            "name" : "----- Select Aggregates -----" as AnyObject
                        ]
                        self.aggregatesarray.append(dmidatadic)
                        let temparray = datadic["arrAggregates"] as! [[String : AnyObject]]
                         for i in 0..<temparray.count {
                           self.aggregatesarray.append(temparray[i])
                        }
                       // print(self.aggregatesarray)
                        let dmidatadic1 :[String : AnyObject] = [
                            "id" : "0" as AnyObject,
                            "name" : "----- Select Grab Lorry -----" as AnyObject
                        ]
                        self.typearray.append(dmidatadic1)
                        let temparray1 = datadic["arrType"] as! [[String : AnyObject]]
                        for i in 0..<temparray1.count {
                            self.typearray.append(temparray1[i])
                        }
                        for i in 0..<self.addonarrat.count {
                            var dict = self.addonarrat[i]
                            dict["image"] = "0" as AnyObject
                            self.addonarrat[i] = dict
                        }
                         //print(self.addonarrat)
                        if self.addonarrat.count > 0 {
                             self.AdonColView.reloadData()
                        }
                        }
                    }else{
                        Utilities.showErrorMessage(text: (jsonobj["error"] as? String)!)
                    }
                }
            }else{
               // appInstance.hideLoader()
                Utilities.showErrorMessage(text: SomethingWentWrongMessage)
            }
        }
    }
    func RequestApiCall(){
        self.view.endEditing(true)
        appInstance.showLoader()
        let deviceid = UIDevice.current.identifierForVendor!.uuidString
        let headers: HTTPHeaders = [
            p_Headername:deviceid,
            p_Authorization:(GetUserDetails()?.apikey)!
        ]
        let param : [String : Any] = [
            p_recid : (GetUserDetails()?.recid)!,
            p_type : selectedtypeid,
            p_aggregates : selectedaggegateid,
            p_quantity : Howmanylorriestxt.text!,
            p_trip : TripsTxt.text!,
            p_date_and_time : Dateandtimetxt.text!,
            p_address : AddressTxtview.text! ,
            p_notes : NotesTxt.text!,
            p_addon_id : addonflag,
            p_ordetotal: variableodertotal
        ]
       print(param)
        Alamofire.request(baseURL+Endpoint.GrabLorryReqpost.rawValue, method: .post, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            // print("RESPONSE \(response)")
            if((response.result.value) != nil)
            {
                appInstance.hideLoader()
                if let json = response.result.value {
                    let jsonobj = json as! NSDictionary
                    print(jsonobj)
                    if jsonobj["flagMsg"] as? String == "REQACCEPT" {
                        let resultvc = self.storyboard?.instantiateViewController(withIdentifier: "RequestSentVC") as! RequestSentVC
                        //  resultvc.SelectedDatadic = datadic as NSDictionary
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
    //MARK:- ---------------- CollectionVIew Delegate And DataSOurce Method------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addonarrat.count
       // return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddonCell", for: indexPath) as! AddonCell
        
        var datadic = addonarrat[indexPath.row]
        if let carttagnumber = datadic["image"] as? String {
            if carttagnumber  == "0"{
                 cell.tickmarkimage.isHidden = true
            }else{
                 cell.tickmarkimage.isHidden = false
            }
        }
        
       if let titlestring = datadic["productname"] as? String{
            cell.titlelbl.text = titlestring
        }
      //  cell.tickmarkimage.isHidden = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cartstatus = String()
        var datadic = addonarrat[indexPath.row]
        if let carttagnumber = datadic["image"] as? NSString {
            cartstatus = carttagnumber as String
          //  print(cartstatus)
        }
        if cartstatus == "0"{
             for i in 0..<self.addonarrat.count {
                if indexPath.row == i {
                    var dict = self.addonarrat[indexPath.row]
                    dict["image"] = "1" as AnyObject
                    self.addonarrat[indexPath.row] = dict
                    if let recid  = dict["recid"] as? String{
                        addonflag = recid
                        self.view.endEditing(true)
                        let resultvc = self.storyboard?.instantiateViewController(withIdentifier: "AddonDetailsVC") as! AddonDetailsVC
                        resultvc.SelectedDatadic = datadic as NSDictionary
                        self.navigationController?.pushViewController(resultvc, animated: true)
                    }
                }else{
                    var dict = self.addonarrat[i]
                    dict["image"] = "0" as AnyObject
                    self.addonarrat[i] = dict
                }
            }
        }
        else{
             for i in 0..<self.addonarrat.count {
                var dict = self.addonarrat[i]
                dict["image"] = "0" as AnyObject
                self.addonarrat[i] = dict
            }
            addonflag = "0"
         
        }
      //  print("addonid=\(addonflag)")
         self.AdonColView.reloadData()
          if let pricevalue = datadic["price"] as? String , let quantityvalue = Howmanylorriestxt.text {
                let price = pricevalue.floatValue
                let quntity = quantityvalue.floatValue
             var total = Float()
        
            if addonflag == "0"{
             //  Howmanylorriestxt.text = "0"
               total = 0
            }else if quntity == 0{
              //  Howmanylorriestxt.text = "1"
                total = price
            }else{
                 total =  price * quntity
            }
             variableodertotal = total
             OrderTotalLbl.text = "Order Total £\(total) + GrabLorry"
            }
        selectaggregatesindex = indexPath.row
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        if (Device.IS_IPHONE_5 || Device.IS_IPHONE_4_OR_LESS ){
//            return CGSize(width: UIScreen.main.bounds.width / 1.5 - 10 , height: 150)
//        }else{
//            return CGSize(width: UIScreen.main.bounds.width / 1.5 - 20 , height: 167)
//        }
        return CGSize(width: UIScreen.main.bounds.width / 4 - 5 , height: 61)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    //MARK:- ---------------- Picker VIew Delegate And DataSOurce Method------------------
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return aggregatesarray.count
        }
        if pickerView.tag == 2 {
            return typearray.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            var datadic = self.aggregatesarray[row]
            return datadic["name"] as? String
         }
        if pickerView.tag == 2 {
            var datadic = self.typearray[row]
            return datadic["name"] as? String
        }
        return nil
    }
    @IBAction func RequestButtonclick(_ sender: Any) {
        if Validate(){
           // Utilities.showErrorMessage(text: "Working on it")
            RequestApiCall()
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
          var datadic = self.aggregatesarray[row]
          SelectAggregatesTxt.text = datadic["name"] as? String
            selectedaggegateid = datadic["id"] as! String
        }
        if pickerView.tag == 2 {
         var datadic = self.typearray[row]
         SelectTypeTxt.text = datadic["name"] as? String
            selectedtypeid = datadic["id"] as! String
        }
      //  print(selectedaggegateid)
     //   print(selectedtypeid)
    }
    
    @IBAction func datetimepicktexfieldclick(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        //   datePickerView.datePickerMode = UIDatePickerMode.date
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.minimumDate = NSDate() as Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ReqGrabLorryVC.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "YY-MM-dd hh:mm"
        
        Dateandtimetxt.text = dateFormatter.string(from: sender.date)
    }
    
    //MARK:----- UITEXTVIEW DELAGTE METHOD -----
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == AddressTxtview {
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
            if updatedText.isEmpty {
                textView.text = "Address"
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
                TextviewCheck = false
                return false
            }
            else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.text = nil
                textView.textColor = UIColor.black
                TextviewCheck = true
            }
        }else{
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
            if updatedText.isEmpty {
                textView.text = "Leave note"
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
               // TextviewCheck = false
                return false
            }
            else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.text = nil
                textView.textColor = UIColor.black
                //TextviewCheck = true
            }
        }
        return true
    }
       
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == Howmanylorriestxt {
          
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
              //  print(updatedText)
                
                var total = Float()
                let quntity = updatedText
                let quntityval =  quntity.floatValue
               // print(selectaggregatesindex)
                
                if addonflag == "0"{
                    total = 0
                }else if quntityval == 0{
                   // print(self.aggregatesarray[selectaggregatesindex])
                     let datadic = self.addonarrat[selectaggregatesindex]
                    if let pricevalue = datadic["price"] as? String {
                        let price = pricevalue.floatValue
                       total = price
                    }
                }else{
                     let datadic = self.addonarrat[selectaggregatesindex]
                     if let pricevalue = datadic["price"] as? String {
                        let price = pricevalue.floatValue
                         total =  price * quntityval
                    }
                   
                }
                variableodertotal = total
                OrderTotalLbl.text = "Order Total £\(total) + GrabLorry"
            
            }
        }
        return true
    }
    
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
