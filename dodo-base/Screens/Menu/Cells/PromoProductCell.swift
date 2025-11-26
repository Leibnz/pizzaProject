//
//  ProductCell.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import UIKit
import Kingfisher


final class PromoProductCell: UITableViewCell {
    
    static let reuseId = "PromoProductCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pizza")
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Пепперони фреш"
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Тесто, Цыпленок, моцарелла, томатный соус"
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("от 469 \u{20BD}", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemGray6
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 16
        button.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        return button
    }()
    
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let bottomRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradient()
    }
    
// MARK: - Update
    
    func update(_ product: Product) {
        if let url = URL(string: product.image) {
            productImageView.kf.setImage(with: url)
        }
        nameLabel.text = product.name
        detailLabel.text = product.description
        priceButton.setTitle("от \(product.price) \u{20BD}", for: .normal)
    }
}


// MARK: - Layout
private extension PromoProductCell {
    
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(gradientView)
        containerView.addSubview(verticalStackView)
        
        bottomRow.addArrangedSubview(UIView()) // spacer
        bottomRow.addArrangedSubview(priceButton)
        
        verticalStackView.addArrangedSubview(productImageView)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(detailLabel)
        verticalStackView.addArrangedSubview(bottomRow)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        gradientView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.55)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width * 0.45)
        }
    }
    
    func applyGradient() {
        // Удаляем старые слои, чтобы не дублировать при переиспользовании ячеек
        gradientView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.systemOrange.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
