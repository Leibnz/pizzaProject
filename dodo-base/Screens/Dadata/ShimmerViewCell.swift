//
//  ShimmerViewCell.swift
//  PizzaProject
//
//  Created by Andrew on 11.01.2026.
//

import UIKit

final class ShimmerCell: UITableViewCell {

    private let shimmerView = ShimmerView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {
        contentView.addSubview(shimmerView)
        shimmerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            shimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        shimmerView.layer.cornerRadius = 8
        shimmerView.clipsToBounds = true
    }

    func start() {
        shimmerView.start()
    }
}
