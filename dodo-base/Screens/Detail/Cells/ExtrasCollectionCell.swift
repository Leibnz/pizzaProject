//
//  ExtrasCollectionCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit


final class ExtrasCollectionCell: UICollectionViewCell {
    
    static let reuseId = "ExtrasCollectionCell"
    
    private let containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.applyShadow(cornerRadius: 10)
        return container
    }()
    
    private let extrasImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mozzarella")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private let extrasNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Моцарелла"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let extrasPriceLabel: UILabel = {
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
        containerView.addSubview(extrasImageView)
        containerView.addSubview(extrasNameLabel)
        containerView.addSubview(extrasPriceLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).inset(5)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).inset(5)
            make.height.equalTo(180)
        }
        
        extrasImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.left.equalTo(containerView).offset(5)
            make.right.equalTo(containerView).inset(5)
        }
        
        extrasNameLabel.snp.makeConstraints { make in
            make.top.equalTo(extrasImageView.snp.bottom).offset(3)
            make.left.right.equalTo(containerView)
        }
        
        extrasPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(extrasNameLabel.snp.bottom)
            make.bottom.equalTo(containerView).inset(10)
            make.left.right.equalTo(containerView)
        }
    }
}

//MARK: - Get data
extension ExtrasCollectionCell {
    
    func update(_ extra: Extra) {
        extrasImageView.image = UIImage(named: extra.image)
        extrasNameLabel.text = extra.name
        extrasPriceLabel.text = "\(extra.price) \u{20BD}"
    }
}
