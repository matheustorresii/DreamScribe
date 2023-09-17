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
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildListView() -> some View {
        ScrollView {
            ForEach(Array(viewModel.dreams.enumerated()), id: \.offset) { (index, dream) in
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
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    navigation.send(.push(.analytics))
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                        .foregroundColor(.dreamPurple)
                }
            }
        }
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
