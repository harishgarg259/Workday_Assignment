//
//  DateFormat.swift
//  Workday
//
//  Created by Harish Garg on 29/08/23.
//

import Foundation

enum DateFormates:String{
    case mmmdCommayyyy = "MMM d, yyyy"
}

extension String {
    
    func getFormattedDate(format: DateFormates) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format.rawValue
        
        let date: Date? = dateFormatterGet.date(from: self)
        if let date = date{
            print("Date",dateFormatterPrint.string(from: date))
            return dateFormatterPrint.string(from: date);
        }else
        {
            //Return Current Date
            print("Date",dateFormatterPrint.string(from: Date()))
            return dateFormatterPrint.string(from: Date());
        }
    }
}
