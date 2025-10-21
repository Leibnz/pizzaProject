//
//  BannerCollectionCell.swift
//  UIKitHomework
//
//  Created by Andrew on 30.07.2025.
//

import UIKit
import Kingfisher

final class BannerCollectionCell: UICollectionViewCell {
    
    static let reuseId = "BannerCollectionCell"
    
    private let containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private let verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pepperoniFresh")
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Пепперони фреш"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "120 \u{20BD}"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
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
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(priceLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(6)
        }
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).inset(10)
            make.centerY.equalTo(contentView)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalTo(contentView).inset(10)
            
        }
    }
}

extension BannerCollectionCell {
    
    func update(_ banner: Banner) {
        let url = URL(string: banner.image)
        imageView.kf.setImage(with: url)
        //imageView.image = UIImage(named: banner.image)
        
        nameLabel.text = banner.name
        priceLabel.text = "\(banner.newPrice) \u{20BD}"
    }
}
