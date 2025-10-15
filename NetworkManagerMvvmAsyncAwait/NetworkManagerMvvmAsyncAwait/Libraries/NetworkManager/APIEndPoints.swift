//
//  APIEndPoints.swift
//  NetworkManagerMvvmAsyncAwait
//
//  Created by Sudeb Sarkar on 14/10/25.
//
 
import Foundation

protocol APIEndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var httpBody: Data? { get }
    var headers: [String: String]? { get }
}

extension APIEndPoint {
    var baseURL: URL {
        URL(string: "http://127.0.0.1:3000")!
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
}

enum UserEndPoint: APIEndPoint {
    
    case fetchUserData
    
    var path: String {
        switch self {
        case .fetchUserData:
            return "/users"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var httpBody: Data? {
        switch self {
        case .fetchUserData:
            return nil
        }
    }
}
