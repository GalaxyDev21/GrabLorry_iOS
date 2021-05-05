//
//  FDView.swift

import UIKit
@IBDesignable
class zwView : UIImageView {
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    
    var shadowLayer: CAShapeLayer!
    
//    private var _round = false
//    @IBInspectable var round: Bool{
//        set{
//            _round = newValue
//            makeRound()
//        }
//        get{
//            return self._round
//        }
//    }
//
//    private func makeRound(){
//        if self.round == true{
//            self.clipsToBounds = true
//            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
//
//        }
//        else{
//            self.layer.cornerRadius = 0
//        }
//    }
//
//
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
           // layer.masksToBounds = true
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            //layer.masksToBounds = true
        }
    }
//
    @IBInspectable var shadowone : Bool = false {
        didSet{
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 0.06
//            layer.shadowOffset = CGSize.zero
//            layer.shadowRadius = 12.0
//
//            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
           // layer.shouldRasterize = true
            
            
//            shadowLayer = CAShapeLayer()
//            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 35).cgPath
//            shadowLayer.fillColor = UIColor.clear.cgColor
//
//            shadowLayer.shadowColor = UIColor.darkGray.cgColor
//            shadowLayer.shadowPath = shadowLayer.path
//            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 15.0)
//            shadowLayer.shadowOpacity = 0.08
//            shadowLayer.shadowRadius = 8
//
//            layer.insertSublayer(shadowLayer, at: 0)
            
            shadowLayer = CAShapeLayer()
           // layer.masksToBounds = false
            shadowLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 12.0)
            shadowLayer.shadowRadius = 12.0
            shadowLayer.shadowOpacity = 0.2
            let trianglePath = UIBezierPath()
            
            trianglePath.move(to: CGPoint(x: 15, y: 0))
            trianglePath.addLine(to: CGPoint(x: 15, y: frame.size.height))
            trianglePath.addLine(to: CGPoint(x: frame.size.width - 15, y: frame.size.height))
            trianglePath.addLine(to: CGPoint(x: frame.size.width - 15, y: 0))
            trianglePath.close()
            
            shadowLayer.shadowPath = trianglePath.cgPath
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    @IBInspectable var shadowtwo : Bool = false {
        didSet{
            //            layer.shadowColor = UIColor.black.cgColor
            //            layer.shadowOpacity = 0.06
            //            layer.shadowOffset = CGSize.zero
            //            layer.shadowRadius = 12.0
            //
            //            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            // layer.shouldRasterize = true
            
            
            //            shadowLayer = CAShapeLayer()
            //            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 35).cgPath
            //            shadowLayer.fillColor = UIColor.clear.cgColor
            //
            //            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            //            shadowLayer.shadowPath = shadowLayer.path
            //            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 15.0)
            //            shadowLayer.shadowOpacity = 0.08
            //            shadowLayer.shadowRadius = 8
            //
            //            layer.insertSublayer(shadowLayer, at: 0)
            
            shadowLayer = CAShapeLayer()
            // layer.masksToBounds = false
            shadowLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            shadowLayer.shadowRadius = 6.0
            shadowLayer.shadowOpacity = 0.2
            let trianglePath = UIBezierPath()
            
            trianglePath.move(to: CGPoint(x: 15, y: 0))
            trianglePath.addLine(to: CGPoint(x: 15, y: frame.size.height))
            trianglePath.addLine(to: CGPoint(x: frame.size.width - 35, y: frame.size.height))
            trianglePath.addLine(to: CGPoint(x: frame.size.width - 35, y: 0))
            trianglePath.close()
            
            shadowLayer.shadowPath = trianglePath.cgPath
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
 
         //   layer.shadowColor = #colorLiteral(red: 0.2039215686, green: 0.3294117647, blue: 0.4784313725, alpha: 1)
//            layer.shadowOffset = CGSize(width:0, height:12);
//            layer.shadowOpacity = 0.06;
//            layer.shadowRadius = 12.0;
//            layer.masksToBounds = false;
        }
    }
    
    
    @IBInspectable var topColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
//    @IBInspectable var topBorderColor : UIColor = UIColor.clear
//    @IBInspectable var topBorderHeight : CGFloat = 0 {
//        didSet{
//            if topBorder == nil{
//                topBorder = UIView()
//                topBorder?.backgroundColor=topBorderColor;
//                topBorder?.frame = CGRect(x: 0,y: 0,width: self.frame.size.width,height: topBorderHeight)
//                addSubview(topBorder!)
//            }
//        }
//    }
//    @IBInspectable var bottomBorderColor : UIColor = UIColor.clear
//    @IBInspectable var bottomBorderHeight : CGFloat = 0 {
//        didSet{
//            if bottomBorder == nil{
//                bottomBorder = UIView()
//                bottomBorder?.backgroundColor=bottomBorderColor;
//                bottomBorder?.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorderHeight, width: self.frame.size.width, height: bottomBorderHeight)
//                addSubview(bottomBorder!)
//            }
//        }
//    }
//    @IBInspectable var leftBorderColor : UIColor = UIColor.clear
//    @IBInspectable var leftBorderHeight : CGFloat = 0 {
//        didSet{
//            if leftBorder == nil{
//                leftBorder = UIView()
//                leftBorder?.backgroundColor=leftBorderColor;
//                leftBorder?.frame = CGRect(x: 0, y: 0, width: leftBorderHeight, height: self.frame.size.height)
//                addSubview(leftBorder!)
//            }
//        }
//    }
//    @IBInspectable var rightBorderColor : UIColor = UIColor.clear
//    @IBInspectable var rightBorderHeight : CGFloat = 0 {
//        didSet{
//            if rightBorder == nil{
//                rightBorder = UIView()
//                rightBorder?.backgroundColor=topBorderColor;
//                rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight, y: 0, width: rightBorderHeight, height: self.frame.size.height)
//                addSubview(rightBorder!)
//            }
//        }
//    }
//    override func layoutSubviews() {
//        if topBorder != nil{
//            topBorder?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: topBorderHeight)
//        }
//        if bottomBorder != nil{
//            bottomBorder?.frame = CGRect(x: 0, y: self.frame.height - bottomBorderHeight, width: self.frame.size.width, height: bottomBorderHeight)
//        }
//    }
//    override func draw(_ rect: CGRect) {
//        if topBorder != nil{
//            topBorder?.frame = CGRect(x: 0, y: 0, width: rect.width, height: topBorderHeight)
//        }
//        if bottomBorder != nil{
//            bottomBorder?.frame = CGRect(x: 0, y: rect.height - bottomBorderHeight, width: rect.size.width, height: bottomBorderHeight)
//        }
//    }
}
