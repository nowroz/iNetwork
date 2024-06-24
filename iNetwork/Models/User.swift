//
//  User.swift
//  iNetwork
//
//  Created by Nowroz Islam on 22/6/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    struct Friend: Identifiable, Codable, Hashable {
        let id: String
        let name: String
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let registered: Date
    let friends: [Friend]
}
