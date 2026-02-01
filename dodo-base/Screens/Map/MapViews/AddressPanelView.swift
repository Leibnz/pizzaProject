//
//  AddressPanelView.swift
//  UIKitHomework
//
//  Created by Andrew on 02.09.2025.
//

import UIKit
import SnapKit

final class AddressPanelView: UIView {
    
    var onAddressChanged: ((String) -> Void)?
    var onAddressTapped: (() -> Void)? {
        didSet {
            addressView.onAddressTapped = onAddressTapped
        }
    }
    
    var timer: Timer?
    var delayValue: Double = 2.0
    
    let addressView = AddressView()
    let saveButton = AddressSaveButton()
    
    private let addressPanelstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        self.addSubview(addressPanelstackView)
        addressPanelstackView.addArrangedSubview(addressView)
        addressPanelstackView.addArrangedSubview(saveButton)
    }
    
    private func setupConstraints() {
        addressPanelstackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func update(_ addressText: String) {
        addressView.addressTextField.text = addressText
    }
    
    private func observe() {
        addressView.addressTextField.addTarget(nil, action: #selector(addressTextFieldChanged(_:)), for: .editingChanged)
    }
}

//MARK: - Event Handler
extension AddressPanelView {
    
    @objc func addressTextFieldChanged(_ sender: UITextField) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        if let addressText = addressView.addressTextField.text {
            onAddressChanged?(addressText)
        }
    }
}
