//
//  ErrorMenuStateView.swift
//  UIKitHomework
//
//  Created by Andrew on 22.11.2025.
//

import UIKit

final class ErrorMenuStateView: UIView {
    
    var onRetryMenuPageTap: (()->())?
    
    private let verticalMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let errorMenuLabel: UILabel = {
        let label = UILabel()
        label.text = "Не удалось загрузить"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let retryMenuButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Повторить"
        config.titleAlignment = .center
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .orange
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let button = UIButton(configuration: config)
        button.addTarget(nil, action: #selector(retryMenuPage), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(verticalMenuStackView)
        verticalMenuStackView.addArrangedSubview(errorMenuLabel)
        verticalMenuStackView.addArrangedSubview(retryMenuButton)
    }
    
    private func setupConstraints() {
        verticalMenuStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func retryMenuPage() {
        onRetryMenuPageTap?()
    }
}
