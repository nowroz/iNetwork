//
//  UserListView.swift
//  iNetwork
//
//  Created by Nowroz Islam on 4/7/24.
//

import SwiftData
import SwiftUI

struct UserListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [
        SortDescriptor(\User.name),
        SortDescriptor(\User.company),
        SortDescriptor(\User.registered)
    ]) var users: [User]
    
    var body: some View {
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
    
    init(sortOrder: [SortDescriptor<User>]) {
        _users = Query(sort: sortOrder)
    }
}

#Preview {
    struct PreviewUserListView: View {
        @Environment(\.pathState) private var pathState
        
        @State private var sortOrder: [SortDescriptor] = [
            SortDescriptor(\User.name),
            SortDescriptor(\User.company),
            SortDescriptor(\User.registered)
        ]
        
        var body: some View {
            @Bindable var pathState = pathState
            NavigationStack(path: $pathState.path) {
                UserListView(sortOrder: sortOrder)
                    .navigationTitle("iNetwork")
                    .toolbar {
                        Menu {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by name").tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.company),
                                    SortDescriptor(\User.registered)
                                ])
                                
                                Text("Sort by company").tag([
                                    SortDescriptor(\User.company),
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.registered)
                                ])
                            }
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                    }
            }
        }
    }
    
    return PreviewUserListView()
        .modelContainer(previewContainer)
}
