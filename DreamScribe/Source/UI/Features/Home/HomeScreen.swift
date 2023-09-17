//
//  HomeScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 16/09/23.
//

import Combine
import SwiftUI
struct HomeScreen: View, NavigableView {
    
    // MARK: - PUBLIC PROPERTIES
    
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    // MARK: - PRIVATE PROPERTIES
    
    @ObservedObject private var viewModel: HomeViewModel = .init()
    
    // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.dreamPink.ignoresSafeArea()
            if viewModel.dreams.isEmpty {
                HomeEmptyView()
            } else {
                buildListView()
            }
            HomeFloatingButton {
                didTapFloatingButton()
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildListView() -> some View {
        ScrollView {
            ForEach(viewModel.dreams, id: \.id) { dream in
                HomeItemView(dream: dream, didTapDream: { dream in
                    didTapDream(dream)
                }, didRemoveDream: { dream in
                    didRemoveDream(dream)
                })
                .padding(.vertical, 8)
            }
            .onDelete { index in
                print(index)
            }
        }
        .padding(.horizontal, 16)
        .navigationTitle("DreamScribe")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.dreamPink, for: .navigationBar)
    }
    
    private func didTapDream(_ dream: DreamModel) {
        navigation.send(.push(.dream(dream)))
    }
    
    private func didRemoveDream(_ dream: DreamModel) {
        withAnimation {
            viewModel.removeDream(dream)
        }
    }
    
    private func didTapFloatingButton() {
        navigation.send(.push(.add))
    }
}
