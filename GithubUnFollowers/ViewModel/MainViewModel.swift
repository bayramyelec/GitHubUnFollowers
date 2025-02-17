//
//  MainViewModel.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import Foundation

class MainViewModel {
    
    var users: [GitHubUser] = []
    
    func searchUsers(query: String) {
        guard let url = URL(string: "https://api.github.com/search/users?q=\(query)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(SearchResult.self, from: data)
                    DispatchQueue.main.async {
                        self.users = decodedResponse.items
                    }
                } catch {
                    print("JSON Decode Error: \(error)")
                }
            }
        }.resume()
    }
    
    struct SearchResult: Codable {
        let items: [GitHubUser]
    }
    
}
