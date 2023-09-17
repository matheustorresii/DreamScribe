//
//  AppCoordinator.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    // MARK: - PUBLIC PROPERTIES
    
    @Published
    var path: NavigationPath
    
    // MARK: - PRIVATE PROPERTIES
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - INITIALIZERS
    
    init(path: NavigationPath) {
        self.path = path
    }
    
     // MARK: - PUBLIC METHODS
    
    @ViewBuilder
    func build(route: FlowRoute) -> some View {
        viewFor(route: route).toAny()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func viewFor(route: FlowRoute) -> any NavigableView {
        var view: any NavigableView
        switch route {
        case .home:
            view = HomeScreen()
        case .add:
            view = AddScreen()
        case .dream(let dream):
            view = DreamScreen(dream: dream)
        }
        bind(view: view)
        return view
    }
    
    private func navigate(_ style: FlowNavigationStyle) {
        switch style {
        case .push(let route):
            path.append(route)
        case .pop:
            path.removeLast()
        }
    }
    
    private func bind(view: any NavigableView) {
        view.navigation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] navigation in
                self?.navigate(navigation)
            }.store(in: &cancellables)
    }
}
