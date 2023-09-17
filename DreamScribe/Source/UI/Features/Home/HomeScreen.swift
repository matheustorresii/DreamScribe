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
    
    private let viewModel: HomeViewModel
    
    // MARK: - INITIALIZERS
    
    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                if viewModel.dreams.isEmpty {
                    HomeEmptyView()
                } else {
                    buildListView()
                }
            }
        }
    }
    
    // MARK: - PRIVATE METHODS
    
    @ViewBuilder
    private func buildListView() -> some View {
        
    }
}
