//
//  ErrorView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 23/11/23.
//

import SwiftUI

struct ErrorView: View {
    var label: String?
    var icon: String?
    var action: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).ignoresSafeArea()
            VStack {
                Text("Error :(")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.dreamPurple)
                
                Button {
                    action?()
                } label: {
                    ZStack {
                        Color.dreamPurple
                        HStack {
                            Text(label ?? "")
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .foregroundColor(.dreamPink)
                            
                            Image(systemName: icon ?? "")
                                .font(.title.weight(.semibold))
                                .padding()
                                .foregroundColor(.dreamPink)
                        }
                    }
                }
                .frame(width: 250, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            }
        }
    }
}

#Preview {
    ErrorView()
}
