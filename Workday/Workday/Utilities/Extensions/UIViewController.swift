    //
//  UIView.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import UIKit

extension UIViewController{
    
    func showAlert(withMessage message:String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            completion?()
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
