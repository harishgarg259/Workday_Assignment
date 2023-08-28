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
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    func registerCellClass<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.nameId)
    }
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(UINib(nibName: cellClass.nameId, bundle: nil), forCellReuseIdentifier: cellClass.nameId)
    }
    
    func registerCellClasses<Cell: UITableViewCell>(_ cellClasses: [Cell.Type]) {
        for cellClass in cellClasses {
            register(UINib(nibName: cellClass.nameId, bundle: nil), forCellReuseIdentifier: cellClass.nameId)
        }
    }
}
