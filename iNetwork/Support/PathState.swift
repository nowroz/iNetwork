//
//  PathState.swift
//  iNetwork
//
//  Created by Nowroz Islam on 24/6/24.
//

import Foundation
import SwiftUI

@Observable final class PathState {
    var path: [User] = []
}

private struct PathStateKey: EnvironmentKey {
    static var defaultValue: PathState = PathState()
}

extension EnvironmentValues {
    var pathState: PathState {
        get { self[PathStateKey.self] }
        set { self[PathStateKey.self] = newValue }
    }
}
