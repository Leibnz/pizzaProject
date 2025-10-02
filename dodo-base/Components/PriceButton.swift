//
//  PriceButton.swift
//  UIKitHomework
//
//  Created by Andrew on 20.08.2025.
//

import UIKit


final class PriceButton: UIButton {
    
    init(price: String) {
        super.init(frame: .zero)
        configure(price: price)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(price: "0 \u{20BD}")
    }
    
    private func configure(price: String) {
        var config = UIButton.Configuration.filled()
        config.title = price
        
        if let basket = UIImage(named: "basket")?.withRenderingMode(.alwaysTemplate) {
            config.image = basket.resized(to: CGSize(width: 24, height: 24)).tinted(with: .white)
        }
        
        config.baseForegroundColor = .white
        config.imagePadding = 10
        config.baseBackgroundColor = .orange
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        config.attributedTitle = AttributedString(price, attributes: AttributeContainer([
            .font : UIFont.systemFont(ofSize: 16, weight: .semibold)]))
        
        self.configuration = config
    }
}
