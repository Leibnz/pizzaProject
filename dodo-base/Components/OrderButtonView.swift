//
//  OrderButtonView.swift
//  UIKitHomework
//
//  Created by Andrew on 20.08.2025.
//

import UIKit

final class OrderButtonView: UIView {
    
    //declaration
    var onOrderButtonTap: (()->())?
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("В корзину за 629 \u{20BD}", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 14
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(nil, action: #selector(orderButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc private func orderButtonTap() {
        //calling
        onOrderButtonTap?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.addSubview(orderButton)
    }
    
    private func setupConstraints() {
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(16)
            make.left.right.equalTo(self).inset(16)
            make.bottom.equalTo(self).inset(44)
        }
    }
}
