//
//  DetailViewModel.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 18.02.2025.
//

import Foundation

class DetailViewModel {
    
    var followers: [Follower] = []
    var following: [Follower] = []
    var filteredFollowing: [Follower] = []
    
    private func fetchFollowers(username: String, completion: @escaping ([Follower]) -> Void) {
        NetworkManager.shared.fetchFollowers(username: username) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(success)
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func fetchFollowing(username: String, completion: @escaping ([Follower]) -> Void) {
        NetworkManager.shared.fetchFollowing(username: username) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    completion(success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    func filterFollowing(username: String, completion: @escaping () -> Void) {
        fetchFollowers(username: username) { followers in
            self.followers = followers
            
            self.fetchFollowing(username: username) { following in
                self.following = following
                
                self.filteredFollowing = following.filter { item in
                    !followers.contains(where: { $0.login == item.login })
                }
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
}
