//
//  MockService.swift
//  NetworkManagerMvvmAsyncAwait
//
//  Created by Sudeb Sarkar on 14/10/25.
//

import Foundation
@testable import NetworkManagerMvvmAsyncAwait

final class MockService: NetworkService {
    
    var mockResult: Result<Data, Error>?
    
    func request<T: Decodable>(apiEndPoint: APIEndPoint, type: T.Type) async throws -> T {
        
        switch mockResult {
        case .success(let data):
            return try JSONDecoder().decode(T.self, from: data)
        case .failure(let error):
            throw error
        case .none:
            throw URLError(.badServerResponse)
        }
    }
}
