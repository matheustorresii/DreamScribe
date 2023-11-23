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
    @State private var isShowingAnalyticsBottomsheet: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.dreamPink.ignoresSafeArea()
            buildViewForState()
            VStack(spacing: 0) {
                if case .content(let dreams) = viewModel.state, !dreams.isEmpty {
                    HomeFloatingButton(icon: "chart.bar.xaxis") {
                        isShowingAnalyticsBottomsheet = true
                    }
                }
                HomeFloatingButton(icon: "plus") {
                    didTapFloatingButton()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildViewForState() -> some View {
        switch viewModel.state {
        case .idle, .loading:
            LoadingView()
        case .content(let dreams):
            if dreams.isEmpty {
                HomeEmptyView()
            } else {
                buildListView(dreams: dreams)
                    .bottomsheet(state: $isShowingAnalyticsBottomsheet,
                                 innerView: HomeAnalyticsView(dreams: dreams).toAny())
            }
        case .error:
            ErrorView()
        }
    }
    
    @ViewBuilder
    private func buildListView(dreams: [DreamModel]) -> some View {
        ScrollView {
            ForEach(Array(dreams.enumerated()), id: \.offset) { (index, dream) in
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
