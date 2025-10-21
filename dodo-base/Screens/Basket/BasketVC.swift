//
//  BasketVC.swift
//  UIKitHomework
//
//  Created by Andrew on 21.08.2025.
//

import UIKit
import SnapKit


final class BasketVC: UIViewController {
    
    private var basketButtonView = BasketButtonView()
    
    var basket: [Basket] = []
    
    let basketService = BasketService.init()
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        
        tableView.registerCell(BasketCell.self)
        tableView.registerCell(AddProductCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        fetchBasket()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(basketTableView)
        view.addSubview(basketButtonView)
        fetchBasket()
    }
    
    private func setupConstraints() {
        basketTableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(basketButtonView.snp.top)
        }
        
        basketButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
//        addressButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
//            make.left.right.equalTo(view).inset(64)
//            make.height.equalTo(40)
//        }
    }
    
//    private func setupActions() {
//        addressButton.addAction(UIAction(handler: { [weak self] _ in
//            let mapVC = MapViewController()
//            self?.present(mapVC, animated: true)
//        }), for: .touchUpInside)
//    }
    
    private func fetchBasket() {
        basket = basketService.fetchBasket()
        basketTableView.reloadData()
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - TableViewDataSource

extension BasketVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueCell(indexPath) as BasketCell
            return cell
        case 1:
            let cell = tableView.dequeueCell(indexPath) as AddProductCell
            cell.update(basket)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
