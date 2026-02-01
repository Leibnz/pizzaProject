//
//  AddressView.swift
//  UIKitHomework
//
//  Created by Andrew on 02.09.2025.
//

import Foundation
import UIKit
import SnapKit

final class AddressView: UIView {
    
    var onAddressTapped: (() -> Void)?
    
    private let descriptionAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Город, улица и дом"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш адрес"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return textField
    }()
    
    private let addressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 16
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(addressStackView)
        
        addressStackView.addArrangedSubview(descriptionAddressLabel)
        addressStackView.addArrangedSubview(addressTextField)
    }
    
    private func setupConstraints() {
        addressStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setupTextField() {
        addressTextField.delegate = self
        addressTextField.tintColor = .clear // убираем курсор
    }
}

extension AddressView: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onAddressTapped?()
        return false // ⛔️ клавиатура не появляется
    }
}
