//
//  FlowRoute.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import Foundation

enum FlowNavigationStyle {
    case push(FlowRoute)
    case pop
}

enum FlowRoute {
    case home
    case add
    case dream(DreamModel)
    
    static var defaultRoute: FlowRoute {
        return .home
    }
}

extension FlowRoute: Hashable {
    static func == (lhs: FlowRoute, rhs: FlowRoute) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home), (.add, .add), (.dream, .dream):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine(1)
        case .add:
            hasher.combine(2)
        case .dream:
            hasher.combine(3)
        }
    }
}
