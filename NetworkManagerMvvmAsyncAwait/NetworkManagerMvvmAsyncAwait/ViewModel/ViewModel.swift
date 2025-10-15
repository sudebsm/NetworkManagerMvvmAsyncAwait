//
//  ViewModel.swift
//  NetworkManagerMvvmAsyncAwait
//
//  Created by Sudeb Sarkar on 14/10/25.
//
import Combine
import Foundation


final class ViewModel : ObservableObject {
    @Published var data: [Model] = []
    @Published var error: String?
    private let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func fetchData() {
        
        Task {
            do {
                let fetchedData = try await networkService.request(apiEndPoint: UserEndPoint.fetchUserData, type: [Model].self)
                self.data = fetchedData
            }catch (let err) {
                self.error = err.localizedDescription
            }
        }
    }
}
