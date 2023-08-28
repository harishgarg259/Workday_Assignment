//
//  RequestUrl.swift
//  Workday
//
//  Created by Harish Garg on 26/08/23.
//

import Foundation

enum RequestUrl :String{
    
    //App Base URL
    static var BaseURL = "https://images-api.nasa.gov"
    
    //Complete API url
    var url : String{ return RequestUrl.BaseURL + self.rawValue }
    
    
    
    //Nasa Apis
    case searchImages = "/search"
    
}
