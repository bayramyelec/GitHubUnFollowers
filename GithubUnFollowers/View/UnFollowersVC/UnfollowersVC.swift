//
//  DetailVC.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import UIKit
import Kingfisher

class UnfollowersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var name: String?
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UnFollwersTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var backButton: UIButton = {
        let backButton = UIButton(type: .roundedRect)
        backButton.setTitle("Geri", for: .normal)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return backButton
    }()
    
    var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setup() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func fetchData() {
        guard let username = name, !username.isEmpty else { return }
        viewModel.filterFollowing(username: username) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredFollowing.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UnFollwersTableViewCell
        let item = viewModel.filteredFollowing[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserVC()
        let item1 = viewModel.filteredFollowing[indexPath.row]
        viewModel.fetchUserDetails(username: item1.login) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    vc.configure(item: success)
                }
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure)
                }
            }
        }
    }
    
}
