//
//  BottomsheetModifier.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import SwiftUI

struct BottomsheetModifier: ViewModifier {
    @Binding var state: Bool
    var innerView: AnyView
    
    @State private var sheetHeight: CGFloat = .zero
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $state) {
                innerView
                .padding(.all, 16)
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) {
                    sheetHeight = $0
                }
                .presentationDetents([.height(sheetHeight)])
            }
    }
}

extension View {
    func bottomsheet(state: Binding<Bool>, innerView: AnyView) -> some View {
        modifier(BottomsheetModifier(state: state, innerView: innerView))
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
