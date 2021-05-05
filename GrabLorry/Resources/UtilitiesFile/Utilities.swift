//
//  Utilities.swift
//  SmilingTummy
//
//  Created by Peerbit's iMac on 07/12/15.
//  Copyright © 2015 Peerbits. All rights reserved.
//

import Foundation
import UIKit
import KSToastView

class Utilities {
    
    // MARK: Load View Controller from Story Board
    
    class func viewController(_ name: String, onStoryboard storyboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name) 
    }
    
    
    class func viewTableController(_ name: String, onStoryboard storyboardName: String) -> UITableViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: name) as! UITableViewController
    }
    
    //MARK : Check DeviceType
    
    func isiPad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }
    
    // MARK : Validation
    
    
    class func isValidUser(textfield : String)  -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "[A-Za-z\\s]{2,20}")
        let result = passwordTest.evaluate(with: textfield)
       
        return result
    }

    class func isValidLastName(textfield : String)  -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", "[A-Za-z\\s]{3,20}")
        let result = passwordTest.evaluate(with: textfield)
        
        return result
    }
    
    class func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        //"(?=^.{6,12}$)(?=(.*\\d))(?=(.*[A-Za-z]){2})(?!.*[\\s])^.*"
    }
    
    class func isValidNickname(_ testStr:String) -> Bool {
        let nickEx = "(?=^.{8,20}$)(?=(.*\\d))(?=(.*[A-Za-z]){6})(?=(.*[0-9]){2})(?!.*[\\s])^.*"
        let nickTest = NSPredicate(format:"SELF MATCHES %@", nickEx)
        let result = nickTest.evaluate(with: testStr)
        return result
    }

    
    class func validatemobilenumber(textfield : UITextField)  -> Bool
    {
        if (textfield.text?.isEmpty)!
        {
         //   showErrorMessage(text: prefix + " " + (textfield.placeholder?.lowercased())!)
            return false
            
        }else if ((textfield.text?.count)! < 9){
             return false
        }

        return true
    }

    
//    class func isValidPassword(_ testStr:String) -> Bool {
//        let emailRegEx = "^(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
//        let passwordTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = passwordTest.evaluate(with: testStr)
//        return result
//        
//    }

    class func isValidPassword(testStr:String) -> Bool {
        
        if (testStr.count >= 6)   {
            return true
        }
        else{
            return false
        }
    }
    
    class func isValidRegex(testStr:String , regex: String) -> Bool {
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", regex)
        let result = passwordTest.evaluate(with: testStr)
        return result
        
    }
    
    class func trimWhiteSpaces(_ text : String)-> String
    {
        return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as String
    }
    
    class func showErrorMessage(text:String)
    {
        /// show NSString
        KSToastView.ks_showToast(text)
        /// show NSObject description with 2 seconds.
        KSToastView.ks_showToast(self, duration: 2.0)
        
        /// show with a completion block.
        KSToastView.ks_showToast(text, duration: 3.0, completion: {() -> Void in
            print("\("End!")")
        })
        
    }


    
    class func localDateFromUTC(timestamp: Int64) -> NSDate {
        let utcDate = NSDate(timeIntervalSince1970: Double(timestamp))
        let localTimeZoneInSeconds : Double = 0.0//Double(NSTimeZone.localTimeZone().secondsFromGMT)
        let localDate = utcDate.addingTimeInterval(localTimeZoneInSeconds)
        return localDate
    }
    
    class func getFormatedDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedmonthDateInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM"//"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    class func getFormatedDateYearInString(dateTime : NSDate) -> String {
        let fmDate = DateFormatter()
        fmDate.dateFormat = "dd MMM, YYYY" //"dd-MM-YYYY"
        return fmDate.string(from: dateTime as Date)
    }
    
    
    class func getFormatedTimeInString( dateTime : NSDate) -> String {
        
//        let totalSeconds = self.getTimeStampInTimeStamp(datetimestamp: dateTime)
//        let seconds: Int = totalSeconds % 60
//        let minutes: Int = (totalSeconds / 60) % 60
//        let hours: Int = totalSeconds / 3600
//        print(String(format: "%02d:%02d:%02d", hours, minutes, seconds))
        
        
        let fmDate = DateFormatter()
        fmDate.dateFormat = "hh:mm a"
        
        
        return fmDate.string(from: dateTime as Date)
    }
    
    class func timeFormatFromSeconds (seconds : Double) -> String {
//        let timeZoneOffset = Double(NSTimeZone.local.secondsFromGMT())// as TimeInterval
//        let interval = Date().timeIntervalSince1970 + timeZoneOffset + seconds
//        let dateTime = Date(timeIntervalSince1970: interval) as NSDate
//        
//        let fmDate = DateFormatter()
//        fmDate.dateFormat = "hh:mm a"
//        return fmDate.string(from: dateTime as Date)
  
        let seconds = Int(seconds)
        let sec: Int = seconds % 60
        let minutes: Int = (seconds / 60) % 60
        let hours: Int = seconds / 3600

        print(String(format: "%02d:%02d:%02d", hours, minutes, sec))
        
        if hours == 12
        {
            return (String(format:"%02d:%02d PM", hours, minutes))
            
        }else if hours > 12
        {
            if hours == 24
            {
                return (String(format:"00:%02d AM", minutes))
                
            }else{
             return (String(format:"%02d:%02d PM", hours - 12 , minutes))
            }
        }else{
            
            return (String(format:"%02d:%02d AM", hours , minutes))
        }
        
    }


    
    class func timeFormatFromSecondsintwenty (seconds : Double) -> String {
        //        let timeZoneOffset = Double(NSTimeZone.local.secondsFromGMT())// as TimeInterval
        //        let interval = Date().timeIntervalSince1970 + timeZoneOffset + seconds
        //        let dateTime = Date(timeIntervalSince1970: interval) as NSDate
        //
        //        let fmDate = DateFormatter()
        //        fmDate.dateFormat = "hh:mm a"
        //        return fmDate.string(from: dateTime as Date)
        
        let seconds = Int(seconds)
       // let sec: Int = seconds % 60
        let minutes: Int = (seconds / 60) % 60
        let hours: Int = seconds / 3600
        
        return (String(format: "%02d:%02d", hours, minutes))
    }
    
    
    
    
    class func ConvertDateToUTC(date: NSDate) -> NSDate {
        
        let timeZoneOffset = Double(NSTimeZone.local.secondsFromGMT())// as TimeInterval
        let interval = date.timeIntervalSince1970 + timeZoneOffset
        return Date(timeIntervalSince1970: interval) as NSDate
        // You could also use the systemTimeZone method
        //let gmtTimeInterval: TimeInterval = date.timeIntervalSinceReferenceDate - timeZoneOffset - 19800
        // return Date(timeIntervalSinceReferenceDate: gmtTimeInterval) as NSDate
        
    }
    
    //Rajyaguru
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width : width,height : CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    
    
    class func getTimeStampInTimeStamp(datetimestamp : NSDate) -> Int64
    {
        let calender = NSCalendar.current
        
        let Cur_Date = calender.startOfDay(for: datetimestamp as Date)
        
        print(Cur_Date)
        
        print(Cur_Date.timeIntervalSince1970.description)
        
        return Int64(Cur_Date.timeIntervalSince1970)
    }
    
    class func daysBetweenDates(estiDate : Date,endDate: Date) -> Int
    {
        let calendar: Calendar = Calendar.current
        let date1 = calendar.startOfDay(for: estiDate) //Date())
        let date2 = calendar.startOfDay(for: endDate)
        return calendar.dateComponents([.day], from: date1, to: date2).day!
    }

    
    //  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
    
    class func resize(_ image: UIImage) -> UIImage {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1024.0
        let maxWidth: Float = 720.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: Data? = UIImageJPEGRepresentation(img!, CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }


    class func BorderForCellView(view : UIView)
    {
        
        let shadowView = view//UIView(frame: view.frame)
        shadowView.layer.shadowColor = UIColor(red: 64.0/255.0, green: 74.0/255.0, blue: 92.0/255.0, alpha: 1).cgColor
            
        shadowView.layer.shadowOffset = CGSize()
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 3
        shadowView.layer.cornerRadius = 10.0
        //shadowView.clipsToBounds = true
        
        let view = UIView(frame: shadowView.bounds)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        
        //shadowView.addSubview(view)
        view.sendSubview(toBack: shadowView)//(toFront: view)
        //superview.addSubview(shadowView)

    }
    
    class func BorderForView(view : UIView)
    {
        // view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor(red: 228.0/255.0, green: 234.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
        view.layer.borderWidth = 1.0
        view.clipsToBounds = true
    }
    
    class func BorderForTextFieldView(view : UIView)
    {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 4.0
    }
    
    
    class func secondsToHoursMinutesSeconds (seconds : Double) -> (Int, Int, Int) {
        let (hr,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return (Int(hr), Int(min), 60 * Int(secf))
    }
    
  class func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height:  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
      let rect = CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    return newImage!
    }
    
}

