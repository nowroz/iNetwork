//
//  PreviewSampleData.swift
//  iNetwork
//
//  Created by Nowroz Islam on 25/6/24.
//

import Foundation
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try ModelContainer(for: User.self, configurations: config)
        let context = container.mainContext
        
        if try context.fetch(FetchDescriptor<User>()).isEmpty {
            Task {
                let users: [User] = await DataLoader.load(from: "https://www.hackingwithswift.com/samples/friendface.json")
                
                users.forEach { container.mainContext.insert($0) }
            }
        }
        
        return container
    } catch {
        fatalError("Failed to create ModelContainer - \(error.localizedDescription)")
    }
}()
