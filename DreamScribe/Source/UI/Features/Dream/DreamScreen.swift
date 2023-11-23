//
//  DreamScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Combine
import SwiftUI

struct DreamScreen: View, NavigableView {
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    var dream: DreamModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.dreamPink.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text(dream.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.dreamPurple)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                    Text("Type of dream: ")
                        .fontWeight(.bold)
                        .foregroundColor(.dreamPurple)
                    +
                    Text(dream.type.rawValue)
                        .foregroundColor(.dreamPurple)
                    
                    Text("Tags:")
                        .fontWeight(.bold)
                        .foregroundColor(.dreamPurple)
                    buildKeywordsList()
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(dream.date)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.dreamPink, for: .navigationBar)
    }
    
    @ViewBuilder
    private func buildKeywordsList() -> some View {
        GeometryReader { geo in
            FlexibleView(availableWidth: geo.size.width,
                         data: dream.tags,
                         spacing: 8,
                         alignment: .leading) { item in
                Text(item)
                    .padding(8)
                    .foregroundColor(.dreamPink)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.dreamPurple))
            }
        }
    }
}

