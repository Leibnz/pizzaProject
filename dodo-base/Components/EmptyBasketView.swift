//
//  EmptyBasketView.swift
//  UIKitHomework
//
//  Created by Andrew on 18.11.2025.
//

import UIKit

final class EmptyBasketView: UIView {
    
    var onBackToMenuButtonTap: (()->())?
    
    private let verticalEmptyBasketStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let emptyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "emptyBasket.png")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let emptyBasketLabel: UILabel = {
        let label = UILabel()
        label.text = "Пока тут пусто"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let emptyBasketDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавьте пиццу. Или две! \n А мы доставим ваш заказ от 1 \u{20BD}"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let backToMenuButton: UIButton = {
        
        var config = UIButton.Configuration.filled()
        config.title = "Вернуться в меню"
        config.titleAlignment = .center
        
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .orange
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let button = UIButton(configuration: config, primaryAction: nil)
        button.addTarget(nil, action: #selector(backToMenuTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(verticalEmptyBasketStackView)
        verticalEmptyBasketStackView.addArrangedSubview(emptyImage)
        verticalEmptyBasketStackView.addArrangedSubview(emptyBasketLabel)
        verticalEmptyBasketStackView.addArrangedSubview(emptyBasketDescriptionLabel)
        verticalEmptyBasketStackView.addArrangedSubview(backToMenuButton)
    }
    
    private func setupConstaints() {
        verticalEmptyBasketStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func backToMenuTap() {
        onBackToMenuButtonTap?()
    }
}
