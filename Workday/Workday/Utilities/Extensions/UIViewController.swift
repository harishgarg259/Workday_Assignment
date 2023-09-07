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


extension UIViewController {
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func pushTo(screen:UIViewController,isAnimated:Bool? = true){
        self.navigationController?.pushViewController(screen, animated: isAnimated ?? true)
    }
    
    func performSegueToReturnBack(isAnimate: Bool = true)
    {
        if let nav = self.navigationController {
            nav.popViewController(animated: isAnimate)
        } else {
            self.dismiss(animated: isAnimate, completion: nil)
        }
    }
}

enum AppStoryboard : String {
    
   //Please add case exact with the storyboard name
    case Main

    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
}
