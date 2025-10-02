//
//  DetailProductVC.swift
//  UIKitHomework
//
//  Created by Andrew on 13.08.2025.
//

import UIKit
import SnapKit


final class DetailProductVC: UIViewController {
    
    private var extras: [Extra] = []
    
    let extraService = ExtraService()
    
    private var orderButtonView = OrderButtonView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(PizzaImageCell.self)
        tableView.registerCell(PizzaInfoCell.self)
        tableView.registerCell(OptionsPizzaCell.self)
        tableView.registerCell(ExtrasCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        fetchExtras()
    }
    
    private func fetchExtras() {
        extras = extraService.fetchExtras()
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(orderButtonView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        orderButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}

//MARK: - TableViewDataSource and TableViewDelegate
extension DetailProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueCell(indexPath) as PizzaImageCell
            return cell
        case 1:
            let cell = tableView.dequeueCell(indexPath) as PizzaInfoCell
            return cell
        case 2:
            let cell = tableView.dequeueCell(indexPath) as OptionsPizzaCell
            return cell
        case 3:
            let cell = tableView.dequeueCell(indexPath) as ExtrasCell
            cell.update(extras)
            return cell
        default: return UITableViewCell() 
        }
    }
}
