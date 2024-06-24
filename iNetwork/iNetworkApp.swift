//
//  iNetworkApp.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import SwiftUI

@main
struct iNetworkApp: App {
    @State private var pathState: PathState = PathState()
    @State private var userList: UserList = UserList()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.userList, userList)
                .environment(\.pathState, pathState)
        }
    }
}
