//
//  StoriesCollectionCell.swift
//  UIKitHomework
//
//  Created by Andrew on 08.08.2025.
//

import UIKit
import Kingfisher


final class StoriesCollectionCell: UICollectionViewCell {
    
    static let reuseId = "StoriesCollectionCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "internetProblems")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        return imageView
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
        contentView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension StoriesCollectionCell {
    
    func update(_ story: Story) {
        let url = URL(string: story.image)
        imageView.kf.setImage(with: url)
        
//        imageView.image = UIImage(named: story.image)
    }
}
