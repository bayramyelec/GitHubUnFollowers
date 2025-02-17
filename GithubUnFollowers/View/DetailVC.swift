//
//  DetailVC.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import UIKit

class DetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
