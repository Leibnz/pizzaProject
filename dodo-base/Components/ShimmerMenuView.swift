//
//  ShimmerMenuView.swift
//  UIKitHomework
//
//  Created by Andrew on 23.11.2025.
//

import UIKit

final class ShimmerMenuView: UIView {
    
    private var shimmerLayers: [CAGradientLayer] = []
    private let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupSkeletonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        backgroundColor = .white
        self.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - Extension
extension ShimmerMenuView {
    
    func setupSkeletonLayout() {

        let storiesStack = UIStackView()
        storiesStack.axis = .horizontal
        storiesStack.spacing = 12
        
        // 6 кружов stories
        (0..<6).forEach { _ in
            let circle = skeletonBlock(cornerRadius: 30)
            circle.snp.makeConstraints { $0.size.equalTo(CGSize(width: 60, height: 60)) }
            storiesStack.addArrangedSubview(circle)
        }
        
        let banner = skeletonBlock(cornerRadius: 12)
        banner.snp.makeConstraints { make in
            make.height.equalTo(160)
        }
        
        let productsStack = UIStackView()
        productsStack.axis = .vertical
        productsStack.spacing = 16
        
        // 5 прямоугольников под продукты
        (0..<5).forEach { _ in
            let item = skeletonBlock(cornerRadius: 12)
            item.snp.makeConstraints { $0.height.equalTo(100) }
            productsStack.addArrangedSubview(item)
        }
        
        let mainStack = UIStackView(arrangedSubviews: [storiesStack, banner, productsStack])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        
        contentView.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    func skeletonBlock(cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        return view
    }
}

//MARK: - Animation of shimmers
extension ShimmerMenuView {
    
    func start() {
        stop() // чтобы избежать наложений

        let skeletons = contentView.subviewsRecursive()
            .filter { $0.backgroundColor != nil } // наши блоки

        for block in skeletons {
            let gradient = CAGradientLayer()
            gradient.colors = [
                UIColor(white: 0.90, alpha: 1).cgColor,
                UIColor(white: 0.80, alpha: 1).cgColor,
                UIColor(white: 0.90, alpha: 1).cgColor
            ]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
            gradient.frame = block.bounds
            gradient.cornerRadius = block.layer.cornerRadius
            
            let animation = shimmerAnimation()
            gradient.add(animation, forKey: "shimmer")
            
            block.layer.addSublayer(gradient)
            shimmerLayers.append(gradient)
        }
    }

    func stop() {
        shimmerLayers.forEach { $0.removeFromSuperlayer() }
        shimmerLayers.removeAll()
    }
    
    private func shimmerAnimation() -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1, -0.5, 0]
        animation.toValue   = [1, 1.5, 2]
        animation.duration = 1.3
        animation.repeatCount = .infinity
        return animation
    }
}

//MARK: - Recursive helper, чтобы находить все skeleton-views
private extension UIView {
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}
