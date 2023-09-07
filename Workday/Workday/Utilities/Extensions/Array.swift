//
//  Array.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}
