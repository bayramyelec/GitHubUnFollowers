//
//  MainViewModel.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import Foundation

class MainViewModel {
    
    var users: [Item] = []
    var followers: [Follower] = []
    
    func searchUsers(query: String) {
        NetworkManager.shared.fetchUser(username: query) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.users = success.items
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchFollowers(username: String) {
        NetworkManager.shared.fetchFollowers(username: username) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.followers = success
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
