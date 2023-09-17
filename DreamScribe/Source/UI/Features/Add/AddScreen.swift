//
//  AddScreen.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import Combine
import SwiftUI

struct AddScreen: View, NavigableView {
    var navigation: PassthroughSubject<FlowNavigationStyle, Never> = .init()
    
    @State private var text: String = ""
    private let placeholder: String = "Write your dream here"
    
    var body: some View {
        ZStack {
            Color.dreamPink.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 8) {
                    buildTextEditor()
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("New Dream")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.dreamPink, for: .navigationBar)
    }
    
    @ViewBuilder
    private func buildTextEditor() -> some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                    .disabled(true)
                    .padding(.horizontal, 8)
            }
            
            TextEditor(text: $text)
                .frame(minHeight: 35, alignment: .leading)
                .foregroundColor(.dreamPurple)
                .multilineTextAlignment(.leading)
                .opacity(text.isEmpty ? 0.5 : 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
    }
}

