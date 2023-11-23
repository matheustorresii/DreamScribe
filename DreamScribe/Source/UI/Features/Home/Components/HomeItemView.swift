//
//  HomeItemView.swift
//  DreamScribe
//
//  Created by Matheus Torres on 17/09/23.
//

import SwiftUI

struct HomeItemView: View {
    var dream: DreamModel
    var didTapDream: ((DreamModel) -> Void)?
    var didRemoveDream: ((DreamModel) -> Void)?
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dream.date)
                .foregroundColor(.dreamPurple)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(dream.text)
                .foregroundColor(.dreamPurple)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .onTapGesture {
            didTapDream?(dream)
        }
        .onLongPressGesture {
            showingAlert.toggle()
        }
        .alert("Delete this dream?", isPresented: $showingAlert) {
            Button("Delete", role: .destructive) {
                didRemoveDream?(dream)
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

struct HomeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.dreamPink
            VStack(spacing: 16) {
                HomeItemView(dream: mockDreams[0])
                HomeItemView(dream: mockDreams[1])
                HomeItemView(dream: mockDreams[2])
            }
            .padding(.horizontal, 8)
        }
    }
}
