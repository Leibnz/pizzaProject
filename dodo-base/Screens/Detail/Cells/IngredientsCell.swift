//
//  IngredientsCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit

final class IngredientsCell: UITableViewCell {
    
    static let reuseID = "IngredientsCell"
    
    private var ingredients: [Ingredient] = []
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить по вкусу"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var ingredientsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(IngredientsCollectionCell.self, forCellWithReuseIdentifier: IngredientsCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
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
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsCollectionView)
    }
    
    private func setupConstraints() {
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.left.equalTo(contentView).offset(15)
        }
        
        ingredientsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(5)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(contentView)
            make.height.equalTo(460)
        }
    }
}

//MARK: - CollectionViewDelegate
extension IngredientsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionCell.reuseId, for: indexPath) as! IngredientsCollectionCell
        let ingredient = ingredients[indexPath.item]
        cell.update(ingredient)
        return cell
    }
}

//MARK: - Get an array of data
extension IngredientsCell {
    
    func update(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
        ingredientsCollectionView.reloadData()
    }
}
