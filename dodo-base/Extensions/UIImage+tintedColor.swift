//
//  UIImage+TintColour.swift
//  UIKitHomework
//
//  Created by Andrew on 12.09.2025.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate)
                .draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
