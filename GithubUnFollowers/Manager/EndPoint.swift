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
    case getFollowing
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "search/users?q="
        case .getFollowers:
            return "/followers?page=1&per_page=200"
        case .getFollowing:
            return "/following?page=1&per_page=200"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .getFollowers:
            return .get
        case .getFollowing:
            return .get
        }
    }
    
    func fullURL(user: String) -> String {
        switch self {
        case .getUsers:
            return "\(baseURL)\(path)\(user)"
        case .getFollowers:
            return "\(baseURL)users/\(user)\(path)"
        case .getFollowing:
            return "\(baseURL)users/\(user)\(path)"
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
