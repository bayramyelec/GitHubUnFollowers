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
        let task = URLSession.shared.dataTask(with: endpoint.requestURL(user: userName)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
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
    
    func fetchFollowers(username: String, completion: @escaping (Result<[User], Error>) -> Void) {
        let endPoint = EndPoint.getFollowers
        fetchData(endPoint, userName: username, completion: completion)
    }
    
    func fetchUser(username: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {
        let endpoint = EndPoint.getUsers
        fetchData(endpoint, userName: username, completion: completion)
    }
    
}
