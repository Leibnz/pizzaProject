//
//  StoriesCollectionCell.swift
//  PizzaProject
//
//  Created by Andrew on 01.02.2026.
//

import UIKit

final class StoriesCollectionCell: UICollectionViewCell {
    
    static let reuseId = "StoriesCollectionCell"
    
    private let imageView = UIImageView()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private var progressTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressTimer?.invalidate()
        progressView.progress = 0
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
//        progressView.progressTintColor = .blue
//        progressView.trackTintColor = .orange
        
        //Мой вариант
//        progressView.progressTintColor = .systemGray6
//        progressView.trackTintColor = .white
//        progressView.alpha = 0.8
//        progressView.backgroundColor = .orange
//        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 3.0)
        
        contentView.addSubview(imageView)
        contentView.addSubview(progressView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            //Мой вариант работы с UI
//            $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(50)
//            $0.left.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            $0.top.equalToSuperview().offset(50)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    func update(_ story: Story) {
        let url = URL(string: story.image)
        imageView.kf.setImage(with: url)
        progressView.progress = 0
    }
    
    func animateProgress(duration: TimeInterval) {
        progressTimer?.invalidate()
        progressView.progress = 0

        let steps = 100
        let stepDuration = duration / Double(steps)
        var currentStep = 0

        progressTimer = Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true) { [weak self] timer in
            guard let self else {
                timer.invalidate()
                return
            }

            currentStep += 1
            self.progressView.progress = Float(currentStep) / Float(steps)

            if currentStep >= steps {
                timer.invalidate()
            }
        }
    }
}
