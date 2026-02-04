//
//  TypeOfProductCell.swift
//  UIKitHomework
//
//  Created by Andrew on 01.08.2025.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    static let reuseId = "TypeCollectionCell"
    
    private let containerView: UIView = {
        $0.backgroundColor = .white
        $0.applyShadow(cornerRadius: 10)
        return $0
    }(UIView())
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Пиццы"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        
        return label
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
        contentView.addSubview(containerView)
        containerView.addSubview(typeLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(6)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(containerView).inset(10)
            make.left.right.equalTo(containerView).inset(20)
        }
    }
}

//MARK: - Update text label
extension CategoryCollectionCell {
    
    func update(_ type: Category) {
        typeLabel.text = type.name
        
        if type.isSelected {
            containerView.backgroundColor = .systemGray6
        } else {
            containerView.backgroundColor = .white
        }
    }
}
