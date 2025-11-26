//
//  AddProductCollectionCell.swift
//  UIKitHomework
//
//  Created by Andrew on 24.08.2025.
//

import UIKit


final class AddProductCollectionCell: UICollectionViewCell {
    
    static let reuseId = "AddProductCollectionCell"
    
    private let basketContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.applyShadow(cornerRadius: 12)
        return container
    }()
    
    private let verticalProductStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    private let addProductImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "friesAndSauce")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return imageView
    }()
    
    private let addProductNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Картофель из печи с соусом"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let addProductWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "180 г"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray3
        label.textAlignment = .left
        return label
    }()
    
    private let addProductPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "289 \u{20BD}"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.backgroundColor = .systemGray6
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return label
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
        contentView.addSubview(basketContainerView)
        basketContainerView.addSubview(verticalProductStackView)
        verticalProductStackView.addArrangedSubview(addProductImage)
        verticalProductStackView.addArrangedSubview(addProductNameLabel)
        verticalProductStackView.addArrangedSubview(addProductWeightLabel)
        verticalProductStackView.addArrangedSubview(addProductPriceLabel)
        verticalProductStackView.setCustomSpacing(16, after: addProductWeightLabel)
    }
    
    private func setupConstraints() {
        basketContainerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(6)
        }
        
        verticalProductStackView.snp.makeConstraints { make in
            make.top.equalTo(basketContainerView).offset(6)
            make.bottom.equalTo(basketContainerView).inset(6)
            make.left.equalTo(basketContainerView).offset(6)
            make.right.equalTo(basketContainerView).inset(6)
        }
    }
}


//MARK: - Get data
extension AddProductCollectionCell {
    
    func update(_ addition: Product) {
        let url = URL(string: addition.image)
        addProductImage.kf.setImage(with: url)
        addProductNameLabel.text = addition.name
        addProductWeightLabel.text = "\(addition.id) г"
        addProductPriceLabel.text = "\(addition.price) \u{20BD}"
    }
}
