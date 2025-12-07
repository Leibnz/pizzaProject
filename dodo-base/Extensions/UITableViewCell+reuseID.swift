//
//  UITableViewCell+reuseID.swift
//  UIKitHomework
//
//  Created by Andrew on 27.07.2025.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseId: String {
        return String.init(describing: self)
    }
}
