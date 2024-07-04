//
//  ContentView.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
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

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
