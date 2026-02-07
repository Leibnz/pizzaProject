//
//  StoriesViewController.swift
//  PizzaProject
//
//  Created by Andrew on 01.02.2026.
//

import UIKit

final class StoriesVC: UIViewController {
    
    // MARK: - Properties
    private let viewModel: StoriesViewModel
    private var timer: Timer?
    
    //MARK: - UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.register(StoriesCollectionCell.self, forCellWithReuseIdentifier: StoriesCollectionCell.reuseId)
        return cv
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("x", for: .normal)
        button.setTitleColor(.systemGray4, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 6
        button.layer.masksToBounds = false
        return button
    }()

    //MARK: - Init
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        startTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = collectionView.bounds.size
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        startTimer()
        startCurrentProgress()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(40)
        }
    }
    
    //MARK: - Actions
    @objc func closeTapped() {
        dismiss(animated: true)
    }
    
    //MARK: Story Navigation
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            self?.goToNext()
        }
    }

    private func goToNext() {
        if viewModel.isLast {
            dismiss(animated: true)
            return
        }
        viewModel.nextStory()
        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
        collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
        startTimer()
    }
    
    private func startCurrentProgress() {
        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
        guard let cell = collectionView.cellForItem(
            at: indexPath
        ) as? StoriesCollectionCell else {
            return
        }
        cell.animateProgress(duration: 5)
    }
}

// MARK: - UICollectionViewDataSource
extension StoriesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCollectionCell.reuseId, for: indexPath) as! StoriesCollectionCell
        let story = viewModel.stories[indexPath.item]
        cell.update(story)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension StoriesVC: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        viewModel.currentIndex = page
        startTimer()
        startCurrentProgress()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        startCurrentProgress()
    }
}
