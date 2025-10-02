//
//  AddProductCell.swift
//  UIKitHomework
//
//  Created by Andrew on 24.08.2025.
//

import UIKit


final class AddProductCell: UITableViewCell {
    
    static let reuseId = "AddProductCell"
    
    private var basket: [Basket] = []
    
    private let addProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить к заказу?"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var addProductCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = CGSize(width: 150, height: 300)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.register(AddProductCollectionCell.self, forCellWithReuseIdentifier: "AddProductCollectionCell")
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let promoTextField: UITextField = {
         let textField = UITextField()
        textField.placeholder = "Ввести промокод"
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 12
        return textField
     }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(addProductLabel)
        contentView.addSubview(addProductCollectionView)
        contentView.addSubview(promoTextField)
    }
    
    private func setupConstraints() {
        addProductLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.left.equalTo(contentView.snp.left).offset(10)
        }
        
        addProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addProductLabel.snp.bottom).offset(14)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).inset(10)
            make.height.equalTo(300)
        }
        
        promoTextField.snp.makeConstraints { make in
            make.top.equalTo(addProductCollectionView.snp.bottom).offset(32)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-16)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
    }
}


//MARK: - CollectionViewDataSource

extension AddProductCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addProductCollectionView.dequeueReusableCell(withReuseIdentifier: AddProductCollectionCell.reuseId, for: indexPath) as! AddProductCollectionCell
        let basketProduct = basket[indexPath.item]
        cell.update(basketProduct)
        return cell
    }
}

extension AddProductCell {
    
    func update(_ basket: [Basket]) {
        self.basket = basket
        addProductCollectionView.reloadData()
    }
}
