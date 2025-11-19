//
//  IngredientsCollectionCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit
import Kingfisher


final class IngredientsCollectionCell: UICollectionViewCell {
    
    static let reuseId = "IngredientsCollectionCell"
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.applyShadow(cornerRadius: 10)
        return container
    }()
    
    private let ingredientsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mozzarella")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private let ingredientsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Моцарелла"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientsPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "79 \u{20BD}"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(ingredientsImageView)
        containerView.addSubview(ingredientsNameLabel)
        containerView.addSubview(ingredientsPriceLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).inset(5)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).inset(5)
            make.height.equalTo(180)
        }
        
        ingredientsImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.left.equalTo(containerView).offset(5)
            make.right.equalTo(containerView).inset(5)
        }
        
        ingredientsNameLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsImageView.snp.bottom).offset(3)
            make.left.right.equalTo(containerView)
        }
        
        ingredientsPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsNameLabel.snp.bottom)
            make.bottom.equalTo(containerView).inset(10)
            make.left.right.equalTo(containerView)
        }
    }
}

//MARK: - Get data
extension IngredientsCollectionCell {
    
    func update(_ ingredient: Ingredient) {
        let url = URL(string: ingredient.image)
        ingredientsImageView.kf.setImage(with: url)
        
        ingredientsNameLabel.text = ingredient.name
        ingredientsPriceLabel.text = "\(ingredient.price) \u{20BD}"
    }
}
