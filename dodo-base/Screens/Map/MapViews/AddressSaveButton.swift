//
//  AddressSaveButton.swift
//  UIKitHomework
//
//  Created by Andrew on 02.09.2025.
//

import UIKit

final class AddressSaveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCommonInit() {
        self.setTitle("Save", for: .normal)
        self.setTitleColor(.white, for: .normal)
        
        self.backgroundColor = .orange
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
