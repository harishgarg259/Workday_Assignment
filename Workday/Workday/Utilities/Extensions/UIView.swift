    //
//  UIView.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import UIKit
extension UIView{
    
    @IBInspectable var cornerRadius: CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat{
        get{
            layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor{
        get{
            UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set{
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = self.layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.shadowColor = newValue?.cgColor }
    }
}
