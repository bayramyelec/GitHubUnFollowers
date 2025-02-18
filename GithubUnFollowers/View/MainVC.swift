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
    
    var viewModel = MainViewModel()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var textField = BYTextField(placeholder: "Search", alertMessage: "", validMessage: "", characters: [])
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.style = .large
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.2, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let githubImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        stackView.addArrangedSubview(githubImage)
        
        stackView.addArrangedSubview(textField)
        textField.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
        }
        
        stackView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
        }
        
        stackView.addArrangedSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
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
        
        navigationItem.title = "Github UnFollowers"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func buttonTapped(){
        activityIndicator.startAnimating()
        viewModel.searchUsers(query: textField.text ?? "") { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        view.endEditing(true)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        let item = viewModel.users[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.name = viewModel.users[indexPath.row].login
        detailVC.navigationItem.title = "\(viewModel.users[indexPath.row].login) (UnFollowers)"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
