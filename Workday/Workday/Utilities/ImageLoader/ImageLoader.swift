//
//  ImageLoader.swift
//  Workday
//
//  Created by Harish Garg on 28/08/23.
//


import UIKit
import Foundation


class ImageLoader {
    
    let cache = NSCache<NSString, AnyObject>()

    class var sharedLoader : ImageLoader {
    struct Static {
        static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    
	func imageForUrl(urlString: String?, placeholder: String, completionHandler: @escaping (_ image: UIImage?, _ url: String) -> ()) {
		
        let encodedURL = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

		DispatchQueue.global(qos: .background).async {
		
            if encodedURL.isEmpty{
                let placeHolderImage = UIImage(named: placeholder)
                DispatchQueue.main.async {
                    completionHandler(placeHolderImage, encodedURL)
                }
            }
			let data: NSData? = self.cache.object(forKey: encodedURL as NSString) as? NSData
			
			if let goodData = data {
				let image = UIImage(data: goodData as Data)
				DispatchQueue.main.async {
					completionHandler(image, encodedURL)
				}
				return
			}
			
			let session = URLSession.shared
			let request = URLRequest(url: URL(string: encodedURL)!)
			
			session.dataTask(with: request) { data, response, error in
				
				if (error != nil) {
					completionHandler(nil, encodedURL)
					return
				}
				
				if let data = data{
					let image = UIImage(data: data)
					self.cache.setObject(data as AnyObject, forKey: encodedURL as NSString)
					DispatchQueue.main.async {
						completionHandler(image, encodedURL)
					}
                }else{
                    let placeHolderImage = UIImage(named: "logo")
                    DispatchQueue.main.async {
                        completionHandler(placeHolderImage, encodedURL)
                    }
                }
			}.resume()
			
		}
	}
}
