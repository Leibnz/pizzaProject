//
//  StoriesCollectionCell.swift
//  PizzaProject
//
//  Created by Andrew on 01.02.2026.
//

import UIKit

final class StoriesCollectionCell: UICollectionViewCell {
    
    static let reuseId = "StoriesCollectionCell"
        
    // MARK: - Properties
    private var progressTimer: Timer?

    //MARK: - UI Elements
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.progressTintColor = .systemOrange
        return pv
    }()
    
    //MARK: - Init
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
    
    //MARK: - Setup
    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(progressView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Update Cell
    func update(_ story: Story) {
        let url = URL(string: story.image)
        imageView.kf.setImage(with: url)
        progressView.progress = 0
    }
    
    // MARK: - Progress Animation
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
