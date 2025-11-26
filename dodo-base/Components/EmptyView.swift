//
//  EmptyView.swift
//  UIKitHomework
//
//  Created by Andrew on 05.11.2025.
//

import UIKit


final class EmptyView: UIView {
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return containerView
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
        self.addSubview(containerView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
