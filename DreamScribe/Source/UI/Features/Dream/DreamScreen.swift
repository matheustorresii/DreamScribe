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
                    Text(dream.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.dreamPurple)
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                    Text("Type of dream: ")
                        .fontWeight(.bold)
                    +
                    Text(dream.type.rawValue)
                    
                    Text("Tags:")
                        .fontWeight(.bold)
                    buildKeywordsList()
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(dream.date)
        .navigationBarTitleDisplayMode(.inline)
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

