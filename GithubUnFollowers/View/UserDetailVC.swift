//
//  UserDetailVC.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 18.02.2025.
//

import UIKit
import Kingfisher

class UserDetailVC: UIViewController {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var followingCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private var goButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Github Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(200)
        }
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        view.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(30)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(20)
        }
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(20)
        }
        view.addSubview(followersCountLabel)
        followersCountLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(30)
            make.left.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(20)
        }
        view.addSubview(followingCountLabel)
        followingCountLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(30)
            make.left.equalTo(followersCountLabel.snp.right).offset(10)
            make.height.equalTo(20)
        }
        view.addSubview(goButton)
        goButton.snp.makeConstraints { make in
            make.top.equalTo(followersCountLabel.snp.bottom).offset(50)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        view.addSubview(createdDateLabel)
        createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(goButton.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configure(item: UserDetail) {
        let url = URL(string: item.avatarURL)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url)
        
        nameLabel.text = item.name
        usernameLabel.text = item.login
        descLabel.text = item.bio
        locationLabel.text = "📍 \(item.location)"
        followersCountLabel.text = "👤 \(item.followers) followers"
        followingCountLabel.text = "● \(item.following) following"
        
        createdDateLabel.text = "Created at \(item.createdAt)"
        
    }
}
