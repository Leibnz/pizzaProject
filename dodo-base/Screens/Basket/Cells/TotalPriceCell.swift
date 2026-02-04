//
//  TotalPriceCell.swift
//  UIKitHomework
//
//  Created by Andrew on 11.11.2025.
//

import UIKit

final class TotalPriceCell: UITableViewCell {
    
    static let reuseId = "TotalPriceCell"
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "1 товар на 270 \u{20BD}"
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
        contentView.addSubview(totalPriceLabel)
    }
    
    private func setupConstraints() {
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(10)
            make.right.bottom.equalTo(contentView)
            make.bottom.equalTo(contentView).inset(8)
        }
    }
}
