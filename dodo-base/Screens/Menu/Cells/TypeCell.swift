//
//  TypeCell.swift
//  UIKitHomework
//
//  Created by Andrew on 01.08.2025.
//

import UIKit

final class TypeCell: UITableViewCell {
    
    static let reuseId = "TypeCell"
    
    var types: [Type] = []
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.register(TypeCollectionCell.self, forCellWithReuseIdentifier: "TypeCollectionCell")
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

extension TypeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCollectionCell.reuseId, for: indexPath) as! TypeCollectionCell
        let type = types[indexPath.item]
        cell.update(type)
        return cell
    }
}

extension TypeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in types.indices {
            types[index].isSelected = false
        }
        
        types[indexPath.item].isSelected = true
        collectionView.reloadData()
    }
}

extension TypeCell {
    
    func update(_ types: [Type]) {
        self.types = types
        collectionView.reloadData()
    }
}
