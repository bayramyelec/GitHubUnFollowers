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
    var detailViewModel = DetailViewModel()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var textField = BYTextField(placeholder: "Search..", alertMessage: "", validMessage: "", characters: [])
    
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
        collectionView.alpha = 0
        return collectionView
    }()
    
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.customButton(imageName: "", title: "Search", foregroundColor: .white, backgroundColor: .systemBlue)
        return button
    }()
    
    private let githubImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 1
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    private func setupUI(){
        view.backgroundColor = .black
        view.addSubview(githubImage)
        githubImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(250)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.centerX.equalToSuperview()
        }
        
        collectionView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(collectionView)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.height.equalTo(70)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.centerX.equalToSuperview()
        }
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(50)
            make.width.equalTo(UIScreen.main.bounds.width / 1.2)
            make.centerX.equalToSuperview()
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @objc func buttonTapped(){
        collectionView.alpha = 1
        githubImage.alpha = 0
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
        let vc = MainUserVC()
        let item1 = viewModel.users[indexPath.row]
        vc.userDetail = item1
        detailViewModel.fetchUserDetails(username: item1.login) { result in
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

