//
//  OptionsPizzaCell.swift
//  UIKitHomework
//
//  Created by Andrew on 17.08.2025.
//

import UIKit


final class OptionsPizzaCell: UITableViewCell {
    
    private let pizzaSizeControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["20 см", "25 см", "30 см", "35 см"])
        control.selectedSegmentIndex = 2
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
