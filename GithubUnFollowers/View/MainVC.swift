//
//  ViewController.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import UIKit
import SnapKit
import BYCustomTextField
import Kingfisher

class MainVC: UIViewController {
    
    private var textField = BYTextField(placeholder: "Search", alertMessage: "", validMessage: "", characters: [])
    
    var viewModel = MainViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(30)
        }
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(textField.snp.right).offset(10)
            make.right.equalToSuperview().inset(30)
            make.width.height.equalTo(70)
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    @objc func buttonTapped(){
        viewModel.searchUsers(query: textField.text ?? "")
        tableView.reloadData()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = viewModel.users[indexPath.row]
        cell.textLabel?.text = item.login
        let url = URL(string: item.avatar_url)
        cell.imageView?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.viewModel = self.viewModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
