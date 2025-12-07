//
//  UITableView+dequeueCell.swift
//  UIKitHomework
//
//  Created by Andrew on 27.07.2025.
//

import UIKit

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        else { fatalError("Fatal error for cell at \(indexPath)") }
        
        return cell
    }
    
//    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> UIView {
        //        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseId) as? T else {
        //            fatalError("Could not dequeue header/footer \(T.self)")
        //        }
        //        return view
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(ofType type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }
}
