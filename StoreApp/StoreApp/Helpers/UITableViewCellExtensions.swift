//
//  UITableViewCellExtensions.swift
//  StoreApp
//
//  Created by Scizor on 15/11/20.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
extension UITableViewCell: Reusable { }

