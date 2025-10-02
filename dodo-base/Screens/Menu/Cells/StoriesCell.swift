//
//  StoriesCell.swift
//  UIKitHomework
//
//  Created by Andrew on 08.08.2025.
//

import UIKit


final class StoriesCell: UITableViewCell {
    
    static let reuseId = "StoriesCell"
    
    var stories: [Story] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 100)
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(StoriesCollectionCell.self, forCellWithReuseIdentifier: "StoriesCollectionCell")
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
            make.left.right.equalTo(contentView).inset(16)
            make.height.equalTo(120)
        }
    }
}

extension StoriesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionCell.reuseId, for: indexPath) as! StoriesCollectionCell
        let story = stories[indexPath.item]
        cell.update(story)
        return cell
    }
}

extension StoriesCell {
    func update(_ stories: [Story]) {
        self.stories = stories
        collectionView.reloadData()
    }
}
