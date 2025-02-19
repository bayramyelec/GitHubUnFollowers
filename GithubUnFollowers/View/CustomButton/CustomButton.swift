//
//  UnFollowersButton.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 19.02.2025.
//

import UIKit


extension UIButton {
    func customButton(imageName: String, title: String, foregroundColor: UIColor, backgroundColor: UIColor, font: UIFont = UIFont.systemFont(ofSize: 17, weight: .bold)) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: imageName)
        config.title = title
        config.imagePadding = 10
        config.titleAlignment = .leading
        config.baseForegroundColor = foregroundColor
        config.imagePlacement = .leading
        
        let attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: font]))
        config.attributedTitle = attributedTitle
        
        self.configuration = config
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
