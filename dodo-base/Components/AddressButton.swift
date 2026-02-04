//
//  AddressButton.swift
//  UIKitHomework
//
//  Created by Andrew on 02.09.2025.
//

import UIKit

final class AddressButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        var config = UIButton.Configuration.filled()
        config.title = "Указать адрес доставки"
        config.titleAlignment = .leading
        
        if let basket = UIImage(named: "deliveryBike") {
            config.image = basket.resized(to: CGSize(width: 24, height: 24))
        }
        
        config.baseForegroundColor = .black
        config.imagePadding = 10
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 20, bottom: 2, trailing: 20)
        
        self.configuration = config
    }
}
