//
//  PizzaInfoCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit

final class PizzaInfoCell: UITableViewCell {
    
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пепперони"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "30 см, традиционное тесто 30, 520 г"
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
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
        contentView.addSubview(detailTitleLabel)
        contentView.addSubview(descriptionDetailLabel)
    }
    
    private func setupConstraints() {
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(15)
        }
        
        descriptionDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(detailTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).inset(10)
        }
    }
}


//MARK: - Get data
extension PizzaInfoCell {
    
    func update(_ product: Product) {
        self.detailTitleLabel.text = product.name
        self.descriptionDetailLabel.text = product.description
    }
}
