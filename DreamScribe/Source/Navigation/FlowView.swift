//
//  FlowView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import SwiftUI

struct FlowView: View {
    @StateObject private var appCoordinator = AppCoordinator(path: .init())
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(route: .defaultRoute)
                .navigationDestination(for: FlowRoute.self) { route in
                    appCoordinator.build(route: route)
                }
        }
        .environmentObject(appCoordinator)
    }
}
