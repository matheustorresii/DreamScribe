//
//  ErrorView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            VStack {
                Text("Erro :(")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
            }
        }
    }
}

#Preview {
    ErrorView()
}
