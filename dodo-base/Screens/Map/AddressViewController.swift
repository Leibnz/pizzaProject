//
//  AddressViewController.swift
//  PizzaProject
//
//  Created by Andrew on 23.12.2025.
//

import UIKit

//final class AddressViewController: UIViewController {
//    
//    // MARK: - UI
//    
//    private let addressPanelView = AddressPanelView()
//    private let tableView = UITableView()
//    
//    // MARK: - Data
//    
//    private var suggestions: [DadataSuggestion] = []
//    
//    // MARK: - Lifecycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupUI()
//        setupConstraints()
//        setupBindings()
//    }
//}
//
//private extension AddressViewController {
//    
//    func setupUI() {
//        view.backgroundColor = .systemBackground
//        
//        view.addSubview(addressPanelView)
//        view.addSubview(tableView)
//        
//        tableView.isHidden = true
//        tableView.rowHeight = 44
//        tableView.separatorStyle = .singleLine
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    
//    func setupConstraints() {
//        addressPanelView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(addressPanelView.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.height.lessThanOrEqualTo(220)
//        }
//    }
//}
