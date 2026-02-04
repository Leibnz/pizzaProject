//
//  TypeCell.swift
//  UIKitHomework
//
//  Created by Andrew on 01.08.2025.
//

import UIKit

final class CategoryContainerHeader: UITableViewHeaderFooterView {
    
    static let reuseId = "CategoryContainerHeader"
    
    var categories: [Category] = []
    
    var onCategoryCellSelect: ((Category)->())?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "TypeCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView).inset(10)
            make.height.equalTo(50)
        }
    }
}

//MARK: - CollectionViewDataSource and CollectionViewDelegate
extension CategoryContainerHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as! CategoryCollectionCell
        let type = categories[indexPath.item]
        cell.update(type)
        return cell
    }
}

extension CategoryContainerHeader: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in categories.indices {
            categories[index].isSelected = false
        }
        
        categories[indexPath.item].isSelected = true
        collectionView.reloadData()
        
        onCategoryCellSelect?(categories[indexPath.item])
    }
}

//MARK: - Get an array of data
extension CategoryContainerHeader {
    
    func update(_ types: [Category]) {
        self.categories = types
        collectionView.reloadData()
    }
}
