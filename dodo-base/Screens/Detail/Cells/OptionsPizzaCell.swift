//
//  OptionsPizzaCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit

final class OptionsPizzaCell: UITableViewCell {
    
    private let sizes = ["20 см", "25 см", "30 см", "35 см"]
    
    var product: Product?
    var onSizeSelect: ((PizzaSize)->())?
    var onDoughtSelect: ((PizzaDough)->())?
    
    private lazy var pizzaSizeControl: UISegmentedControl = {
        
        let control = UISegmentedControl(items: sizes)
        //control.selectedSegmentIndex = product?.size?.getIndex() ?? 0
        control.addTarget(nil, action: #selector(sizeSegmentedChanged(_:)), for: .valueChanged)
        return control
    }()
    
    private let pizzaDoughControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Традиционное", "Тонкое"])
        control.selectedSegmentIndex = 0
        control.addTarget(nil, action: #selector(doughSegmentedChanged(_ :)), for: .valueChanged)
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

//MARK: - Get data
extension OptionsPizzaCell {
    func update(_ product: Product) {
        self.product = product
        pizzaSizeControl.selectedSegmentIndex = product.size?.getIndex() ?? 0
        pizzaDoughControl.selectedSegmentIndex = product.dough?.getIndex() ?? 0
        
        if product.type != .pizza {
            pizzaSizeControl.isHidden = true
            pizzaDoughControl.isHidden = true
        }
    }
}

//MARK: - Event Handler
extension OptionsPizzaCell {
    @objc private func sizeSegmentedChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        if let size = product?.size?.setIndex(index: index) {
            onSizeSelect?(size)
        }
    }
    
    @objc private func doughSegmentedChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        if let dough = product?.dough?.setIndex(index: index) {
            onDoughtSelect?(dough)
        }
    }
}
