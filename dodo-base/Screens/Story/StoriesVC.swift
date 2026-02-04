//
//  StoriesViewController.swift
//  PizzaProject
//
//  Created by Andrew on 01.02.2026.
//

import UIKit

final class StoriesVC: UIViewController {
    
    private let viewModel: StoriesViewModel
    private var timer: Timer?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size
        
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
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func closeTapped() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//
//        startTimer()
//        startCurrentProgress()
        
//        super.viewDidAppear(animated)
//
//        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//
//        startTimer()
        
        super.viewDidAppear(animated)

        let indexPath = IndexPath(item: viewModel.currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)

        startTimer()
        startCurrentProgress()
    }
    
    init(viewModel: StoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
            
            //МОЕ РЕШЕНИЕ
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
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

extension StoriesVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.stories.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: StoriesCollectionCell.reuseId,
//            for: indexPath
//        ) as! StoriesCollectionCell
//
//        let story = viewModel.stories[indexPath.item]
//        cell.update(story)
//        cell.animateProgress(duration: 5)
//
//        return cell
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoriesCollectionCell.reuseId,
            for: indexPath
        ) as! StoriesCollectionCell

        let story = viewModel.stories[indexPath.item]
        cell.update(story)

        // ❌ НЕ ЗАПУСКАЕМ ТУТ progress
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
//        guard indexPath.item == viewModel.currentIndex,
//              let storyCell = cell as? StoriesCollectionCell else {
//            return
//        }
//
//        storyCell.animateProgress(duration: 5)
    }
}

//extension StoriesVC: UICollectionViewDelegate {}
extension StoriesVC: UICollectionViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        viewModel.currentIndex = page

        startTimer()
        startCurrentProgress()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        startCurrentProgress()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
}
