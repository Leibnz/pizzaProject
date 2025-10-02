//
//  File.swift
//  UIKitHomework
//
//  Created by Andrew on 30.07.2025.
//

import UIKit


final class BannerCell: UITableViewCell {
    
    static let reuseId = "BannerCell"
    
    private var banners: [Banner] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 120)
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(BannerCollectionCell.self, forCellWithReuseIdentifier: "BannerCollectionCell")
        collectionView.dataSource = self
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
            make.left.right.equalTo(contentView).inset(6)
            make.height.equalTo(140)
        }
    }
}

extension BannerCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseId, for: indexPath) as! BannerCollectionCell
        let banner = banners[indexPath.item]
        cell.update(banner)
        return cell
    }
}

extension BannerCell {
    
    func update(_ banners: [Banner]) {
        self.banners = banners
        collectionView.reloadData()
    }
}
