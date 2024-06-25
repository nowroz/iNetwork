//
//  UserDetailView.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftData
import SwiftUI

struct UserDetailView: View {
    @Environment(\.pathState) private var pathState
    
    @Query private var users: [User]
    
    var user: User
    
    var body: some View {
        List {
            Section {
                labeledText(label: "Name", systemImage: "person.fill", text: user.name)
                
                labeledText(label: "Email", systemImage: "envelope.fill", text: user.email)
                
                labeledText(label: "Age", systemImage: "number", text: user.age.formatted())
                
                labeledText(label: "Company", systemImage: "bag.fill", text: user.company)
                
                labeledText(label: "Date Registered", systemImage: "calendar.badge.plus", text: user.registered.formatted(date: .abbreviated, time: .omitted))
                
                labeledText(label: "Status", systemImage: "antenna.radiowaves.left.and.right", text: user.isActive ? "Online" : "Offline")
            }
            
            
            Section("Address") {
                Text(user.address)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    let connectedUser = getUser(friend.id)
                    return NavigationLink(value: connectedUser){
                        HStack {
                            Text(connectedUser.name)
                            
                            Spacer()
                            
                            Image(systemName: "circle.fill")
                                .font(.caption2)
                                .foregroundStyle(connectedUser.isActive ? .green : .red)
                        }
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Home", systemImage: "house") {
                pathState.path = []
            }
        }
    }
    
    func labeledText(label: String, systemImage: String? = nil, text: String) -> some View  {
        LabeledContent {
            Text(text)
                .foregroundStyle(.primary)
        } label: {
            if let systemImage {
                Label(label, systemImage: systemImage)
                    .foregroundStyle(.secondary)
            } else {
                Text(label)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    func getUser(_ id: String) -> User {
        guard let user = users.first(where: { $0.id == id }) else {
            fatalError("No user matched the id - \(id)")
        }
        
        return user
    }
}

#Preview {
    struct PreviewUserDetailView: View {
        @Query private var users: [User]
        
        var body: some View {
            UserDetailView(user: users[0])
        }
    }
    
    return NavigationStack {
        PreviewUserDetailView()
            .modelContainer(previewContainer)
    }
}
