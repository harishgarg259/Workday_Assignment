//
//  UITextFieldExtension.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import UIKit


//MARK: @IBInspectable
extension UITextView {

    @IBInspectable var topPadding: CGFloat {
        get {
            return contentInset.top
        }
        set {
            self.contentInset = UIEdgeInsets(top: newValue,
                                             left: self.contentInset.left,
                                             bottom: self.contentInset.bottom,
                                             right: self.contentInset.right)
        }
    }

    @IBInspectable var bottomPadding: CGFloat {
        get {
            return contentInset.bottom
        }
        set {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top,
                                             left: self.contentInset.left,
                                             bottom: newValue,
                                             right: self.contentInset.right)
        }
    }

    @IBInspectable var leftPadding: CGFloat {
        get {
            return contentInset.left
        }
        set {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top,
                                             left: newValue,
                                             bottom: self.contentInset.bottom,
                                             right: self.contentInset.right)
        }
    }

    @IBInspectable var rightPadding: CGFloat {
        get {
            return contentInset.right
        }
        set {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top,
                                             left: self.contentInset.left,
                                             bottom: self.contentInset.bottom,
                                             right: newValue)
        }
    }
}

//MARK: Extended Functions
extension UITextField {
    
    func hasText() -> Bool{
        guard let criteria = self.text, !criteria.isEmpty ,!criteria.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
}
