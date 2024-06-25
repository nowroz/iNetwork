//
//  iNetworkApp.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftData
import SwiftUI

@main
struct iNetworkApp: App {
    @State private var pathState: PathState = PathState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.pathState, pathState)
        }
        .modelContainer(for: User.self)
    }
}
