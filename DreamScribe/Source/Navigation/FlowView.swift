//
//  FlowView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import SwiftUI

struct FlowView: View {
    @StateObject private var appCoordinator = AppCoordinator(path: .init())
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            if !isLoading {
                appCoordinator.build(route: .defaultRoute)
                    .navigationDestination(for: FlowRoute.self) { route in
                        appCoordinator.build(route: route)
                    }
            }
        }
        .overlay {
            if isLoading {
                LoadingView()
            }
        }
        .onAppear {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isLoading = false
            }
        }
        .environmentObject(appCoordinator)
        .environment(\.colorScheme, .light)
    }
}
