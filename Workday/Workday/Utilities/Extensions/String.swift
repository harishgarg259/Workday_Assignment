//
//  String.swift
//  Workday
//
//  Created by Harish Garg on 31/08/23.
//

import Foundation

extension String{
    
    /// Localized string for key.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
