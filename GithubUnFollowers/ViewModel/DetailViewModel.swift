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
    
    func fetchUserDetails(username: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(UserDetail.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let decodingError {
                DispatchQueue.main.async {
                    print("Decoding error: \(decodingError.localizedDescription)")
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }
    
    
}
