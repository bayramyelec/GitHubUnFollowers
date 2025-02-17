//
//  EndePoint.swift
//  GithubUnFollowers
//
//  Created by Bayram Yeleç on 17.02.2025.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func fullURL(user: String) -> String
    func requestURL(user: String) -> URLRequest
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum EndPoint {
    case getUsers
    case getFollowers
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .getFollowers:
            return "users/"
        case .getUsers:
            return "search/users?q="
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFollowers:
            return .get
        case .getUsers:
            return .get
        }
    }
    
    func fullURL(user: String) -> String {
        switch self {
        case .getUsers:
            return "\(baseURL)\(path)\(user)"
        case .getFollowers:
            return "\(baseURL)\(path)/followers"
        }
    }
    
    func requestURL(user: String) -> URLRequest {
        guard let url = URL(string: fullURL(user: user)) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
