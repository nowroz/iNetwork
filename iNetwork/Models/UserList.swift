//
//  UserList.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import Foundation
import SwiftUI

@Observable final class UserList {
    var users: [User] = []
    var userDictionary: [String: User] = [:]
    
    init() {
        Task { @MainActor in
            users = await DataLoader.load(from: "https://www.hackingwithswift.com/samples/friendface.json")
            
            for user in users {
                userDictionary[user.id] = user
            }
        }
    }
}

private struct UserListKey: EnvironmentKey {
    static var defaultValue: UserList = UserList()
}

extension EnvironmentValues {
    var userList: UserList {
        get { self[UserListKey.self] }
        set { self[UserListKey.self] = newValue }
    }
}
