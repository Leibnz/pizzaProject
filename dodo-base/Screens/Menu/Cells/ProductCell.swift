//
//  ProductCell.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import UIKit


final class ProductCell: UITableViewCell {
    
    static let reuseId = "ProductCell"
    
    private let containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пепперони"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("от 469 \u{20BD}", for: .normal)
        button.backgroundColor = .orange.withAlphaComponent(0.1)
        button.layer.cornerRadius = 20
        button.setTitleColor(.brown, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizza")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.40 * width).isActive = true
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ product: Product) {
        nameLabel.text = product.name
        detailLabel.text = product.description
        priceButton.setTitle("от \(product.price) \u{20BD}", for: .normal)
        productImageView.image = UIImage(named: product.image)
    }
}

//MARK: - Public
extension ProductCell {
    
    func update(_ product: String) {
        nameLabel.text = product
    }
}

//MARK: - Layout
extension ProductCell {
    
    struct Layout {
        static let offset = 16
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        [containerView].forEach {
            contentView.addSubview($0)
        }
        [productImageView, verticalStackView].forEach {
            containerView.addSubview($0)
        }
        [nameLabel, detailLabel, priceButton].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(8)
            make.left.right.equalTo(contentView).inset(16)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.bottom.greaterThanOrEqualTo(containerView).inset(8)
            make.left.equalTo(containerView).offset(8)
            make.centerY.equalTo(containerView)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(containerView).inset(8)
            make.left.equalTo(productImageView.snp.right).offset(8)
        }
    }
}
