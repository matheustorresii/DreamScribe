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
    
    static var defaultRoute: FlowRoute {
        return .home
    }
}

extension FlowRoute: Hashable {
    static func == (lhs: FlowRoute, rhs: FlowRoute) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine(1)
        }
    }
}
