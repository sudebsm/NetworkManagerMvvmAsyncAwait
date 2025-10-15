//
//  Services.swift
//  NetworkManagerMvvmAsyncAwait
//
//  Created by Sudeb Sarkar on 14/10/25.
//
import Foundation

protocol NetworkService {
    
    func request<T:Decodable>( apiEndPoint: APIEndPoint, type: T.Type) async throws  -> T
}


final class DefaultNetworkService: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(apiEndPoint: any APIEndPoint, type: T.Type) async throws -> T {
        
        var request = URLRequest(url: apiEndPoint.baseURL.appendingPathComponent(apiEndPoint.path))
        request.httpMethod = apiEndPoint.method
        request.httpBody = apiEndPoint.httpBody
        
        apiEndPoint.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse , (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return  try JSONDecoder().decode(T.self, from: data)
        
    }
}

