//
//  ContentView.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.pathState) private var pathState
    
    @Query(sort: [
        SortDescriptor(\User.name),
        SortDescriptor(\User.company),
        SortDescriptor(\User.registered)
    ]) private var users: [User]
    
    var body: some View {
        @Bindable var pathState = pathState
        NavigationStack(path: $pathState.path) {
            List(users) { user in
                NavigationLink(value: user){
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.company)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .font(.caption2)
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("iNetwork")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user)
            }
            .task {
                if users.isEmpty {
                    print("users is empty")
                    let users: [User] = await DataLoader.load(from: "https://www.hackingwithswift.com/samples/friendface.json")
                    users.forEach{ modelContext.insert($0) }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
