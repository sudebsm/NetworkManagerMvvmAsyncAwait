//
//  NetworkManagerMvvmAsyncAwaitTests.swift
//  NetworkManagerMvvmAsyncAwaitTests
//
//  Created by Sudeb Sarkar on 14/10/25.
//

import XCTest
@testable import NetworkManagerMvvmAsyncAwait

@MainActor
final class NetworkManagerMvvmAsyncAwaitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
   
    
    func testFetchUsersSuccess() async throws  {
        let mockService = MockService()
        let mockUser = [Model(name: "xyz", email: "xyz@gmail.com", id: 1)]
        let data = try JSONEncoder().encode(mockUser)
        mockService.mockResult = .success(data)
        Task {
            let vm =  ViewModel(networkService: mockService)
            vm.fetchData()
            XCTAssertEqual(vm.data.count, 1)
        }
    }
     func testFetchUsersFailed() async  {
        let mockService = MockService()
         mockService.mockResult = .failure(URLError(.notConnectedToInternet))
        Task{
            let vm = ViewModel(networkService: mockService)
            vm.fetchData()
            XCTAssertTrue(vm.data.isEmpty)
        }
        
    }

}
