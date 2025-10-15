//
//  ContentView.swift
//  NetworkManagerMvvmAsyncAwait
//
//  Created by Sudeb Sarkar on 14/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        
        NavigationView {
            List(viewModel.data){ user in
                Text(user.name)
            }
            .task {
                viewModel.fetchData()
            }
        }
    }
}

#Preview {
    ContentView()
}
