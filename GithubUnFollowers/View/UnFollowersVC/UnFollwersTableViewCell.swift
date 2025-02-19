//
//  DetailTableViewCell.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 18.02.2025.
//

import UIKit
import Kingfisher

class UnFollwersTableViewCell: UITableViewCell {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        return indicator
    }()
    
    private let arrowIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        contentView.addSubview(avatarImageView)
        contentView.addSubview(activityIndicator)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.equalTo(50)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(avatarImageView)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        
        contentView.addSubview(arrowIcon)
        arrowIcon.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(10)
        }
    }
    
    func configure(with model: Follower) {
        let url = URL(string: model.avatarURL)
        activityIndicator.startAnimating()
        nameLabel.text = model.login
        avatarImageView.kf.setImage(
            with: url,
            options: [.forceRefresh],
            completionHandler: { _ in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        )
    }
}
