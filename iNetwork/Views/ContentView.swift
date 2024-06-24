//
//  ContentView.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.pathState) private var pathState
    @Environment(\.userList) private var userList
    
    var body: some View {
        @Bindable var pathState = pathState
        NavigationStack(path: $pathState.path) {
            List(userList.users) { user in
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
        }
    }
}

#Preview {
    ContentView()
}
