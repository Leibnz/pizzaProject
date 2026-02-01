//
//  Dadata.swift
//  PizzaProject
//
//  Created by Andrew on 27.12.2025.
//

import UIKit
import SnapKit

final class DadataViewController: UIViewController {
    
    private let viewModel = DadataViewModel()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите адрес"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.register(ShimmerCell.self, forCellReuseIdentifier: "shimmer")

        tv.isHidden = true
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setupBindings()
    }
}

//MARK: - View State

//MARK: - Table DataSource
extension DadataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoading {
            return 6 // количество шиммер-строк
        }
        
        return viewModel.suggestions.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if viewModel.isLoading {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "shimmer",
                for: indexPath
            ) as! ShimmerCell
            cell.start()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.suggestion(at: indexPath.row)
        cell.selectionStyle = .none
//        cell.textLabel?.numberOfLines = 2
        return cell
    }
}

//MARK: - Table Delegate
extension DadataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = viewModel.suggestion(at: indexPath.row)
        textField.text = value
        tableView.isHidden = true
        view.endEditing(true)
    }
}

//MARK: - Observers & Actions
extension DadataViewController {
    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            guard let self else { return }
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    @objc private func textChanged() {
        viewModel.search(text: textField.text ?? "")
    }
}

//MARK: - Navigation
extension DadataViewController {
    private func setupNavigation() {
        title = "Адрес доставки"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: self, action: #selector(closeTapped))
        navigationController?.navigationBar.tintColor = .orange
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}

//MARK: - Layout
extension DadataViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(textField)
        view.addSubview(tableView)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}
