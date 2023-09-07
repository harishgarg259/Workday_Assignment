//
//  UITableView.swift
//  Workday
//
//  Created by Harish Garg on 27/08/23.
//

import Foundation
import UIKit


extension UITableViewCell: Reusable {}

protocol Reusable {}
extension Reusable where Self: UITableViewCell {
    static var nameId: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(UINib(nibName: cellClass.nameId, bundle: nil), forCellReuseIdentifier: cellClass.nameId)
    }
}
