//
//  OptionsPizzaCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit


final class OptionsPizzaCell: UITableViewCell {
    
    var product: Product?
    var onSizeChanged: ((String)->())?
    var onDoughChanged: ((String)->())?
    
    private let pizzaSizeControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["20 см", "25 см", "30 см", "35 см"])
        control.selectedSegmentIndex = 2
//        control.addTarget(nil, action: #selector(sizeSegmentedChanged()), for: .valueChanged)
        return control
    }()
    
    private let pizzaDoughControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Традиционное", "Тонкое"])
        control.selectedSegmentIndex = 0
        return control
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
        contentView.addSubview(pizzaSizeControl)
        contentView.addSubview(pizzaDoughControl)
    }
    
    private func setupConstraints() {
        pizzaSizeControl.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.right.equalTo(contentView).inset(10)
            make.height.equalTo(30)
        }
        
        pizzaDoughControl.snp.makeConstraints { make in
            make.top.equalTo(pizzaSizeControl.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(10)
            make.left.right.equalTo(contentView).inset(10)
            make.height.equalTo(30)
        }
    }
}


extension OptionsPizzaCell {
    func update(_ product: Product) {
        if product.type != "pizza" {
            pizzaSizeControl.isHidden = true
            pizzaDoughControl.isHidden = true
        }
        
        if let dough = product.dough {
            dough.getIndex()
        }
    }
}


//MARK: - Event Handler
//extension OptionsPizzaCell {
//    @objc private func sizeSegmentedChanged(_ sender: UISegmentedControl) {
//        let size =
//    }
//}
