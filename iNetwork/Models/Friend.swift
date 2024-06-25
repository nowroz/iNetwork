//
//  Friend.swift
//  iNetwork
//
//  Created by Nowroz Islam on 24/6/24.
//

import Foundation
import SwiftData

@Model
final class Friend: Decodable {
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
