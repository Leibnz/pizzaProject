//
//  basketCell.swift
//  UIKitHomework
//
//  Created by Andrew on 24.08.2025.
//

import UIKit

final class BasketCell: UITableViewCell {
    
    private lazy var basketStepper = BasketStepper()
    
    private var products: [Product] = []
    
    // current product for this cell
    private var product: Product?
    
    // closure to notify controller about count changes
    var onCountChanged: ((Product, Int) -> Void)?
    
    private let verticalBasketStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        return stackView
    }()
    
    private let orderBasketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chickenBox")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let width = UIScreen.main.bounds.width
        imageView.heightAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 0.25 * width).isActive = true
        return imageView
    }()
    
    private let nameOfProduct: UILabel = {
        let label = UILabel()
        label.text = "Чикен бокс"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let describeOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Куриные наггетсы, Картофель из печи, Сырный соус"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let sumPriceBasketLabel: UILabel = {
        let label = UILabel()
        label.text = "270 \u{20BD}"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private let changedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupStepper()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(orderBasketImage)
        contentView.addSubview(verticalBasketStackView)
        contentView.addSubview(sumPriceBasketLabel)
        contentView.addSubview(changedButton)
        
        contentView.addSubview(basketStepper)
        
        verticalBasketStackView.addArrangedSubview(nameOfProduct)
        verticalBasketStackView.addArrangedSubview(describeOrderLabel)
    }
    
    private func setupConstraints() {
        orderBasketImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        verticalBasketStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.left.equalTo(orderBasketImage.snp.right).offset(6)
            make.right.equalTo(contentView.snp.right).inset(6)
        }
        
        sumPriceBasketLabel.snp.makeConstraints { make in
            make.top.equalTo(orderBasketImage.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        changedButton.snp.makeConstraints { make in
            make.top.equalTo(orderBasketImage.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.right.equalTo(basketStepper.snp.left).offset(-12)
        }
        
        basketStepper.snp.makeConstraints { make in
            make.top.equalTo(orderBasketImage.snp.bottom).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.right.equalTo(contentView.snp.right)
        }
    }
    
    private func setupStepper() {
        basketStepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
        basketStepper.backgroundColor = .systemGray6
        basketStepper.layer.cornerRadius = 10
    }
    
    @objc private func stepperChangedValueAction(sender: BasketStepper) {
        guard var product = product else { return }
        let newCount = sender.currentValue
        product.count = newCount
        // сообщаем внешнему слою: какой продукт и новое количество
        onCountChanged?(product, newCount)
    }
}


//MARK: - Get an array of data
extension BasketCell {
    
    func update(_ product: Product) {
        self.product = product
        let url = URL(string: product.image)
        orderBasketImage.kf.setImage(with: url)
        nameOfProduct.text = product.name
        describeOrderLabel.text = product.description
        sumPriceBasketLabel.text = "\(product.price) \u{20BD}"
        
        if let cnt = product.count {
            basketStepper.currentValue = cnt
        }
    }
}
