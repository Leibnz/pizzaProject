//
//  ExtrasCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit


final class ExtrasCell: UITableViewCell {
    
    static let reuseID = "ExtrasCell"
    
    private var extras: [Extra] = []
    
    private let extrasLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить по вкусу"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var extrasCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ExtrasCollectionCell.self, forCellWithReuseIdentifier: ExtrasCollectionCell.reuseId)
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
        contentView.addSubview(extrasLabel)
        contentView.addSubview(extrasCollectionView)
    }
    
    private func setupConstraints() {
        extrasLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(15)
            make.left.equalTo(contentView).offset(15)
        }
        
        extrasCollectionView.snp.makeConstraints { make in
            make.top.equalTo(extrasLabel.snp.bottom).offset(5)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(400) //TODO: Доделать чтобы размер изменялся
        }
    }
}

//MARK: - CollectionViewDelegate
extension ExtrasCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return extras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionCell.reuseId, for: indexPath) as! ExtrasCollectionCell
        let extra = extras[indexPath.item]
        cell.update(extra)
        return cell
    }
}

//MARK: - Получение массива данных
extension ExtrasCell {
    
    func update(_ extras: [Extra]) {
        self.extras = extras
        extrasCollectionView.reloadData()
    }
}
