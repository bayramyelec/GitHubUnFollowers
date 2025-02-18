//
//  MainViewModel.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import Foundation

class MainViewModel {
    
    var users: [Item] = []
    
    func searchUsers(query: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchUser(username: query) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.users = success.items
                }
                completion()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
