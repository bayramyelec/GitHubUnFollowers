//
//  NetworkManager.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private func fetchData<T: Decodable>(_ endpoint: EndPoint, userName: String , completion: @escaping (Result<T, Error>) -> Void){
        let task = URLSession.shared.dataTask(with: endpoint.requestURL(user: userName)) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchUser(username: String, completion: @escaping (Result<GithubUser, Error>) -> Void) {
        let endpoint = EndPoint.getUsers
        fetchData(endpoint, userName: username, completion: completion)
    }
    
    func fetchFollowers(username: String, completion: @escaping (Result<[Follower], Error>) -> Void) {
        let endpoint = EndPoint.getFollowers
        fetchData(endpoint, userName: username, completion: completion)
    }
    
}
