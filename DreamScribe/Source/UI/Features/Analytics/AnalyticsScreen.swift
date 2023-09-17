//
//  AnalyticsScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Combine
import Charts
import SwiftUI

struct AnalyticsScreen: View, NavigableView {
    // MARK: - PUBLIC PROPERTIES
    
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    // MARK: - PRIVATE PROPERTIES
    
    private var viewModel: AnalyticsViewModel = .init()
    
    // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.dreamPink.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    buildGraph()
                    Text("Most frequent tag:")
                        .fontWeight(.bold)
                        .foregroundColor(.dreamPurple)
                    Text(viewModel.getMostRepeatedTag())
                        .fontWeight(.bold)
                        .font(.system(size: 28))
                        .foregroundColor(.dreamPurple)
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Analytics")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.dreamPink, for: .navigationBar)
    }
    
    @ViewBuilder
    private func buildGraph() -> some View {
        Chart {
            ForEach(DreamType.allCases, id: \.self) { type in
                BarMark(x: .value("Type", type.rawValue),
                        y: .value("Total", viewModel.getCountFor(type: type)))
            }
        }
    }
}

struct AnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsScreen()
    }
}
