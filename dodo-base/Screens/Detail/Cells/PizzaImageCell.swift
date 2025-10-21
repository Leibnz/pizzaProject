//
//  detailCell.swift
//  UIKitHomework
//
//  Created by Andrew on 16.08.2025.
//

import UIKit


final class PizzaImageCell: UITableViewCell {
    
    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pepperoni")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        contentView.addSubview(pizzaImageView)
    }
    
    private func setupConstraints() {
        pizzaImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.left.right.equalTo(contentView)
            make.height.equalTo(300)
        }
    }
}


//MARK: - Обновление картинки
extension PizzaImageCell {
    
    func update(_ product: Product) {
        let url = URL(string: product.image)
        pizzaImageView.kf.setImage(with: url)
    }
}
